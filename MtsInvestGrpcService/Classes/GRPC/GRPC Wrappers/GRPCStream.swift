//
//  GRPCStream.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 13.07.2021.
//

import Foundation
import GRPC
import NIOHPACK

/**
 Обертка для GRPC стримов. Для получения сообщений необходимо  подписаться на свойство *observable*
 - **StreamType** — тип сгенерированного GRPC стрима
 - **Response** — тип получаемого ответа
 */
final class GRPCStream<StreamType, Response> {
    typealias BuilderFunction = (
        _ metadata: HPACKHeaders,
        _ completion: @escaping (CallResult) -> Void
    ) throws -> StreamType?
    
    typealias ReceiveFunction = (
        _ stream: StreamType,
        _ innerCompletion: @escaping (ResultOrRPCError<Response?>) -> Void
    ) throws -> Void

    
    /// Правила валидации на пришедящих данных
    enum NilResponseValidationPolicy {
        case allowed
        case notAllowed
    }
    
    /// События стриминга
    enum Event {
        case receivedData(object: Response?)
        case messageFromClientSuccessfullySent
    }
    
    let observable: Observable<Event>
    
    private var stream: StreamType?
    private var closeStreamHandler: ((StreamType?) -> Void)?
    private let responseValidationPolicy: NilResponseValidationPolicy
    private var builder: BuilderFunction?
    private var metadata: HPACKHeaders?
    private var receive: ReceiveFunction?
    
    var isCreated: Bool { stream != nil }
    
    //MARK: - Initialization
    init(responseValidationPolicy: NilResponseValidationPolicy) {
        self.responseValidationPolicy = responseValidationPolicy
        self.stream = nil
        self.closeStreamHandler = nil
        self.observable = .init()
    }
    
    deinit {
        close()
        observable.removeAllObservables()
    }
    
    //MARK: - Private
    private func handle(statusCode: GRPCStatus.Code) {
        switch statusCode {
        case .ok:
            break
        default:
            switch statusCode {
            case .cancelled:
                break
            case .deadlineExceeded,
                 .unknown:
                restart()
            default:
                if let error = GRPCMTSHelper.convertStatusCodeToAppError(statusCode) {
                    observable.onError(error)
                } else {
                    observable.onError(AppError.serialization)
                }
                close()
            }
        }
    }
    
    private func handle(rpcError: RPCError) {
        switch rpcError {
        case .callError(let callResult):
            handle(statusCode: callResult.statusCode)
        case .invalidMessageReceived,
             .timedOut:
            observable.onError(AppError.serialization)
            close()
        }
    }

    //MARK: - Lifecycle
    private func restart() {
        guard let meta = metadata,
              let builderFunction = builder,
              let receiveFunction = receive else {
            return
        }
        print("******* GRPCStream<\(StreamType.self)> restart")
        
        close()
        create(
            metadata: meta,
            builder: builderFunction
        )
        .receive(body: receiveFunction)
    }
    
    /// Установка замыкания, описывающего закрытие стриминга
    /// - Parameter handler: замыкание, передающее параметром существующий стрим
    @discardableResult
    func setCloseHandler(_ handler: @escaping (_ stream: StreamType?) -> Void) -> Self {
        closeStreamHandler = handler
        return self
    }
    
    /// Создание стрима
    /// - Parameters:
    ///   - metadata: любая метадата, необходимая для создания стрима. Имеет значение по умолчанию равное *.authorization()*
    ///   - builder: замыкание, передающее метадату и замыкание для захвата результата создания стрима
    @discardableResult
    func create(
        metadata: Metadata = .authorization(),
        builder: @escaping BuilderFunction
    ) -> Self {
        self.metadata = metadata
        self.builder = builder
        do {
            stream = try builder(metadata, { [weak self] callResult in
                print("******* GRPCStream<\(StreamType.self)> created with result = \(callResult)")
                self?.handle(statusCode: callResult.statusCode)
            })
        } catch {
            observable.onError(AppError.serialization)
            close()
        }
        return self
    }
 
    /// Закроет текущий стрим
    func close() {
        closeStreamHandler?(stream)
        stream = nil
        builder = nil
        metadata = nil
        receive = nil
        print("******* GRPCStream<\(StreamType.self)> closed")
    }
    
    //MARK: - Stream
    /// Подписка на получение данных от созданного стрима
    /// - Parameter body: замыкание, передающее существующий стрим и замыкание, захватывающее приходящее сообщение
    @discardableResult
    func receive(
        body: @escaping (
            _ stream: StreamType,
            _ innerCompletion: @escaping (ResultOrRPCError<Response?>) -> Void
        ) throws -> Void
    ) -> Self {
        guard let streamObject = stream else { return self }
        self.receive = body
        do {
            try body(
                streamObject,
                { [weak self] resultOrError in
                    print("******* GRPCStream<\(StreamType.self)> received: \(resultOrError)")
                    
                    guard let self = self else { return }
                    switch resultOrError {
                    case .error(let rpcError):
                        self.handle(rpcError: rpcError)
                    case .result(let response):
                        switch self.responseValidationPolicy {
                        case .notAllowed:
                            guard let object = response else {
                                return
                            }
                            self.observable.onNext(.receivedData(object: object))
                            self.receive(body: body)
                        case .allowed:
                            self.observable.onNext(.receivedData(object: response))
                            if response != nil {
                                self.receive(body: body)
                            }
                        }
                    }
                }
            )
        } catch let error {
            let callError = error as? CallError
            switch callError {
            case .tooManyOperations:
                break
            default:
                observable.onError(AppError.serialization)
                close()
            }
        }
        return self
    }
    
    /// Отправляет новое сообщение от клиента на сервер
    /// - Parameter body: замыкание, передающее существующий стрим и замыкание, захватывающее результат отправки сообщения
    @discardableResult
    func send(
        body: @escaping (
            _ stream: StreamType,
            _ innerCompletion: @escaping (Error?) -> Void
        ) throws -> Void
    ) -> Self {
        guard let streamObject = stream else { return self }
        do {
            try body(
                streamObject, { [weak self] error in
                    if let _ = error {
                        self?.observable.onError(AppError.serialization)
                    } else {
                        self?.observable.onNext(.messageFromClientSuccessfullySent)
                    }
                }
            )
        } catch {
            observable.onError(AppError.serialization)
        }
        return self
    }
}

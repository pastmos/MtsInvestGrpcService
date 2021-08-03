//
//  Observable.swift
//  MtsInvestGrpcService
//
//  Created by Юрий Султанов on 20.07.2021.
//

protocol ObservableDelegate: AnyObject {
    func subscriptonsDidChange(
        at streamType: INVStreamType,
        hasSubscribers: Bool)
    func shouldRefresh(streamType: INVStreamType)
}

final class Observable<Element: Equatable> {
    private class ObserverWrapper {
        weak var observer: AnyObject?
        let notifyHandler: (Result<Element?, INVError>) -> Void
        
        init(observer: AnyObject,
             onNext: @escaping (Result<Element?, INVError>) -> Void) {
            self.observer = observer
            self.notifyHandler = onNext
        }
    }
    
    weak var delegate: ObservableDelegate?
    var hasSubscribers: Bool { return !subscriptions.isEmpty }
    private var subscriptions: [ObserverWrapper] {
        didSet {
            if subscriptions.count != oldValue.count {
                delegate?.subscriptonsDidChange(
                    at: streamType,
                    hasSubscribers: hasSubscribers)
            }
        }
    }
    private(set) var value: Element?
    private let streamType: INVStreamType
    
    //MARK: - Initialization
    init(streamType: INVStreamType) {
        value = nil
        subscriptions = [ObserverWrapper]()
        self.streamType = streamType
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    //MARK: - Modify
    private func send(_ result: Result<Element?, INVError>) {
        DispatchQueue.main.async { [weak self] in
            self?.removeNilObserverCallbacks()
            self?.subscriptions.forEach { $0.notifyHandler(result) }
        }
    }
    
    public func onNext(_ value: Element?) {
        self.value = value
        send(.success(value))
    }
    
    public func onError(_ error: INVError) {
        send(.failure(error))
    }
    
    //MARK: - Management
    private func removeNilObserverCallbacks() {
        subscriptions.removeAll { $0.observer == nil }
    }
    
    private func remove(_ observer: AnyObject) {
        subscriptions.removeAll { $0.observer === observer }
        subscriptions.removeAll { $0.observer == nil }
    }
    
    func unSubscribe(_ observer: AnyObject) {
        remove(observer)
    }
    
    func subscribe(
        _ observer: AnyObject,
        event: @escaping (Result<Element?, INVError>) -> Void) {
        guard !subscriptions.contains(where: { $0.observer === observer }) else {
            delegate?.shouldRefresh(streamType: streamType)
            return
        }
        let wrapper = ObserverWrapper(
            observer: observer,
            onNext: event)
        subscriptions.append(wrapper)
    }
    
    func removeAllObservables() {
        subscriptions.removeAll()
    }
}

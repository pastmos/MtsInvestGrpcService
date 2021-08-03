//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: instruments-v2-public.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate `Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClient`, then call methods of this protocol to make API calls.
internal protocol Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClientInterceptorFactoryProtocol? { get }

  func getInstrument(
    _ request: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest, Ru_Mts_Trading_Grpc_Pub_Instruments_V2_Instrument>

  func getExchangeStatus(
    _ request: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest, Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusResponse>
}

extension Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClientProtocol {
  internal var serviceName: String {
    return "ru.mts.trading.grpc.pub.instruments.v2.InstrumentsPublicService"
  }

  ///метод для запроса информации об инструменте
  ///
  /// - Parameters:
  ///   - request: Request to send to getInstrument.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getInstrument(
    _ request: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest, Ru_Mts_Trading_Grpc_Pub_Instruments_V2_Instrument> {
    return self.makeUnaryCall(
      path: "/ru.mts.trading.grpc.pub.instruments.v2.InstrumentsPublicService/getInstrument",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makegetInstrumentInterceptors() ?? []
    )
  }

  ///метод для запроса статуса биржи
  ///
  /// - Parameters:
  ///   - request: Request to send to getExchangeStatus.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getExchangeStatus(
    _ request: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest, Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusResponse> {
    return self.makeUnaryCall(
      path: "/ru.mts.trading.grpc.pub.instruments.v2.InstrumentsPublicService/getExchangeStatus",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makegetExchangeStatusInterceptors() ?? []
    )
  }
}

internal protocol Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'getInstrument'.
  func makegetInstrumentInterceptors() -> [ClientInterceptor<Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest, Ru_Mts_Trading_Grpc_Pub_Instruments_V2_Instrument>]

  /// - Returns: Interceptors to use when invoking 'getExchangeStatus'.
  func makegetExchangeStatusInterceptors() -> [ClientInterceptor<Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest, Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusResponse>]
}

internal final class Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClient: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the ru.mts.trading.grpc.pub.instruments.v2.InstrumentsPublicService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_InstrumentsPublicServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

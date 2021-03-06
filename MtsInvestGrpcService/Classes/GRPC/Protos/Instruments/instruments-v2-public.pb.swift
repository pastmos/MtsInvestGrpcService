// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: instruments-v2-public.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum Ru_Mts_Trading_Grpc_Pub_Instruments_V2_ExchangeState: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case `open` // = 0
  case closed // = 1
  case UNRECOGNIZED(Int)

  init() {
    self = .open
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .open
    case 1: self = .closed
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .open: return 0
    case .closed: return 1
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Ru_Mts_Trading_Grpc_Pub_Instruments_V2_ExchangeState: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Ru_Mts_Trading_Grpc_Pub_Instruments_V2_ExchangeState] = [
    .open,
    .closed,
  ]
}

#endif  // swift(>=4.2)

struct Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var instrumentID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var instrumentID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///???????????? ??????????
  var exchangeState: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_ExchangeState = .open

  ///?????????? ???? ?????????? ?????????????? ?? ????????.
  var millisecondsToStatusChange: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "ru.mts.trading.grpc.pub.instruments.v2"

extension Ru_Mts_Trading_Grpc_Pub_Instruments_V2_ExchangeState: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "OPEN"),
    1: .same(proto: "CLOSED"),
  ]
}

extension Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetInstrumentRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "instrumentId"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.instrumentID)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.instrumentID.isEmpty {
      try visitor.visitSingularStringField(value: self.instrumentID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest, rhs: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetInstrumentRequest) -> Bool {
    if lhs.instrumentID != rhs.instrumentID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetExchangeStatusRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "instrumentId"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.instrumentID)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.instrumentID.isEmpty {
      try visitor.visitSingularStringField(value: self.instrumentID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest, rhs: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusRequest) -> Bool {
    if lhs.instrumentID != rhs.instrumentID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetExchangeStatusResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "exchangeState"),
    2: .same(proto: "millisecondsToStatusChange"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularEnumField(value: &self.exchangeState)
      case 2: try decoder.decodeSingularUInt64Field(value: &self.millisecondsToStatusChange)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.exchangeState != .open {
      try visitor.visitSingularEnumField(value: self.exchangeState, fieldNumber: 1)
    }
    if self.millisecondsToStatusChange != 0 {
      try visitor.visitSingularUInt64Field(value: self.millisecondsToStatusChange, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusResponse, rhs: Ru_Mts_Trading_Grpc_Pub_Instruments_V2_GetExchangeStatusResponse) -> Bool {
    if lhs.exchangeState != rhs.exchangeState {return false}
    if lhs.millisecondsToStatusChange != rhs.millisecondsToStatusChange {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

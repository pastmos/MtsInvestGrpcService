// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: date.proto
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

struct GrpcDate {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    var year: UInt32 = 0
    
    ///1..12
    var month: UInt32 = 0
    
    ///1..31
    var day: UInt32 = 0
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
    init() {}
}

struct GrpcDateTime {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    var date: GrpcDate {
        get {return _storage._date ?? GrpcDate()}
        set {_uniqueStorage()._date = newValue}
    }
    /// Returns true if `date` has been explicitly set.
    var hasDate: Bool {return _storage._date != nil}
    /// Clears the value of `date`. Subsequent reads from it will return its default value.
    mutating func clearDate() {_uniqueStorage()._date = nil}
    
    ///0..23
    var hour: UInt32 {
        get {return _storage._hour}
        set {_uniqueStorage()._hour = newValue}
    }
    
    ///0..59
    var minute: UInt32 {
        get {return _storage._minute}
        set {_uniqueStorage()._minute = newValue}
    }
    
    ///0..59
    var second: UInt32 {
        get {return _storage._second}
        set {_uniqueStorage()._second = newValue}
    }
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
    init() {}
    
    fileprivate var _storage = _StorageClass.defaultInstance
}

///
///example: UTC+07:00, Europe/Moscow
struct GrpcTZoneId {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    var value: String = String()
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
    init() {}
}

struct GrpcOptionalDate {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    var hasValue_p: Bool {
        get {return _storage._hasValue_p}
        set {_uniqueStorage()._hasValue_p = newValue}
    }
    
    var value: GrpcDate {
        get {return _storage._value ?? GrpcDate()}
        set {_uniqueStorage()._value = newValue}
    }
    /// Returns true if `value` has been explicitly set.
    var hasValue: Bool {return _storage._value != nil}
    /// Clears the value of `value`. Subsequent reads from it will return its default value.
    mutating func clearValue() {_uniqueStorage()._value = nil}
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
    init() {}
    
    fileprivate var _storage = _StorageClass.defaultInstance
}

struct GrpcOptionalDateTime {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.
    
    var hasValue_p: Bool {
        get {return _storage._hasValue_p}
        set {_uniqueStorage()._hasValue_p = newValue}
    }
    
    var value: GrpcDateTime {
        get {return _storage._value ?? GrpcDateTime()}
        set {_uniqueStorage()._value = newValue}
    }
    /// Returns true if `value` has been explicitly set.
    var hasValue: Bool {return _storage._value != nil}
    /// Clears the value of `value`. Subsequent reads from it will return its default value.
    mutating func clearValue() {_uniqueStorage()._value = nil}
    
    var unknownFields = SwiftProtobuf.UnknownStorage()
    
    init() {}
    
    fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension GrpcDate: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = "Date"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "year"),
        2: .same(proto: "month"),
        3: .same(proto: "day"),
    ]
    
    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularUInt32Field(value: &self.year)
            case 2: try decoder.decodeSingularUInt32Field(value: &self.month)
            case 3: try decoder.decodeSingularUInt32Field(value: &self.day)
            default: break
            }
        }
    }
    
    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        if self.year != 0 {
            try visitor.visitSingularUInt32Field(value: self.year, fieldNumber: 1)
        }
        if self.month != 0 {
            try visitor.visitSingularUInt32Field(value: self.month, fieldNumber: 2)
        }
        if self.day != 0 {
            try visitor.visitSingularUInt32Field(value: self.day, fieldNumber: 3)
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static func ==(lhs: GrpcDate, rhs: GrpcDate) -> Bool {
        if lhs.year != rhs.year {return false}
        if lhs.month != rhs.month {return false}
        if lhs.day != rhs.day {return false}
        if lhs.unknownFields != rhs.unknownFields {return false}
        return true
    }
}

extension GrpcDateTime: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = "DateTime"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "date"),
        2: .same(proto: "hour"),
        3: .same(proto: "minute"),
        4: .same(proto: "second"),
    ]
    
    fileprivate class _StorageClass {
        var _date: GrpcDate? = nil
        var _hour: UInt32 = 0
        var _minute: UInt32 = 0
        var _second: UInt32 = 0
        
        static let defaultInstance = _StorageClass()
        
        private init() {}
        
        init(copying source: _StorageClass) {
            _date = source._date
            _hour = source._hour
            _minute = source._minute
            _second = source._second
        }
    }
    
    fileprivate mutating func _uniqueStorage() -> _StorageClass {
        if !isKnownUniquelyReferenced(&_storage) {
            _storage = _StorageClass(copying: _storage)
        }
        return _storage
    }
    
    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        _ = _uniqueStorage()
        try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
            while let fieldNumber = try decoder.nextFieldNumber() {
                switch fieldNumber {
                case 1: try decoder.decodeSingularMessageField(value: &_storage._date)
                case 2: try decoder.decodeSingularUInt32Field(value: &_storage._hour)
                case 3: try decoder.decodeSingularUInt32Field(value: &_storage._minute)
                case 4: try decoder.decodeSingularUInt32Field(value: &_storage._second)
                default: break
                }
            }
        }
    }
    
    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
            if let v = _storage._date {
                try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
            }
            if _storage._hour != 0 {
                try visitor.visitSingularUInt32Field(value: _storage._hour, fieldNumber: 2)
            }
            if _storage._minute != 0 {
                try visitor.visitSingularUInt32Field(value: _storage._minute, fieldNumber: 3)
            }
            if _storage._second != 0 {
                try visitor.visitSingularUInt32Field(value: _storage._second, fieldNumber: 4)
            }
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static func ==(lhs: GrpcDateTime, rhs: GrpcDateTime) -> Bool {
        if lhs._storage !== rhs._storage {
            let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
                let _storage = _args.0
                let rhs_storage = _args.1
                if _storage._date != rhs_storage._date {return false}
                if _storage._hour != rhs_storage._hour {return false}
                if _storage._minute != rhs_storage._minute {return false}
                if _storage._second != rhs_storage._second {return false}
                return true
            }
            if !storagesAreEqual {return false}
        }
        if lhs.unknownFields != rhs.unknownFields {return false}
        return true
    }
}

extension GrpcTZoneId: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = "TZoneId"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "value"),
    ]
    
    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            switch fieldNumber {
            case 1: try decoder.decodeSingularStringField(value: &self.value)
            default: break
            }
        }
    }
    
    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        if !self.value.isEmpty {
            try visitor.visitSingularStringField(value: self.value, fieldNumber: 1)
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static func ==(lhs: GrpcTZoneId, rhs: GrpcTZoneId) -> Bool {
        if lhs.value != rhs.value {return false}
        if lhs.unknownFields != rhs.unknownFields {return false}
        return true
    }
}

extension GrpcOptionalDate: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = "OptionalDate"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "hasValue"),
        2: .same(proto: "value"),
    ]
    
    fileprivate class _StorageClass {
        var _hasValue_p: Bool = false
        var _value: GrpcDate? = nil
        
        static let defaultInstance = _StorageClass()
        
        private init() {}
        
        init(copying source: _StorageClass) {
            _hasValue_p = source._hasValue_p
            _value = source._value
        }
    }
    
    fileprivate mutating func _uniqueStorage() -> _StorageClass {
        if !isKnownUniquelyReferenced(&_storage) {
            _storage = _StorageClass(copying: _storage)
        }
        return _storage
    }
    
    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        _ = _uniqueStorage()
        try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
            while let fieldNumber = try decoder.nextFieldNumber() {
                switch fieldNumber {
                case 1: try decoder.decodeSingularBoolField(value: &_storage._hasValue_p)
                case 2: try decoder.decodeSingularMessageField(value: &_storage._value)
                default: break
                }
            }
        }
    }
    
    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
            if _storage._hasValue_p != false {
                try visitor.visitSingularBoolField(value: _storage._hasValue_p, fieldNumber: 1)
            }
            if let v = _storage._value {
                try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
            }
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static func ==(lhs: GrpcOptionalDate, rhs: GrpcOptionalDate) -> Bool {
        if lhs._storage !== rhs._storage {
            let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
                let _storage = _args.0
                let rhs_storage = _args.1
                if _storage._hasValue_p != rhs_storage._hasValue_p {return false}
                if _storage._value != rhs_storage._value {return false}
                return true
            }
            if !storagesAreEqual {return false}
        }
        if lhs.unknownFields != rhs.unknownFields {return false}
        return true
    }
}

extension GrpcOptionalDateTime: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    static let protoMessageName: String = "OptionalDateTime"
    static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "hasValue"),
        2: .same(proto: "value"),
    ]
    
    fileprivate class _StorageClass {
        var _hasValue_p: Bool = false
        var _value: GrpcDateTime? = nil
        
        static let defaultInstance = _StorageClass()
        
        private init() {}
        
        init(copying source: _StorageClass) {
            _hasValue_p = source._hasValue_p
            _value = source._value
        }
    }
    
    fileprivate mutating func _uniqueStorage() -> _StorageClass {
        if !isKnownUniquelyReferenced(&_storage) {
            _storage = _StorageClass(copying: _storage)
        }
        return _storage
    }
    
    mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        _ = _uniqueStorage()
        try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
            while let fieldNumber = try decoder.nextFieldNumber() {
                switch fieldNumber {
                case 1: try decoder.decodeSingularBoolField(value: &_storage._hasValue_p)
                case 2: try decoder.decodeSingularMessageField(value: &_storage._value)
                default: break
                }
            }
        }
    }
    
    func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
            if _storage._hasValue_p != false {
                try visitor.visitSingularBoolField(value: _storage._hasValue_p, fieldNumber: 1)
            }
            if let v = _storage._value {
                try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
            }
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static func ==(lhs: GrpcOptionalDateTime, rhs: GrpcOptionalDateTime) -> Bool {
        if lhs._storage !== rhs._storage {
            let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
                let _storage = _args.0
                let rhs_storage = _args.1
                if _storage._hasValue_p != rhs_storage._hasValue_p {return false}
                if _storage._value != rhs_storage._value {return false}
                return true
            }
            if !storagesAreEqual {return false}
        }
        if lhs.unknownFields != rhs.unknownFields {return false}
        return true
    }
}

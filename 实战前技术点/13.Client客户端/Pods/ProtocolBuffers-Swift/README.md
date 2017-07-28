#Protocol Buffers for Swift

[![Build Status](https://travis-ci.org/alexeyxo/protobuf-swift.svg?branch=master)](https://travis-ci.org/alexeyxo/protobuf-swift) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Version](http://img.shields.io/cocoapods/v/ProtocolBuffers-Swift.svg)](http://cocoapods.org/?q=ProtocolBuffers-Swift) [![Platform](http://img.shields.io/cocoapods/p/ProtocolBuffers-Swift.svg)](http://cocoapods.org/?q=ProtocolBuffers)

An implementation of Protocol Buffers in Swift.

Protocol Buffers are a way of encoding structured data in an efficient yet extensible format. This project is based on an implementation of Protocol Buffers from Google. See the [Google protobuf project](https://developers.google.com/protocol-buffers/docs/overview) for more information.

####Required Protocol Buffers 3.0

##How To Install Protobuf Compiler on Linux(Ubuntu 14.04)

1.`wget https://github.com/google/protobuf/archive/v3.1.0.tar.gz`

2.`tar xzf v3.1.0.tar.gz`

3.`cd protobuf-3.1.0/`

4.`sudo apt-get install autoreconf automake libtool make`

5.`./autogen.sh`

6.`./configure CXXFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib`

7.`sudo make && sudo make install`

8.`cd .. && wget https://github.com/alexeyxo/protobuf-swift/archive/3.0.5.tar.gz && tar xzf 3.0.5.tar.gz && cd protobuf-swift-3.0.5`

9.`./script/build.sh && swift build`
 
##How To Install Protobuf Compiler from Homebrew

1.`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

2.`brew install protobuf-swift`

##How To Install Protobuf Compiler

1.`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

2.`brew install automake`

3.`brew install libtool`

4.`brew install protobuf`

5.`git clone git@github.com:alexeyxo/protobuf-swift.git`

6.`./scripts/build.sh`

Add `./src/ProtocolBuffers/ProtocolBuffers.xcodeproj` in your project.

##Cocoapods

Podfile:

```pod
use_frameworks!
pod 'ProtocolBuffers-Swift'
```

##<img src="https://cloud.githubusercontent.com/assets/432536/5252404/443d64f4-7952-11e4-9d26-fc5cc664cb61.png" width="22" height="22"> Installation via [Carthage](https://github.com/Carthage/Carthage)

Cartfile:

```
github "alexeyxo/protobuf-swift"
```

##Compile ".proto" files.

```sh
protoc  person.proto --swift_out="./"
```

##Serializing

```protobuf
syntax = "proto2";
message Person {
    required int32 id = 1;
    required string name = 2;
    optional string email = 3;
}
```

```swift
let personBuilder = Person.builder()
personBuilder.id = 123
personBuilder.name = "Bob"
personBuilder.email = "bob@example.com"
let person = personBuilder.build()
println("\(person)")

person.data() //return NSData
```

##Chaining

```protobuf
syntax = "proto2";
message Perfomance
{
  required int32 ints = 1;
  required int64 ints64 = 2;
  required double doubles = 3;
  required float floats  = 4;
  optional string str  = 5;
  optional bytes bytes  = 6;
  optional string description = 7;
}
```

```swift
var originalBuilder = ProtoPerfomance.Builder()
originalBuilder.setInts(Int32(32))
               .setInts64(Int64(64))
               .setDoubles(Double(12.12))
               .setFloats(Float(123.123))
               .setStr("string")
let original = originalBuilder.build()
```

##Sub Builders

```protobuf
syntax = "proto2";
message Foo {
  optional int32 val = 1;
  // some other fields.
}

message Bar {
  optional Foo foo = 1;
  // some other fields.
}

message Baz {
  optional Bar bar = 1;
  // some other fields.
}
```

```swift
var builder = baz.toBuilder()
builder.getBarBuilder().getFooBuilder().setVal(10)
baz = builder.build()
```

##Maps(ProtocolBuffers 3.0)
```protobuf
syntax = "proto3";
message MapMessageValue
{
    int32 valueInMapMessage = 1;
}

message MessageContainsMap
{

  enum EnumMapValue
  {
    FirstValueEnum = 0;
    SecondValueEnum = 1;
  }

  map<int32,int32> map_int32_int32= 1;
  map<int64,int64> map_int64_int64= 2;
  map<string,string> map_string_string = 3;
  map<string,bytes> map_string_bytes = 4;
  map<string,MapMessageValue> map_string_message = 5;
  map<int32,EnumMapValue> map_int32_enum = 6;

}
```

```swift
final internal class MessageContainsMap : GeneratedMessage, GeneratedMessageProtocol, Hashable {
    ...
    private(set) var mapInt32Int32:Dictionary<Int32,Int32> = Dictionary<Int32,Int32>()
    private(set) var mapInt64Int64:Dictionary<Int64,Int64> = Dictionary<Int64,Int64>()

    private(set) var mapStringString:Dictionary<String,String> = Dictionary<String,String>()
    private(set) var mapStringBytes:Dictionary<String,NSData> = Dictionary<String,NSData>()
    private(set) var mapInt32Enum:Dictionary<Int32,MessageContainsMap.EnumMapValue> = Dictionary<Int32,MessageContainsMap.EnumMapValue>()
    ...
}
```

##JSON(proto3)
```swift
let personBuilder = Person.builder()
personBuilder.id = 123
personBuilder.name = "Bob"
personBuilder.email = "bob@example.com"
let person = personBuilder.build()
let jsonData = person.toJSON() //return NSData
let jsonDictionaryObject:Dictionary<String,AnyObject> = person.encode()
let personFromJson = Person.fromJSON(jsonData) //Person
```

##Deserializing

```swift
var person = Person.parseFromData(bytes) // from NSData
```

##Using Oneof

```protobuf
syntax = "proto3";
message SubMessage {
    string str = 1;
}

message SampleMessage {
  oneof test_oneof {
     string name = 4;
     int32 id = 5;
     SubMessage mes = 6;
  }
}
```

```swift
var sm = SampleMessage.Builder()
sm.name = "Alex"
sm.id = 123
println(ss.build()) //->  id: 123
```

##Nested Types

```protobuf
syntax = "proto3";
message SearchResponse {
    message Result {
        string url = 1;
        string title = 2;
        repeated string snippets = 3;
    }
    repeated Result result = 1;
}
```

```swift
var builderResult = SearchResponse.Result.Builder()
builderResult.url = "http://protobuf.axo.io"
builderResult.title = "Protocol Bufers Apple Swift"
var searchRespons = SearchResponse.builder()
searchRespons.result += [builderResult.build()]
println(searchRespons.build())
```

##Packages

```protobuf
syntax = "proto2";
package FooBar;
message Perfomance
{
  required int32 ints = 1;
  required int64 ints64 = 2;
  required double doubles = 3;
  required float floats  = 4;
  optional string str  = 5;
  optional bytes bytes  = 6;
  optional string description = 7;
}
```

```swift
public extension FooBar {
  ...
  final public class Perfomance : GeneratedMessage, GeneratedMessageProtocol {
    ...
  }

}
```

##Custom Options

```protobuf
import "google/protobuf/descriptor.proto";

package google.protobuf;

enum AccessControl {
  InternalEntities = 0;
  PublicEntities = 1;
}
message SwiftFileOptions {

  optional string class_prefix = 1;
  optional AccessControl entities_access_control = 2 [default = PublicEntities];
  optional bool compile_for_framework = 3 [default = true];
}

message SwiftMessageOptions {
  optional bool generate_error_type = 1 [default = false];
}

message SwiftEnumOptions {
  optional bool generate_error_type = 1 [default = false];
}

extend google.protobuf.FileOptions {
  optional SwiftFileOptions swift_file_options = 5092014;
}

extend google.protobuf.MessageOptions {
  optional SwiftMessageOptions swift_message_options = 5092014;
}

extend google.protobuf.EnumOptions {
  optional SwiftEnumOptions swift_enum_options = 5092015;
}

option (.google.protobuf.swift_file_options).compile_for_framework = false;
option (.google.protobuf.swift_file_options).entities_access_control = PublicEntities;
```

At now protobuf-swift's compiler is supporting custom options.

1.	Class Prefix
2.	Access Control
3.  Error Types 
4.	Compile for framework

If you have use custom options, you need to add:

```protobuf
import 'google/protobuf/swift-descriptor.proto';
```

in your `.proto` files.

###Class prefix

This option needs to generate class names with prefix.

Example:

```protobuf
import 'google/protobuf/swift-descriptor.proto';

option (.google.protobuf.swift_file_options).class_prefix = "Proto";

message NameWithPrefix
{
  optional string str = 1;
}
```

Generated class has a name:

```swift
final internal class ProtoNameWithPrefix : GeneratedMessage
```

###Access control

```protobuf
option (.google.protobuf.swift_file_options).entities_access_control = PublicEntities;
```

All generated classes marks as `internal` by default. If you want mark as `public`, you can use `entities_access_control` option.

```protobuf
option (.google.protobuf.swift_file_options).entities_access_control = PublicEntities;

message MessageWithCustomOption
{
  optional string str = 1;
}
```

Generated class and all fields are marked a `public`:

```swift
final public class MessageWithCustomOption : GeneratedMessage
```

###Generate enum/message conforming to "Error" protocol

```protobuf
option (.google.protobuf.swift_enum_options).generate_error_type = true;
```

####Example

```protobuf

import 'google/protobuf/swift-descriptor.proto';

enum ServiceError {
  option (.google.protobuf.swift_enum_options).generate_error_type = true;
  BadRequest = 0;
  InternalServerError = 1;
}

message UserProfile {
    message Request {
        required string userId = 1;
    }
    message Response {
        optional UserProfile profile = 1;
        optional ServiceError error = 2;
        optional Exception exception = 3;
    }

     message Exception {
        option (.google.protobuf.swift_message_options).generate_error_type = true;
        required int32 errorCode = 1;
        required string errorDescription = 2;
    }
    
    optional string firstName = 1;
    optional string lastName = 2;
    optional string avatarUrl = 3;
}
```

```swift
public enum ServiceError:Error, RawRepresentable, CustomDebugStringConvertible, CustomStringConvertible {
  public typealias RawValue = Int32

  case badRequest
  case internalServerError

  public init?(rawValue: RawValue) {
    switch rawValue {
    case 0: self = .badRequest
    case 1: self = .internalServerError
    default: return nil
    }
  }

  public var rawValue: RawValue {
    switch self {
    case .badRequest: return 0
    case .internalServerError: return 1
    }
  }

  public func throwException() throws {
    throw self
  }

  public var debugDescription:String { return getDescription() }
  public var description:String { return getDescription() }
  private func getDescription() -> String { 
    switch self {
    case .badRequest: return ".badRequest"
    case .internalServerError: return ".internalServerError"
    }
  }
}
```
```swift
func generateException()throws {
    let user = UserProfile.Response.Builder()
    user.error = .internalServerError
    let data = try user.build().data()
    let userError = try UserProfile.Response.parseFrom(data:data)
    if userError.hasError {
        throw userError.error //userError.error.throwException()
    }
}

do {
    try generateException()
} catch let err as ServiceError where err == .internalServerError {
    XCTAssertTrue(true)
} catch {
    XCTAssertTrue(false)
}

func throwExceptionMessage() throws {
  let exception = UserProfile.Exception.Builder()
  exception.errorCode = 403
  exception.errorDescription = "Bad Request"
  let exc = try exception.build()
  let data = try UserProfile.Response.Builder().setException(exc).build().data()
  let userError = try UserProfile.Response.parseFrom(data:data)
  if userError.hasException {
      throw userError.exception
  }
}

do {
    try throwExceptionMessage()
} catch let err as UserProfile.Exception {
    print(err)
    XCTAssertTrue(true)
} catch {
    XCTAssertTrue(false)
}
  
```

###Compile for framework

```protobuf
option (.google.protobuf.swift_file_options).compile_for_framework = false;
```

This option deletes the string `import ProtocolBuffers` of the generated files.

####If you will need some other options, write me. I will add them.




##Utilities (ProtocolBuffers 3.0)

Added well-known type protos (any.proto, empty.proto, timestamp.proto, duration.proto, etc.). Users can import and use these protos just like regular proto files. Addtional runtime support will be added for them in future releases (in the form of utility helper functions, or having them replaced by language specific types in generated code).
####Any
```protobuf
message Any {
  // A URL/resource name whose content describes the type of the
  // serialized message.
  //
  // For URLs which use the schema `http`, `https`, or no schema, the
  // following restrictions and interpretations apply:
  //
  // * If no schema is provided, `https` is assumed.
  // * The last segment of the URL's path must represent the fully
  //   qualified name of the type (as in `path/google.protobuf.Duration`).
  // * An HTTP GET on the URL must yield a [google.protobuf.Type][google.protobuf.Type]
  //   value in binary format, or produce an error.
  // * Applications are allowed to cache lookup results based on the
  //   URL, or have them precompiled into a binary to avoid any
  //   lookup. Therefore, binary compatibility needs to be preserved
  //   on changes to types. (Use versioned type names to manage
  //   breaking changes.)
  //
  // Schemas other than `http`, `https` (or the empty schema) might be
  // used with implementation specific semantics.
  //
  // Types originating from the `google.*` package
  // namespace should use `type.googleapis.com/full.type.name` (without
  // schema and path). A type service will eventually become available which
  // serves those URLs (projected Q2/15).
  string type_url = 1;

  // Must be valid serialized data of the above specified type.
  bytes value = 2;
}
```
```swift
Google.Protobuf.Any()
```

####API
```protobuf
message Api {
  // The fully qualified name of this api, including package name
  // followed by the api's simple name.
  string name = 1;

  // The methods of this api, in unspecified order.
  repeated Method methods = 2;

  // Any metadata attached to the API.
  repeated Option options = 3;

  // A version string for this api. If specified, must have the form
  // `major-version.minor-version`, as in `1.10`. If the minor version
  // is omitted, it defaults to zero. If the entire version field is
  // empty, the major version is derived from the package name, as
  // outlined below. If the field is not empty, the version in the
  // package name will be verified to be consistent with what is
  // provided here.
  //
  // The versioning schema uses [semantic
  // versioning](http://semver.org) where the major version number
  // indicates a breaking change and the minor version an additive,
  // non-breaking change. Both version numbers are signals to users
  // what to expect from different versions, and should be carefully
  // chosen based on the product plan.
  //
  // The major version is also reflected in the package name of the
  // API, which must end in `v<major-version>`, as in
  // `google.feature.v1`. For major versions 0 and 1, the suffix can
  // be omitted. Zero major versions must only be used for
  // experimental, none-GA apis.
  //
  // See also: [design doc](http://go/api-versioning).
  //
  //
  string version = 4;

  // Source context for the protocol buffer service represented by this
  // message.
  SourceContext source_context = 5;
}

// Method represents a method of an api.
message Method {
  // The simple name of this method.
  string name = 1;

  // A URL of the input message type.
  string request_type_url = 2;

  // If true, the request is streamed.
  bool request_streaming = 3;

  // The URL of the output message type.
  string response_type_url = 4;

  // If true, the response is streamed.
  bool response_streaming = 5;

  // Any metadata attached to the method.
  repeated Option options = 6;
}
```
```swift
Google.Protobuf.Api()
```

####Duration
```protobuf
message Duration {
  // Signed seconds of the span of time. Must be from -315,576,000,000
  // to +315,576,000,000 inclusive.
  int64 seconds = 1;

  // Signed fractions of a second at nanosecond resolution of the span
  // of time. Durations less than one second are represented with a 0
  // `seconds` field and a positive or negative `nanos` field. For durations
  // of one second or more, a non-zero value for the `nanos` field must be
  // of the same sign as the `seconds` field. Must be from -999,999,999
  // to +999,999,999 inclusive.
  int32 nanos = 2;
}
```
```swift
Google.Protobuf.Duration()
```
####Empty

```protobuf
message Empty {
}
```

```swift
Google.Protobuf.Empty()
```

####Field Mask

```protobuf
message FieldMask {
  // The set of field mask paths.
  repeated string paths = 1;
}
```

```swift
Google.Protobuf.FieldMask()
```
####Source context

```protobuf
message SourceContext {
  // The path-qualified name of the .proto file that contained the associated
  // protobuf element.  For example: `"google/protobuf/source.proto"`.
  string file_name = 1;
}
```

```swift
Google.Protobuf.SourceContext()
```

####Struct

```protobuf
message Struct {
  // Map of dynamically typed values.
  map<string, Value> fields = 1;
}

// `Value` represents a dynamically typed value which can be either
// null, a number, a string, a boolean, a recursive struct value, or a
// list of values. A producer of value is expected to set one of that
// variants, absence of any variant indicates an error.
message Value {
  oneof kind {
    // Represents a null value.
    NullValue null_value = 1;

    // Represents a double value.
    double number_value = 2;

    // Represents a string value.
    string string_value = 3;

    // Represents a boolean value.
    bool bool_value = 4;

    // Represents a structured value.
    Struct struct_value = 5;

    // Represents a repeated `Value`.
    ListValue list_value = 6;
  }
}

// `ListValue` is a wrapper around a repeated field of values.
message ListValue {
  // Repeated field of dynamically typed values.
  repeated Value values = 1;
}

// `NullValue` is a singleton enumeration to represent the null
// value for the `Value` type union.
enum NullValue {
  // Null value.
  NULL_VALUE = 0;
}
```

```swift
Google.Protobuf.Struct()
```

####Timestamp
```protobuf
message Timestamp {
  // Represents seconds of UTC time since Unix epoch
  // 1970-01-01T00:00:00Z. Must be from from 0001-01-01T00:00:00Z to
  // 9999-12-31T23:59:59Z inclusive.
  int64 seconds = 1;

  // Non-negative fractions of a second at nanosecond resolution. Negative
  // second values with fractions must still have non-negative nanos values
  // that count forward in time. Must be from 0 to 999,999,999
  // inclusive.
  int32 nanos = 2;
}
```
```swift
Google.Protobuf.Timestamp()
```

####Type
```protobuf
message Type {
  // The fully qualified message name.
  string name = 1;

  // The list of fields.
  repeated Field fields = 2;

  // The list of oneof definitions.
  // The list of oneofs declared in this Type
  repeated string oneofs = 3;

  // The proto options.
  repeated Option options = 4;

  // The source context.
  SourceContext source_context = 5;
}

// Field represents a single field of a message type.
message Field {
  // Kind represents a basic field type.
  enum Kind {
    // Field type unknown.
    TYPE_UNKNOWN = 0;

    // Field type double.
    TYPE_DOUBLE = 1;

    // Field type float.
    TYPE_FLOAT = 2;

    // Field type int64.
    TYPE_INT64 = 3;

    // Field type uint64.
    TYPE_UINT64 = 4;

    // Field type int32.
    TYPE_INT32 = 5;

    // Field type fixed64.
    TYPE_FIXED64 = 6;

    // Field type fixed32.
    TYPE_FIXED32 = 7;

    // Field type bool.
    TYPE_BOOL = 8;

    // Field type string.
    TYPE_STRING = 9;

    // Field type message.
    TYPE_MESSAGE = 11;

    // Field type bytes.
    TYPE_BYTES = 12;

    // Field type uint32.
    TYPE_UINT32 = 13;

    // Field type enum.
    TYPE_ENUM = 14;

    // Field type sfixed32.
    TYPE_SFIXED32 = 15;

    // Field type sfixed64.
    TYPE_SFIXED64 = 16;

    // Field type sint32.
    TYPE_SINT32 = 17;

    // Field type sint64.
    TYPE_SINT64 = 18;
  }

  // Cardinality represents whether a field is optional, required, or
  // repeated.
  enum Cardinality {
    // The field cardinality is unknown. Typically an error condition.
    CARDINALITY_UNKNOWN = 0;

    // For optional fields.
    CARDINALITY_OPTIONAL = 1;

    // For required fields. Not used for proto3.
    CARDINALITY_REQUIRED = 2;

    // For repeated fields.
    CARDINALITY_REPEATED = 3;
  }

  // The field kind.
  Kind kind = 1;

  // The field cardinality, i.e. optional/required/repeated.
  Cardinality cardinality = 2;

  // The proto field number.
  int32 number = 3;

  // The field name.
  string name = 4;

  // The type URL (without the scheme) when the type is MESSAGE or ENUM,
  // such as `type.googleapis.com/google.protobuf.Empty`.
  string type_url = 6;

  // Index in Type.oneofs. Starts at 1. Zero means no oneof mapping.
  int32 oneof_index = 7;

  // Whether to use alternative packed wire representation.
  bool packed = 8;

  // The proto options.
  repeated Option options = 9;
}

// Enum type definition.
message Enum {
  // Enum type name.
  string name = 1;

  // Enum value definitions.
  repeated EnumValue enumvalue = 2;

  // Proto options for the enum type.
  repeated Option options = 3;

  // The source context.
  SourceContext source_context = 4;
}

// Enum value definition.
message EnumValue {
  // Enum value name.
  string name = 1;

  // Enum value number.
  int32 number = 2;

  // Proto options for the enum value.
  repeated Option options = 3;
}

// Proto option attached to messages/fields/enums etc.
message Option {
  // Proto option name.
  string name = 1;

  // Proto option value.
  Any value = 2;
}
```
```swift
Google.Protobuf.Type()
...
```

####Wrappers

```protobuf
// Wrapper message for double.
message DoubleValue {
  // The double value.
  double value = 1;
}

// Wrapper message for float.
message FloatValue {
  // The float value.
  float value = 1;
}

// Wrapper message for int64.
message Int64Value {
  // The int64 value.
  int64 value = 1;
}

// Wrapper message for uint64.
message UInt64Value {
  // The uint64 value.
  uint64 value = 1;
}

// Wrapper message for int32.
message Int32Value {
  // The int32 value.
  int32 value = 1;
}

// Wrapper message for uint32.
message UInt32Value {
  // The uint32 value.
  uint32 value = 1;
}

// Wrapper message for bool.
message BoolValue {
  // The bool value.
  bool value = 1;
}

// Wrapper message for string.
message StringValue {
  // The string value.
  string value = 1;
}

// Wrapper message for bytes.
message BytesValue {
  // The bytes value.
  bytes value = 1;
}
```
```swift
Google.Protobuf.StringValue()
```


Credits
=======

Developer - Alexey Khokhlov

Google Protocol Buffers - Cyrus Najmabadi, Sergey Martynov, Kenton Varda, Sanjay Ghemawat, Jeff Dean, and others

//
//  Example
//  man.li
//
//  Created by man.li on 11/11/2018.
//  Copyright © 2020 man.li. All rights reserved.
//

#if !defined(_GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define _GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if _GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <protobuf/_GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "_GPBProtocolBuffers_RuntimeSupport.h"
#endif

#import <stdatomic.h>

#if _GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <protobuf/Type.pbobjc.h>
 #import <protobuf/Any.pbobjc.h>
 #import <protobuf/SourceContext.pbobjc.h>
#else
 #import "_Type.pbobjc.h"
 #import "_Any.pbobjc.h"
 #import "_SourceContext.pbobjc.h"
#endif
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - _GPBTypeRoot

@implementation _GPBTypeRoot

// No extensions in the file and none of the imports (direct or indirect)
// defined extensions, so no need to generate +extensionRegistry.

@end

#pragma mark - _GPBTypeRoot_FileDescriptor

static _GPBFileDescriptor *_GPBTypeRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static _GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    _GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[_GPBFileDescriptor alloc] initWithPackage:@"google.protobuf"
                                                 objcPrefix:@"_GPB"
                                                     syntax:_GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Enum _GPBSyntax

_GPBEnumDescriptor *_GPBSyntax_EnumDescriptor(void) {
  static _Atomic(_GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "SyntaxProto2\000SyntaxProto3\000";
    static const int32_t values[] = {
        _GPBSyntax_SyntaxProto2,
        _GPBSyntax_SyntaxProto3,
    };
    _GPBEnumDescriptor *worker =
        [_GPBEnumDescriptor allocDescriptorForName:_GPBNSStringifySymbol(_GPBSyntax)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:_GPBSyntax_IsValidValue];
    _GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL _GPBSyntax_IsValidValue(int32_t value__) {
  switch (value__) {
    case _GPBSyntax_SyntaxProto2:
    case _GPBSyntax_SyntaxProto3:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - _GPBType

@implementation _GPBType

@dynamic name;
@dynamic fieldsArray, fieldsArray_Count;
@dynamic oneofsArray, oneofsArray_Count;
@dynamic optionsArray, optionsArray_Count;
@dynamic hasSourceContext, sourceContext;
@dynamic syntax;

typedef struct _GPBType__storage_ {
  uint32_t _has_storage_[1];
  _GPBSyntax syntax;
  NSString *name;
  NSMutableArray *fieldsArray;
  NSMutableArray *oneofsArray;
  NSMutableArray *optionsArray;
  _GPBSourceContext *sourceContext;
} _GPBType__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (_GPBDescriptor *)descriptor {
  static _GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static _GPBMessageFieldDescription fields[] = {
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = _GPBType_FieldNumber_Name,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(_GPBType__storage_, name),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeString,
      },
      {
        .name = "fieldsArray",
        .dataTypeSpecific.className = _GPBStringifySymbol(_GPBField),
        .number = _GPBType_FieldNumber_FieldsArray,
        .hasIndex = _GPBNoHasBit,
        .offset = (uint32_t)offsetof(_GPBType__storage_, fieldsArray),
        .flags = _GPBFieldRepeated,
        .dataType = _GPBDataTypeMessage,
      },
      {
        .name = "oneofsArray",
        .dataTypeSpecific.className = NULL,
        .number = _GPBType_FieldNumber_OneofsArray,
        .hasIndex = _GPBNoHasBit,
        .offset = (uint32_t)offsetof(_GPBType__storage_, oneofsArray),
        .flags = _GPBFieldRepeated,
        .dataType = _GPBDataTypeString,
      },
      {
        .name = "optionsArray",
        .dataTypeSpecific.className = _GPBStringifySymbol(_GPBOption),
        .number = _GPBType_FieldNumber_OptionsArray,
        .hasIndex = _GPBNoHasBit,
        .offset = (uint32_t)offsetof(_GPBType__storage_, optionsArray),
        .flags = _GPBFieldRepeated,
        .dataType = _GPBDataTypeMessage,
      },
      {
        .name = "sourceContext",
        .dataTypeSpecific.className = _GPBStringifySymbol(_GPBSourceContext),
        .number = _GPBType_FieldNumber_SourceContext,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(_GPBType__storage_, sourceContext),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeMessage,
      },
      {
        .name = "syntax",
        .dataTypeSpecific.enumDescFunc = _GPBSyntax_EnumDescriptor,
        .number = _GPBType_FieldNumber_Syntax,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(_GPBType__storage_, syntax),
        .flags = (_GPBFieldFlags)(_GPBFieldOptional | _GPBFieldHasEnumDescriptor),
        .dataType = _GPBDataTypeEnum,
      },
    };
    _GPBDescriptor *localDescriptor =
        [_GPBDescriptor allocDescriptorForClass:[_GPBType class]
                                     rootClass:[_GPBTypeRoot class]
                                          file:_GPBTypeRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(_GPBMessageFieldDescription))
                                   storageSize:sizeof(_GPBType__storage_)
                                         flags:_GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t _GPBType_Syntax_RawValue(_GPBType *message) {
  _GPBDescriptor *descriptor = [_GPBType descriptor];
  _GPBFieldDescriptor *field = [descriptor fieldWithNumber:_GPBType_FieldNumber_Syntax];
  return _GPBGetMessageInt32Field(message, field);
}

void Set_GPBType_Syntax_RawValue(_GPBType *message, int32_t value) {
  _GPBDescriptor *descriptor = [_GPBType descriptor];
  _GPBFieldDescriptor *field = [descriptor fieldWithNumber:_GPBType_FieldNumber_Syntax];
  _GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - _GPBField

@implementation _GPBField

@dynamic kind;
@dynamic cardinality;
@dynamic number;
@dynamic name;
@dynamic typeURL;
@dynamic oneofIndex;
@dynamic packed;
@dynamic optionsArray, optionsArray_Count;
@dynamic jsonName;
@dynamic defaultValue;

typedef struct _GPBField__storage_ {
  uint32_t _has_storage_[1];
  _GPBField_Kind kind;
  _GPBField_Cardinality cardinality;
  int32_t number;
  int32_t oneofIndex;
  NSString *name;
  NSString *typeURL;
  NSMutableArray *optionsArray;
  NSString *jsonName;
  NSString *defaultValue;
} _GPBField__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (_GPBDescriptor *)descriptor {
  static _GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static _GPBMessageFieldDescription fields[] = {
      {
        .name = "kind",
        .dataTypeSpecific.enumDescFunc = _GPBField_Kind_EnumDescriptor,
        .number = _GPBField_FieldNumber_Kind,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(_GPBField__storage_, kind),
        .flags = (_GPBFieldFlags)(_GPBFieldOptional | _GPBFieldHasEnumDescriptor),
        .dataType = _GPBDataTypeEnum,
      },
      {
        .name = "cardinality",
        .dataTypeSpecific.enumDescFunc = _GPBField_Cardinality_EnumDescriptor,
        .number = _GPBField_FieldNumber_Cardinality,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(_GPBField__storage_, cardinality),
        .flags = (_GPBFieldFlags)(_GPBFieldOptional | _GPBFieldHasEnumDescriptor),
        .dataType = _GPBDataTypeEnum,
      },
      {
        .name = "number",
        .dataTypeSpecific.className = NULL,
        .number = _GPBField_FieldNumber_Number,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(_GPBField__storage_, number),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeInt32,
      },
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = _GPBField_FieldNumber_Name,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(_GPBField__storage_, name),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeString,
      },
      {
        .name = "typeURL",
        .dataTypeSpecific.className = NULL,
        .number = _GPBField_FieldNumber_TypeURL,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(_GPBField__storage_, typeURL),
        .flags = (_GPBFieldFlags)(_GPBFieldOptional | _GPBFieldTextFormatNameCustom),
        .dataType = _GPBDataTypeString,
      },
      {
        .name = "oneofIndex",
        .dataTypeSpecific.className = NULL,
        .number = _GPBField_FieldNumber_OneofIndex,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(_GPBField__storage_, oneofIndex),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeInt32,
      },
      {
        .name = "packed",
        .dataTypeSpecific.className = NULL,
        .number = _GPBField_FieldNumber_Packed,
        .hasIndex = 6,
        .offset = 7,  // Stored in _has_storage_ to save space.
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeBool,
      },
      {
        .name = "optionsArray",
        .dataTypeSpecific.className = _GPBStringifySymbol(_GPBOption),
        .number = _GPBField_FieldNumber_OptionsArray,
        .hasIndex = _GPBNoHasBit,
        .offset = (uint32_t)offsetof(_GPBField__storage_, optionsArray),
        .flags = _GPBFieldRepeated,
        .dataType = _GPBDataTypeMessage,
      },
      {
        .name = "jsonName",
        .dataTypeSpecific.className = NULL,
        .number = _GPBField_FieldNumber_JsonName,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(_GPBField__storage_, jsonName),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeString,
      },
      {
        .name = "defaultValue",
        .dataTypeSpecific.className = NULL,
        .number = _GPBField_FieldNumber_DefaultValue,
        .hasIndex = 9,
        .offset = (uint32_t)offsetof(_GPBField__storage_, defaultValue),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeString,
      },
    };
    _GPBDescriptor *localDescriptor =
        [_GPBDescriptor allocDescriptorForClass:[_GPBField class]
                                     rootClass:[_GPBTypeRoot class]
                                          file:_GPBTypeRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(_GPBMessageFieldDescription))
                                   storageSize:sizeof(_GPBField__storage_)
                                         flags:_GPBDescriptorInitializationFlag_None];
#if !_GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\001\006\004\241!!\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !_GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t _GPBField_Kind_RawValue(_GPBField *message) {
  _GPBDescriptor *descriptor = [_GPBField descriptor];
  _GPBFieldDescriptor *field = [descriptor fieldWithNumber:_GPBField_FieldNumber_Kind];
  return _GPBGetMessageInt32Field(message, field);
}

void Set_GPBField_Kind_RawValue(_GPBField *message, int32_t value) {
  _GPBDescriptor *descriptor = [_GPBField descriptor];
  _GPBFieldDescriptor *field = [descriptor fieldWithNumber:_GPBField_FieldNumber_Kind];
  _GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

int32_t _GPBField_Cardinality_RawValue(_GPBField *message) {
  _GPBDescriptor *descriptor = [_GPBField descriptor];
  _GPBFieldDescriptor *field = [descriptor fieldWithNumber:_GPBField_FieldNumber_Cardinality];
  return _GPBGetMessageInt32Field(message, field);
}

void Set_GPBField_Cardinality_RawValue(_GPBField *message, int32_t value) {
  _GPBDescriptor *descriptor = [_GPBField descriptor];
  _GPBFieldDescriptor *field = [descriptor fieldWithNumber:_GPBField_FieldNumber_Cardinality];
  _GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - Enum _GPBField_Kind

_GPBEnumDescriptor *_GPBField_Kind_EnumDescriptor(void) {
  static _Atomic(_GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "TypeUnknown\000TypeDouble\000TypeFloat\000TypeInt"
        "64\000TypeUint64\000TypeInt32\000TypeFixed64\000Type"
        "Fixed32\000TypeBool\000TypeString\000TypeGroup\000Ty"
        "peMessage\000TypeBytes\000TypeUint32\000TypeEnum\000"
        "TypeSfixed32\000TypeSfixed64\000TypeSint32\000Typ"
        "eSint64\000";
    static const int32_t values[] = {
        _GPBField_Kind_TypeUnknown,
        _GPBField_Kind_TypeDouble,
        _GPBField_Kind_TypeFloat,
        _GPBField_Kind_TypeInt64,
        _GPBField_Kind_TypeUint64,
        _GPBField_Kind_TypeInt32,
        _GPBField_Kind_TypeFixed64,
        _GPBField_Kind_TypeFixed32,
        _GPBField_Kind_TypeBool,
        _GPBField_Kind_TypeString,
        _GPBField_Kind_TypeGroup,
        _GPBField_Kind_TypeMessage,
        _GPBField_Kind_TypeBytes,
        _GPBField_Kind_TypeUint32,
        _GPBField_Kind_TypeEnum,
        _GPBField_Kind_TypeSfixed32,
        _GPBField_Kind_TypeSfixed64,
        _GPBField_Kind_TypeSint32,
        _GPBField_Kind_TypeSint64,
    };
    _GPBEnumDescriptor *worker =
        [_GPBEnumDescriptor allocDescriptorForName:_GPBNSStringifySymbol(_GPBField_Kind)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:_GPBField_Kind_IsValidValue];
    _GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL _GPBField_Kind_IsValidValue(int32_t value__) {
  switch (value__) {
    case _GPBField_Kind_TypeUnknown:
    case _GPBField_Kind_TypeDouble:
    case _GPBField_Kind_TypeFloat:
    case _GPBField_Kind_TypeInt64:
    case _GPBField_Kind_TypeUint64:
    case _GPBField_Kind_TypeInt32:
    case _GPBField_Kind_TypeFixed64:
    case _GPBField_Kind_TypeFixed32:
    case _GPBField_Kind_TypeBool:
    case _GPBField_Kind_TypeString:
    case _GPBField_Kind_TypeGroup:
    case _GPBField_Kind_TypeMessage:
    case _GPBField_Kind_TypeBytes:
    case _GPBField_Kind_TypeUint32:
    case _GPBField_Kind_TypeEnum:
    case _GPBField_Kind_TypeSfixed32:
    case _GPBField_Kind_TypeSfixed64:
    case _GPBField_Kind_TypeSint32:
    case _GPBField_Kind_TypeSint64:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum _GPBField_Cardinality

_GPBEnumDescriptor *_GPBField_Cardinality_EnumDescriptor(void) {
  static _Atomic(_GPBEnumDescriptor*) descriptor = nil;
  if (!descriptor) {
    static const char *valueNames =
        "CardinalityUnknown\000CardinalityOptional\000C"
        "ardinalityRequired\000CardinalityRepeated\000";
    static const int32_t values[] = {
        _GPBField_Cardinality_CardinalityUnknown,
        _GPBField_Cardinality_CardinalityOptional,
        _GPBField_Cardinality_CardinalityRequired,
        _GPBField_Cardinality_CardinalityRepeated,
    };
    _GPBEnumDescriptor *worker =
        [_GPBEnumDescriptor allocDescriptorForName:_GPBNSStringifySymbol(_GPBField_Cardinality)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:_GPBField_Cardinality_IsValidValue];
    _GPBEnumDescriptor *expected = nil;
    if (!atomic_compare_exchange_strong(&descriptor, &expected, worker)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL _GPBField_Cardinality_IsValidValue(int32_t value__) {
  switch (value__) {
    case _GPBField_Cardinality_CardinalityUnknown:
    case _GPBField_Cardinality_CardinalityOptional:
    case _GPBField_Cardinality_CardinalityRequired:
    case _GPBField_Cardinality_CardinalityRepeated:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - _GPBEnum

@implementation _GPBEnum

@dynamic name;
@dynamic enumvalueArray, enumvalueArray_Count;
@dynamic optionsArray, optionsArray_Count;
@dynamic hasSourceContext, sourceContext;
@dynamic syntax;

typedef struct _GPBEnum__storage_ {
  uint32_t _has_storage_[1];
  _GPBSyntax syntax;
  NSString *name;
  NSMutableArray *enumvalueArray;
  NSMutableArray *optionsArray;
  _GPBSourceContext *sourceContext;
} _GPBEnum__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (_GPBDescriptor *)descriptor {
  static _GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static _GPBMessageFieldDescription fields[] = {
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = _GPBEnum_FieldNumber_Name,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(_GPBEnum__storage_, name),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeString,
      },
      {
        .name = "enumvalueArray",
        .dataTypeSpecific.className = _GPBStringifySymbol(_GPBEnumValue),
        .number = _GPBEnum_FieldNumber_EnumvalueArray,
        .hasIndex = _GPBNoHasBit,
        .offset = (uint32_t)offsetof(_GPBEnum__storage_, enumvalueArray),
        .flags = _GPBFieldRepeated,
        .dataType = _GPBDataTypeMessage,
      },
      {
        .name = "optionsArray",
        .dataTypeSpecific.className = _GPBStringifySymbol(_GPBOption),
        .number = _GPBEnum_FieldNumber_OptionsArray,
        .hasIndex = _GPBNoHasBit,
        .offset = (uint32_t)offsetof(_GPBEnum__storage_, optionsArray),
        .flags = _GPBFieldRepeated,
        .dataType = _GPBDataTypeMessage,
      },
      {
        .name = "sourceContext",
        .dataTypeSpecific.className = _GPBStringifySymbol(_GPBSourceContext),
        .number = _GPBEnum_FieldNumber_SourceContext,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(_GPBEnum__storage_, sourceContext),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeMessage,
      },
      {
        .name = "syntax",
        .dataTypeSpecific.enumDescFunc = _GPBSyntax_EnumDescriptor,
        .number = _GPBEnum_FieldNumber_Syntax,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(_GPBEnum__storage_, syntax),
        .flags = (_GPBFieldFlags)(_GPBFieldOptional | _GPBFieldHasEnumDescriptor),
        .dataType = _GPBDataTypeEnum,
      },
    };
    _GPBDescriptor *localDescriptor =
        [_GPBDescriptor allocDescriptorForClass:[_GPBEnum class]
                                     rootClass:[_GPBTypeRoot class]
                                          file:_GPBTypeRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(_GPBMessageFieldDescription))
                                   storageSize:sizeof(_GPBEnum__storage_)
                                         flags:_GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

int32_t _GPBEnum_Syntax_RawValue(_GPBEnum *message) {
  _GPBDescriptor *descriptor = [_GPBEnum descriptor];
  _GPBFieldDescriptor *field = [descriptor fieldWithNumber:_GPBEnum_FieldNumber_Syntax];
  return _GPBGetMessageInt32Field(message, field);
}

void Set_GPBEnum_Syntax_RawValue(_GPBEnum *message, int32_t value) {
  _GPBDescriptor *descriptor = [_GPBEnum descriptor];
  _GPBFieldDescriptor *field = [descriptor fieldWithNumber:_GPBEnum_FieldNumber_Syntax];
  _GPBSetInt32IvarWithFieldInternal(message, field, value, descriptor.file.syntax);
}

#pragma mark - _GPBEnumValue

@implementation _GPBEnumValue

@dynamic name;
@dynamic number;
@dynamic optionsArray, optionsArray_Count;

typedef struct _GPBEnumValue__storage_ {
  uint32_t _has_storage_[1];
  int32_t number;
  NSString *name;
  NSMutableArray *optionsArray;
} _GPBEnumValue__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (_GPBDescriptor *)descriptor {
  static _GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static _GPBMessageFieldDescription fields[] = {
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = _GPBEnumValue_FieldNumber_Name,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(_GPBEnumValue__storage_, name),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeString,
      },
      {
        .name = "number",
        .dataTypeSpecific.className = NULL,
        .number = _GPBEnumValue_FieldNumber_Number,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(_GPBEnumValue__storage_, number),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeInt32,
      },
      {
        .name = "optionsArray",
        .dataTypeSpecific.className = _GPBStringifySymbol(_GPBOption),
        .number = _GPBEnumValue_FieldNumber_OptionsArray,
        .hasIndex = _GPBNoHasBit,
        .offset = (uint32_t)offsetof(_GPBEnumValue__storage_, optionsArray),
        .flags = _GPBFieldRepeated,
        .dataType = _GPBDataTypeMessage,
      },
    };
    _GPBDescriptor *localDescriptor =
        [_GPBDescriptor allocDescriptorForClass:[_GPBEnumValue class]
                                     rootClass:[_GPBTypeRoot class]
                                          file:_GPBTypeRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(_GPBMessageFieldDescription))
                                   storageSize:sizeof(_GPBEnumValue__storage_)
                                         flags:_GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - _GPBOption

@implementation _GPBOption

@dynamic name;
@dynamic hasValue, value;

typedef struct _GPBOption__storage_ {
  uint32_t _has_storage_[1];
  NSString *name;
  _GPBAny *value;
} _GPBOption__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (_GPBDescriptor *)descriptor {
  static _GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static _GPBMessageFieldDescription fields[] = {
      {
        .name = "name",
        .dataTypeSpecific.className = NULL,
        .number = _GPBOption_FieldNumber_Name,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(_GPBOption__storage_, name),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeString,
      },
      {
        .name = "value",
        .dataTypeSpecific.className = _GPBStringifySymbol(_GPBAny),
        .number = _GPBOption_FieldNumber_Value,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(_GPBOption__storage_, value),
        .flags = _GPBFieldOptional,
        .dataType = _GPBDataTypeMessage,
      },
    };
    _GPBDescriptor *localDescriptor =
        [_GPBDescriptor allocDescriptorForClass:[_GPBOption class]
                                     rootClass:[_GPBTypeRoot class]
                                          file:_GPBTypeRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(_GPBMessageFieldDescription))
                                   storageSize:sizeof(_GPBOption__storage_)
                                         flags:_GPBDescriptorInitializationFlag_None];
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)

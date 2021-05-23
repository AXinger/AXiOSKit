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

#if _GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <protobuf/Empty.pbobjc.h>
#else
 #import "_Empty.pbobjc.h"
#endif
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - _GPBEmptyRoot

@implementation _GPBEmptyRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - _GPBEmptyRoot_FileDescriptor

static _GPBFileDescriptor *_GPBEmptyRoot_FileDescriptor(void) {
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

#pragma mark - _GPBEmpty

@implementation _GPBEmpty


typedef struct _GPBEmpty__storage_ {
  uint32_t _has_storage_[1];
} _GPBEmpty__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (_GPBDescriptor *)descriptor {
  static _GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    _GPBDescriptor *localDescriptor =
        [_GPBDescriptor allocDescriptorForClass:[_GPBEmpty class]
                                     rootClass:[_GPBEmptyRoot class]
                                          file:_GPBEmptyRoot_FileDescriptor()
                                        fields:NULL
                                    fieldCount:0
                                   storageSize:sizeof(_GPBEmpty__storage_)
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

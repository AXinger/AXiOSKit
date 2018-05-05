//
//  NSDictionary+AXSafe.m
//  AXiOSTools
//
//  Created by liuweixing on 2017/2/23.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import "NSDictionary+AXSafe.h"
#import "AXToolsHeader.h"
@implementation NSDictionary (AXSafe)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
  
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryI"), @selector(setObject:forKey:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryI"), @selector(catch_setObject:forKey:));
        method_exchangeImplementations(fromMethod, toMethod);
    });
}

- (void)catch_setObject:(id)emObject forKey:(NSString *)key {
    if (emObject == nil) {
//        @try {
//            [self catch_setObject:emObject forKey:key];
//        }
//        @catch (NSException *exception) {
//            
//            emObject = [NSString stringWithFormat:@""];
//            [self catch_setObject:emObject forKey:key];
//        }
//        @finally {}
    }else {
        [self catch_setObject:emObject forKey:key];
    }
}

@end
//
//  NSObject+FBKVOControllerAX.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/4/3.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "NSObject+FBKVOControllerAX.h"

#import <KVOController/KVOController.h>

@implementation NSObject (FBKVOControllerAX)

/**
 Facebook kvo 封装
 
 @param keyPath 路径
 @param block 回调,新 旧 值
 */
- (void)ax_KVOControllerKeyPath:(NSString *_Nullable)keyPath block:(void(^_Nullable)(NSString * _Nullable pathKey, id _Nullable oldValue ,id _Nullable newValue ))block{
    
    [self.KVOController observe:self keyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if (block) {
            block(change[FBKVONotificationKeyPathKey],change[@"old"],change[@"new"]);
        }
    }];
    
}


/**
 Facebook kvo 封装
 
 @param keyPath 路径
 @param block 回调,新 旧 值
 */
- (void)ax_addFBKVOKeyPath:(NSString *_Nullable)keyPath block:(void(^_Nullable)(NSString * _Nullable pathKey, id _Nullable oldValue ,id _Nullable newValue ))block{
    
    [self.KVOController observe:self keyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if (block) {
            block(change[FBKVONotificationKeyPathKey],change[@"old"],change[@"new"]);
        }
    }];
    
}

@end

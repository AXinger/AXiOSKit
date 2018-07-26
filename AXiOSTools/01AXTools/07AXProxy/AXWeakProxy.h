//
//  AXWeakProxy.h
//  AXiOSTools
//
//  Created by liuweixing on 2018/5/31.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

// AXWeakProxy 代码
#import <Foundation/Foundation.h>

@interface AXWeakProxy : NSProxy

@property (nullable, nonatomic, weak, readonly) id target;

- (instancetype _Nullable )initWithTarget:(id _Nullable )target;

+ (instancetype _Nullable )proxyWithTarget:(id _Nullable )target;

@end

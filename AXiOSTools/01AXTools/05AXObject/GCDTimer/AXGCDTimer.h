//
//  AXGCDTimer.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXGCDTimer : NSObject

/**
 GCD timer 不会强引用 ,不自动开始,调用 sourceTimerStart

 @param aInterval 间隔
 @param block 回调
 @return 对象
 */
- (instancetype )initWithTimer:(NSTimeInterval)aInterval block:(void(^)(void))block;

/**
 主动开始
 */
- (void)sourceTimerStart;


/**
 取消
 */
- (void)sourceTimerCancel;

@end

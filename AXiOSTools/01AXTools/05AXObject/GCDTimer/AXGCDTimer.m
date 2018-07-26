//
//  AXGCDTimer.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXGCDTimer.h"

@interface AXGCDTimer ()

@property (nonatomic, strong)dispatch_source_t source_timer;

@end


@implementation AXGCDTimer

/**
 GCD timer 不会强引用 ,不自动开始,调用 Resume
 
 @param aInterval 间隔
 @param block 回调
 @return 对象
 */
- (instancetype )initWithTimer:(NSTimeInterval)aInterval block:(void(^)(void))block{
    
    if (self = [super init]) {
        
        NSTimeInterval period = aInterval; //设置时间间隔
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_source_t gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        dispatch_source_set_timer(gcdTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
        
        dispatch_source_set_event_handler(gcdTimer, ^{    //在这里执行事件
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 在主线程中实现需要的功能
                if (block) {
                    
                    block();
                }
            });
            
        });
        self.source_timer = gcdTimer;
    }
    return self;
}


- (void)sourceTimerStart{
    
    dispatch_resume(self.source_timer);
}

- (void)sourceTimerCancel{
    
    dispatch_source_cancel(self.source_timer); // 异步取消调度源
    self.source_timer = nil; // 将 dispatch_source_t 置为nil
}



@end

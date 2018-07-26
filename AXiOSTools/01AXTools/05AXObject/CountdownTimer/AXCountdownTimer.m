//
//  AXCountdownTimer.m
//  TTS-LITE
//
//  Created by Jack on 16/12/13.
//  Copyright © 2016年 wade. All rights reserved.
//

#import "AXCountdownTimer.h"

dispatch_source_t timer;

static int _timeout;

@interface AXCountdownTimer ()

@property (nonatomic, strong) HandlerBlock handlerBlock;

@property (nonatomic, strong) TimerBlock finish;

@end

@implementation AXCountdownTimer

axShared_M(AXCountdownTimer);

- (void)startGCDTimerOnGlobalQueueWithInterval:(int)interval Blcok:(TimerBlock)timerBlcok {
    
    if (!interval) interval = 1;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        
        if (timerBlcok) {
            
            timerBlcok();
        }
            
        
    });
    
    // 开启定时器
    dispatch_resume(timer);
}

- (void)startGCDTimerOnMainQueueWithInterval:(int)interval Blcok:(TimerBlock)timerBlcok {
    
    if (!interval) interval = 1;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (timerBlcok) {
                
                timerBlcok();
            }
            
        });
        
    });
    
    // 开启定时器
    dispatch_resume(timer);
}

- (void)stopGCDTimer {
    
    if(timer)
    {
        dispatch_source_cancel(timer);
    }
    
}


+ (void)timerWithTimeout:(int)timeout handlerBlock:(HandlerBlock)handlerBlock finish:(TimerBlock)finish {
    [[self sharedAXCountdownTimer] createTimerWithTimeout:timeout handlerBlock:handlerBlock finish:finish];
}


- (void)createTimerWithTimeout:(int)timeout handlerBlock:(HandlerBlock)handlerBlock finish:(TimerBlock)finish {
    
    _timeout = timeout;
    self.handlerBlock = handlerBlock;
    self.finish = finish;
    
    [self _startCountdown];
}


- (void)_startCountdown {
    
    int interval = 1;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        
        if (_timeout <= 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.finish) {
                    self.finish();
                }
            });
            
            dispatch_source_cancel(timer);
            
        } else {
            
            //NSLog(@"%d", _timeout);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.handlerBlock) {
                    self.handlerBlock(_timeout);
                }
                _timeout --;
            });
        }
        
    });
    
    // 开启定时器
    dispatch_resume(timer);
    
}

+ (void)stopGCDTimer {

    [[self sharedAXCountdownTimer] stopGCDTimer];
}

@end

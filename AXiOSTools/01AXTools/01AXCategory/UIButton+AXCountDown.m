//
//  UIButton+AXCountDown.m
//  BigApple
//
//  Created by liuweixing on 2017/3/27.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "UIButton+AXCountDown.h"
#import "UIButton+AXTool.h"
@interface UIButton ()


@end

@implementation UIButton (AXCountDown)

/** 记录初始化时间 */
static NSInteger _allSecond;


/** 显示倒计时的时间 */
static NSInteger _countDownSecond;


/**
 短信倒计时事件,需要主动调用开始
 
 @param second 时长
 @param condition 条件
 @param action 事件
 */
- (void)ax_messageWithSecond:(NSInteger)second condition:(BOOL (^)(void))condition action:(void(^)(UIButton *button))action{
    
    [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
    
    if (_allSecond <=0) {
        _allSecond = second;

    }else{
        _allSecond = _allSecond;
    }
    
    if (_countDownSecond>0) {
        [self ax_beginCountDown]; 
    }
    
    
    [self ax_addTargetActionBlock:^(UIButton *button) {
        _countDownSecond = second;
        if (condition==nil) {
            action(self);
        }else{
            BOOL success = condition();
            if(success==YES){
                action(self);
            }
        }
    }];
    
}



- (void)ax_stopCountDown{
    self.enabled = YES;
    _countDownSecond = _allSecond;
}

static NSTimer *_timer = nil;
- (void)ax_beginCountDown{
    
    if (_countDownSecond<=0) {
        return;
    }
    
    self.enabled = NO;
    [_timer invalidate];
    _timer =[NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        if (_countDownSecond <= 0) {
            [timer invalidate];
            self.enabled = YES;
            return;
        }
        
        NSString *text = [NSString stringWithFormat:@"%lds后重新获取",(long) _countDownSecond];
        self.titleLabel.text = text;//防止闪烁
        [self setTitle:text forState:UIControlStateDisabled];
        
        _countDownSecond--;
    }];
    [_timer fire];
}



@end

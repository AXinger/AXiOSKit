//
//  UIButton+AXCountDown.h
//  BigApple
//
//  Created by liuweixing on 2017/3/27.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AXCountDown)

/**
 短信倒计时事件,需要主动调用开始

 @param second 时长
 @param condition 条件
 @param action 事件
 */
- (void)ax_messageWithSecond:(NSInteger)second condition:(BOOL (^)(void))condition action:(void(^)(UIButton *button))action;


/**
 *  开始倒计时,需要主动调用比如AFN中,需要根据请求是否成功来进行开始计时
 */
- (void)ax_beginCountDown;

/**
 * 停止倒计时,正常情况下,不需要主动调用
 */
- (void)ax_stopCountDown;

@end

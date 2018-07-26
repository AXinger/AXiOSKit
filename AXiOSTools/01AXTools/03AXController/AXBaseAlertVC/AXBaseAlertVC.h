//
//  AXBaseAlertVC.h
//  AXiOSTools
//
//  Created by liuweixing on 16/10/12.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXViewController.h"

typedef NS_ENUM(NSUInteger, AXAlertAnimationType)
{
    AXAlertAnimationTypeCenter = 0,   // 从中间放大弹出
    AXAlertAnimationTypeUpward            // 从下往上
};

@interface AXBaseAlertVC : AXViewController

/**
 自定义,需要显示的view 子控制器进行赋值
 */
@property (nonatomic, strong) UIView *axContentView;

/**
 是否touchesBegan,dismiss
 */
@property (nonatomic, assign)BOOL axTouchesBeganDismiss;

@property (nonatomic, assign)AXAlertAnimationType alertAnimationType;

@end

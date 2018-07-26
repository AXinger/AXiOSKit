//
//  AXConfigure.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXConfigure.h"
#import "IQKeyboardManager.h"
#import <UIKit/UIKit.h>

@implementation AXConfigure

#pragma mark configure
/**
 键盘等 基础配置
 */
+(void)configure{
    
    [self func_IQKeyboardManager];
}

/**
 * 键盘
 */
+(void)func_IQKeyboardManager{
    //拖入工程即生效,这里只是做一下设置
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //控制整个功能是否启用
    manager.enable = YES;
    //控制整个功能是否启用
    manager.shouldResignOnTouchOutside = YES;
    //控制键盘上的工具条文字颜色是否用户自定义
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //控制是否显示键盘上的工具条
    manager.enableAutoToolbar = NO;
}


#pragma mark func_viewAppearance

/**
 * appearance
 */
+(void)func_viewAppearance{
    
    //    [UITextField appearance].clearsOnBeginEditing = YES;
    [UITextField appearance].clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //    [UILabel appearance].textAlignment = NSTextAlignmentCenter;
    
    
    // UIView有个属性叫做exclusiveTouch，设置为YES后，其响应事件会和其他view互斥(有其他view事件响应的时候点击它不起作用)
    [[UITableViewCell appearance] setExclusiveTouch:YES];
}




@end

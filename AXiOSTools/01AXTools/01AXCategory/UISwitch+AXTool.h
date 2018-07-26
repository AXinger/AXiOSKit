//
//  UISwitch+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 2017/1/3.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwitch (AXTool)

/**
 * 按钮事件封装成block
 */
- (void)ax_addTargetActionBlock:(void(^)(UISwitch *aSwitch))block;

@end

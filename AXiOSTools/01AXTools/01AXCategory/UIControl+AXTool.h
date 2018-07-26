//
//  UIControl+AXTool.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/5.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (AXTool)

/**
 * UIControl addTarget 封装成block
 */
- (void)ax_addTargetEvents:(UIControlEvents)controlEvents block:(void(^_Nullable)(UIControl * _Nullable aControl))block;

@end

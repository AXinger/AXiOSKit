//
//  UIControl+AXTool.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/5.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UIControl+AXTool.h"
#import <objc/runtime.h>
#import "AXMacros_runTime.h"

typedef void(^ControlBlock)(UIControl *aControl);

@interface UIControl ()
@property (nonatomic, copy)ControlBlock controlBlock;
@end
@implementation UIControl (AXTool)

/**
 * UIControl addTarget 封装成block
 */
- (void)ax_addTargetEvents:(UIControlEvents)controlEvents block:(void(^_Nullable)(UIControl * _Nullable aControl))block{
    [self addTarget:self action:@selector(controlAction:) forControlEvents:controlEvents];
    self.controlBlock = block;
}

#pragma mark - action
- (void)controlAction:(UIControl *)sender{
    if (self.controlBlock) {
        self.controlBlock(sender);
    }
}


#pragma mark - set and get

- (void)setControlBlock:(ControlBlock)controlBlock{
    ax_runtimePropertyObjSet(controlBlock)
}

- (ControlBlock)controlBlock{
    return ax_runtimePropertyObjGet(controlBlock)
}

@end

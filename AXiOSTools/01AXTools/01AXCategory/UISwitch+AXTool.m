//
//  UISwitch+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 2017/1/3.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import "UISwitch+AXTool.h"
#import <objc/runtime.h>

typedef void(^ASwitchBlock)(UISwitch *aSwitch);


@interface UISwitch ()

@property (nonatomic, copy)ASwitchBlock aSwitchBlock;

@end


@implementation UISwitch (AXTool)
/**
 * 按钮事件封装成block
 */
- (void)ax_addTargetActionBlock:(void(^)(UISwitch *aSwitch))block{
    
    [self addTarget:self action:@selector(aSwitchEvents:) forControlEvents:UIControlEventValueChanged];
    self.aSwitchBlock = block;
}

- (void)aSwitchEvents:(UISwitch *)aSwitch{
    if (self.aSwitchBlock) {
        self.aSwitchBlock(aSwitch);
    }
}



- (void)setASwitchBlock:(ASwitchBlock)aSwitchBlock{
    objc_setAssociatedObject(self, @selector(aSwitchBlock),aSwitchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ASwitchBlock)aSwitchBlock{
    return objc_getAssociatedObject(self, @selector(aSwitchBlock));
}

@end




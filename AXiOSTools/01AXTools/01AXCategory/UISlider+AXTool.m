//
//  UISlider+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 2016/12/16.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UISlider+AXTool.h"
#import <objc/runtime.h>

typedef void(^SliderBlock)(UISlider *button);

@interface UISlider ()

@property (nonatomic, copy)SliderBlock sliderBlock;

@end
@implementation UISlider (AXTool)

- (void)ax_addTargetActionBlock:(void (^)(UISlider *))block{
    [self addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventValueChanged];
    self.sliderBlock = block;
}
- (void)buttonEvents:(UISlider *)sender{
    if (self.sliderBlock) {
        self.sliderBlock(sender);
    }
}

/**
 * cameraBlock set方法
 */
- (void)setSliderBlock:(SliderBlock)sliderBlock{
    objc_setAssociatedObject(self, @selector(sliderBlock),sliderBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/**
 * cameraBlock get方法
 */
- (SliderBlock)sliderBlock{
    return objc_getAssociatedObject(self, @selector(sliderBlock));
}
@end

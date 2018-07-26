//
//  UIView+AXSnapshot.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/26.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AXSnapshot)

- (void)ax_snapshot:(void(^)(UIImage *image))block;

@end

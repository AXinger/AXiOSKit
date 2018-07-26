//
//  IBUIView.h
//  AXiOSTools
//
//  Created by liuweixing on 16/8/5.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface IBUIView : UIView

/** 可视化设置圆角 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/** 可视化设置边框宽度 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/** 可视化设置边框颜色 */
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end

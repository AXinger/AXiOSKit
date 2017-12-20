//
//  IBUIButton.h
//  AXTools
//
//  Created by Mole Developer on 16/8/1.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface IBUIButton : UIButton

/** 可视化设置圆角 */
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;

/** 可视化设置边框宽度 */
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;

/** 可视化设置边框颜色 */
@property (nonatomic, strong)IBInspectable UIColor *borderColor;

@end

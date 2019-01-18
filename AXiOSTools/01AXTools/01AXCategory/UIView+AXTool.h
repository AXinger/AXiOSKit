//
//  UIView+AXTool.h
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXiOSToolsEnum.h"

@interface UIView (AXTool)
/**
 * 指定 角 进行圆角
 */
- (void)ax_roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat )cornerRadius;

/**
 * 左右颤动一下
 */
- (void)ax_shakeByLeftAndRight;

/**
 渐变色
 
 @param colorArray UIColor 数组
 */
- (void)ax_gradientColors:(NSArray <UIColor*>*_Nullable)colorArray;

/**
 为UIView的某个方向添加边框
 
 @param direction 边框方向
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)ax_addBorder:(AXBorderDirectionType)direction color:(UIColor *_Nullable)color width:(CGFloat)width;

/**
 阴影
 当前veiw.layer.cornerRadius 后会和layer.shadowRadius 冲突
 
 @param shadowColor UIColor
 */
- (void)ax_shadowWith:(UIColor *_Nullable)shadowColor;


/**
 * view 添加手势 成为点击事件
 */
- (void)ax_addViewActionBlock:(void(^_Nullable)(id _Nullable aView))block;

/**
 *  tag 只能是数字,
 *  所以定义一个string类型
 */
@property (nonatomic, copy)NSString * _Nullable axTag;

/**
 找出绑定 ax_tag 的对象
 
 @param tag ax_tag
 @return view
 */
- (nullable __kindof UIView *)ax_viewWithTag:(NSString * _Nullable )tag;

/**
 截屏 不含有转态栏  保存至相册
 */
- (void )ax_saveScreenShotsToPhotoAlbum;

/**
 当前view layer  重绘图片
 
 @return UIImage
 */
- (UIImage * _Nonnull )ax_drawRectToImage;

/**
 当前view layer  重绘图片,并保存到相册中
 */
- (void )ax_saveToPhotoAlbum;

/**
 layer 层 添加虚线
 
 @param lineLength 虚线每个长
 @param lineSpacing 虚线间隔
 @param lineColor 虚线颜色
 */
- (void)ax_addDottedLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *_Nonnull )lineColor;

/**
 活动view响应 UIViewController
 
 @return UIViewController
 */
- (UIViewController *)ax_viewController;

@end

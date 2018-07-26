//
//  UIImage+AXTool.h
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AXTool)
/**
 将图片变成指定尺寸
 image 需要重绘的图片
 size 指定大小
 返回新的图片
 */
- (UIImage *)ax_imageScaleToSize:(CGSize)size;

/**
 将图片剪切成 指定半径 圆形
 
 @param radius 半径
 @param borderWidth 边框的宽度
 @param borderColor 边框的颜色
 @return 返回新的图片
 */
- (UIImage *)ax_imageCircleWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 将图片剪切成圆形

 @param borderWidth 边框的宽度
 @param borderColor 边框的颜色
 @return 返回新的图片
 */
- (UIImage *)ax_imageCircleWithBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor *)borderColor;

/**
 *将图片剪切成圆形
 *@param borderWidth 边框的宽度
 *@param borderColor 边框的颜色
 *@return 返回新的图片
 */

- (UIImage *)ax_circleImageWithBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor *)borderColor;

/**
 *  画颜色色线, |______| 形状线图片
 */
+(UIImage *)ax_imageLineWithColor:(UIColor *)aColor;

/**
 *  画颜色线, ______ 形状线图片
 */
+(UIImage *)ax_imageStraightLineWithColor:(UIColor *)aColor;

/**
 * 圆背景,和颜色 ,线宽
 */
+(UIImage *)ax_imageWithCircleColor:(UIColor *)aColor Size:(CGSize )aSzize Width:(CGFloat )aWidht;

/**
 * 矩形颜色图片
 */
+(UIImage *)ax_imageRectangleWithSize:(CGSize )aSzize color:(UIColor *)aColor;

+(UIImage *)ax_imageWithColor:(UIColor *)color ;
/**
 * 圆形颜色图片
 */
+(UIImage *)ax_imageWithRadius:(CGFloat )radius color:(UIColor *)aColor;

/**
 * string 生成二维码
 */
+(UIImage *)ax_imageByString:(NSString *)codeStr toQRCodeWithWH:(CGFloat )wh;

/**
 * navigationBarTopImage
 */
+(UIImage *)navigationBarTopImage:(UIColor *)color;

/**
 *  去掉系统默认对图片的渲染(默认渲染成蓝色)，恢复图片原来的颜色
 *
 *  @param imageName 图片的名称
 *
 *  @return 未渲染的图片
 */
+ (instancetype)imageWithOriginalImageName:(NSString *)imageName;

/**
 初始化 UIImage 去掉系统默认对图片的渲染(默认渲染成蓝色)，恢复图片原来的颜色
 
 @param name name
 @return UIImage
 */
+ (instancetype)ax_imageOriginalByName:(NSString *)name;

/**
 矩形图片-->正方形图片 以图片中心为中心，以最小边为边长，裁剪正方形图片
 
 @return 剪切图片
 */
- (UIImage *)ax_imageRectangleToSquare;


/**
 微信分享图片,必须小于32kb,且是正方形
 
 @param imageUrl url
 @return image
 */
+ (UIImage *)ax_ImageWeChatShareZipWithUrl:(NSString *)imageUrl;


@end


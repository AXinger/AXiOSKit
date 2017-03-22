//
//  UIImage+AXTool.m
//  Financing118
//
//  Created by Mole Developer on 15/10/28.
//  Copyright © 2015年 MoleDeveloper. All rights reserved.
//

#import "UIImage+AXTool.h"

@implementation UIImage (AXTool)

/**
 *将图片变成指定尺寸
 *@param image 需要重绘的图片
 *@param size 指定大小
 *@return 返回新的图片
 */
+ (UIImage *)ax_imageScaleToSize:(UIImage *)image size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**剪切成圆形*/
+ (UIImage *)ax_imageCircleImageWithImage:(UIImage *)image AndBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor *)borderColor{
    //1.1.(计算画布尺寸,图片宽高+2倍线宽)
    CGFloat imageWidth = image.size.width + 2*borderWidth;
    CGFloat imageHeight = image.size.height + 2*borderWidth;
    
    //2.获取上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 1.0);
    
    //3.1.圆半径,以宽.高一半,最小的为半径
    CGFloat radius = MIN(image.size.width*0.5,image.size.height*0.5);
    //3.2.画圆
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth*0.5,imageHeight*0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //3.3.设置圆线宽
    bezierPath.lineWidth = borderWidth;
    
    //3.4.设置边界颜色
    [borderColor setStroke];
    [bezierPath stroke];
    //3.5.填充背景
    [[UIColor whiteColor] setFill];
    [bezierPath fill];
    
    //3.6.剪切
    [bezierPath addClip];
    
    //4.1.画图片
    [image drawInRect:CGRectMake(borderWidth, borderWidth,image.size.width,  image.size.height)];
    
    //5.得到新图片
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    //6关闭上下文
    UIGraphicsEndImageContext();
    //7.返回新图片
    return tempImage;
}

/**
 *将图片剪切成圆形
 *@param borderWidth 边框的宽度
 *@param borderColor 边框的颜色
 *@return 返回新的图片
 */

-(UIImage *)ax_circleImageWithBorderWidth:(CGFloat)borderWidth AndBorderColor:(UIColor *)borderColor{
    UIImage *image = self;
    //1.1.(计算画布尺寸,图片宽高+2倍线宽)
    CGFloat imageWidth = image.size.width + 2*borderWidth;
    CGFloat imageHeight = image.size.height + 2*borderWidth;
    
    //2.获取上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 1.0);
    
    //3.1.圆半径,以宽.高一半,最小的为半径
    CGFloat radius = MIN(image.size.width*0.5,image.size.height*0.5);
    //3.2.画圆
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth*0.5,imageHeight*0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //3.3.设置圆线宽
    bezierPath.lineWidth = borderWidth;
    
    //3.4.设置边界颜色
    [borderColor setStroke];
    [bezierPath stroke];
    //3.5.填充背景
    [[UIColor whiteColor] setFill];
    [bezierPath fill];
    
    //3.6.剪切
    [bezierPath addClip];
    
    //4.1.画图片
    [image drawInRect:CGRectMake(borderWidth, borderWidth,image.size.width,  image.size.height)];
    
    //5.得到新图片
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    //6关闭上下文
    UIGraphicsEndImageContext();
    //7.返回新图片
    return tempImage;

}


+(UIImage *)ax_imageLineWithColor:(UIColor *)aColor{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 4);
    UIBezierPath *path =[UIBezierPath bezierPath];
    //    NSArray *a = [NSArray arrayWithObject:path];
   
    //2.直接绘制路线
    [path moveToPoint:CGPointMake(0, 60)];
    [path addLineToPoint:CGPointMake(0, 75)];
    [path addLineToPoint:CGPointMake(80, 75)];
    [path addLineToPoint:CGPointMake(80, 60)];
    //3.关闭路径
    //    [path closePath];
    
    //4.设置线宽度
    path.lineWidth = 1;
    //4.2.线头的样式(线头多出的部分,才能看到)
    //    path.lineCapStyle = kCGLineCapRound;
    //4.3.线头连接处
    path.lineJoinStyle = kCGLineJoinBevel;
    //5.1.设置描边和填充的颜色
    [aColor setStroke];
    //    [[UIColor yellowColor]setFill];
    //5.2..按路径填充和描边颜色(有先后顺利,会影响描边的大小,2个单独的方法,C函数方法是三个方法)
    //    [path fill];
    [path stroke];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
    
    
}
/**
 *  画颜色线, ______ 形状线图片
 */
+(UIImage *)ax_imageStraightLineWithColor:(UIColor *)aColor{

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 4);
    UIBezierPath *path =[UIBezierPath bezierPath];
    //2.直接绘制路线
    [path moveToPoint:CGPointMake(0, 79)];
    [path addLineToPoint:CGPointMake(80, 79)];
    //3.关闭路径
    [path closePath];
    //4.设置线宽度
    path.lineWidth = 1;
    path.lineJoinStyle = kCGLineJoinBevel;
    [aColor setStroke];
    [path stroke];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
}

/**
 * 圆背景,和颜色
 */
+(UIImage *)ax_imageWithCircleColor:(UIColor *)aColor Size:(CGSize )aSzize Width:(CGFloat )aWidht{

    UIGraphicsBeginImageContextWithOptions(aSzize, NO,0);
    UIBezierPath *path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(aWidht, aWidht, aSzize.width-2*aWidht,aSzize.height-2*aWidht)];
    path.lineWidth = aWidht;
    [[UIColor whiteColor] setStroke];
    [aColor setFill];
    [path stroke];
    [path fill];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
}

/**
 * 矩形颜色图片
 */
+(UIImage *)ax_imageRectangleWithSize:(CGSize )aSzize color:(UIColor *)aColor{
    
    UIGraphicsBeginImageContextWithOptions(aSzize, NO,0);
    
     UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, aSzize.width, aSzize.height)];
    
    [[UIColor whiteColor] setStroke];
    [aColor setFill];
    [path stroke];
    [path fill];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
}

/**
 * 圆形颜色图片
 */
+(UIImage *)ax_imageWithRadius:(CGFloat )radius color:(UIColor *)aColor{
    UIGraphicsBeginImageContextWithOptions( CGSizeMake(radius*2, radius*2), NO,0);
     UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [[UIColor whiteColor] setStroke];
    [aColor setFill];
    [path stroke];
    [path fill];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
}

/**
 * string 生成二维码
 */
+(UIImage *)ax_imageByString:(NSString *)codeStr toQRCodeWithWH:(CGFloat )wh{
    // 生成二维码图片
    NSData *data = [codeStr dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:YES];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage *codeImage = filter.outputImage;
    
    // 消除模糊
    CGFloat scaleX = wh / codeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = wh / codeImage.extent.size.height;
    CIImage *transformedImage = [codeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

/**
 * navigationBarTopImage
 */
+(UIImage *)navigationBarTopImage:(UIColor *)color{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ax_kScreenWidth, 64), NO,0);
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ax_kScreenWidth, 64)];
    [color setFill];
    [path fill];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
    
}


/**
 *  去掉系统默认对图片的渲染(默认渲染成蓝色)，恢复图片原来的颜色
 *
 *  @param imageName 图片的名称
 *
 *  @return 未渲染的图片
 */
+ (instancetype)imageWithOriginalImageName:(NSString *)imageName{
    return  [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end

//
//  UIView+AXTool.m
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "UIView+AXTool.h"
#import "AXMacros_runTime.h"

typedef void(^DidViewBlock)(UIView *view);

@interface UIView ()<UIGestureRecognizerDelegate>

@property (nonatomic, copy)DidViewBlock didViewBlock;

@end
@implementation UIView (AXTool)

/**
 * 指定 角 进行圆角
 */
- (void)ax_roundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat )cornerRadius{
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}

/**
 * 左右颤动一下
 */
- (void)ax_shakeByLeftAndRight{
    
    UIView * view = self;
    
    // 获取到当前的View
    CALayer *viewLayer = view.layer;
    
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    // 设置自动反转
    [animation setAutoreverses:YES];
    
    // 设置时间
    [animation setDuration:.06];
    
    // 设置次数
    [animation setRepeatCount:3];
    
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}

/**
 渐变色

 @param colorArray UIColor 数组
 */
- (void)ax_gradientColors:(NSArray <UIColor*>*)colorArray{
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    NSMutableArray *array = [NSMutableArray array];
    for (UIColor *color in colorArray) {
        [array addObject:(id)color.CGColor];

    }
    gradient.colors = array.copy;
    [self.layer insertSublayer:gradient atIndex:0];
}


/**
 为UIView的某个方向添加边框
 
 @param direction 边框方向
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)ax_addBorder:(AXBorderDirectionType)direction color:(UIColor *)color width:(CGFloat)width{
    
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    switch (direction) {
        case AXBorderDirectionTop:
        {
            border.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, width);
        }
            break;
        case AXBorderDirectionLeft:
        {
            border.frame = CGRectMake(0.0f, 0.0f, width, self.bounds.size.height);
        }
            break;
        case AXBorderDirectionBottom:
        {
            border.frame = CGRectMake(0.0f, self.bounds.size.height - width, self.bounds.size.width, width);
        }
            break;
        case AXBorderDirectionRight:
        {
            border.frame = CGRectMake(self.bounds.size.width - width, 0, width, self.bounds.size.height);
        }
            break;
            
        default:
            break;
    }
    [self.layer addSublayer:border];
}


/**
 阴影
 当前veiw.layer.cornerRadius 后会和layer.shadowRadius 冲突

 @param shadowColor UIColor
 */
- (void)ax_shadowWith:(UIColor *)shadowColor{
    
    CALayer *subLayer=[CALayer layer];
    subLayer.frame = self.frame;
    subLayer.cornerRadius = 5;
    subLayer.backgroundColor = shadowColor.CGColor;
    subLayer.shadowColor = shadowColor.CGColor;//shadowColor阴影颜色
    subLayer.shadowOffset = CGSizeMake(0,1);//默认值 0,-3
    subLayer.shadowOpacity = 0.8;//阴影透明度，默认0
    subLayer.shadowRadius = 5;//阴影半径，默认3
    [self.superview.layer insertSublayer:subLayer below:self.layer];
}


/**
 * view 添加手势 成为点击事件
 */
- (void)ax_addViewTargetActionBlock:(void(^)(id aView))block{
    self.userInteractionEnabled = YES;
    self.didViewBlock = block;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self addGestureRecognizer:tap];
     tap.delegate = self;
    
}
- (void)tapGestureAction:(UIGestureRecognizer *)sender{
    if (self.didViewBlock) {
        self.didViewBlock(self);
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self]) {
        return YES;
    }
    return NO;
}

/**
 找出绑定 ax_tag 的对象
 
 @param tag ax_tag
 @return view
 */
- (nullable __kindof UIView *)ax_viewWithTag:(NSString *)tag{
    
    
    UIView *aView = nil;
    
    for (UIView *subView in self.subviews) {
        
        if([subView.axTag isEqualToString:tag]){
            aView = subView;
            break;
        }else{
           aView = [subView ax_viewWithTag:tag];
            if (aView) {
                 break;
            }
        }
    }
    
    return aView;
    
}

/**
 截屏 不含有转态栏  保存至相册 
 */
- (void )ax_saveScreenShotsToPhotoAlbum{
    
    CGSize size = [[UIApplication sharedApplication] keyWindow].rootViewController.view.frame.size;
      UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [[UIApplication sharedApplication].keyWindow.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(theImage, self, nil, nil);
}

/**
 当前view layer  重绘图片

 @return UIImage
 */
- (UIImage *)ax_drawRectToImage{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}



/**
  当前view layer  重绘图片,并保存到相册中
 */
- (void )ax_saveToPhotoAlbum{
   
    UIImage *theImage = [self ax_drawRectToImage];
    
    UIImageWriteToSavedPhotosAlbum(theImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}

//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    
}


#pragma mark - set and get

- (void)setDidViewBlock:(DidViewBlock)didViewBlock{
    ax_runtimePropertyObjSet(didViewBlock);
}

- (DidViewBlock)didViewBlock{
    return ax_runtimePropertyObjGet(didViewBlock);
}

- (void)setAxTag:(NSString *)axTag{
    ax_runtimePropertyObjSet(axTag);
}

- (NSString *)axTag{
    return ax_runtimePropertyObjGet(axTag);
}


@end

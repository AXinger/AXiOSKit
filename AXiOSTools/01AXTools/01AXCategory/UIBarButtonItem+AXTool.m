//
//  UIBarButtonItem+AXTool.m
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "UIBarButtonItem+AXTool.h"
#import "AXToolsHeader.h"
@implementation UIBarButtonItem (AXTool)

+ (instancetype)ax_itemWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 初始化 圆角图片UIBarButtonItem
 
 @param image image
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype)ax_itemRoundWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)ax_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //绑定事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    //    btn.size = btn.currentImage.size;
    btn.size = CGSizeMake(30, 30);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



/**封装Button作为一个item,并监听事件*/
+ (instancetype)ax_itemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName title:(NSString *)title{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //绑定事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    // 设置尺寸
    // 设置尺寸
    CGFloat imageWidth = button.currentImage.size.width;
    button.imageView.contentMode = 2;
    CGFloat tempWidth=[button.currentTitle ax_sizeWithaFont:button.titleLabel.font].width;
    button.size = CGSizeMake(imageWidth+tempWidth, 30);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


/**封装Button作为一个item,并监听事件*/
+ (instancetype)ax_itemWithImage:(UIImage *)image title:(NSString *)title Target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //绑定事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    // 设置尺寸
    // 设置尺寸
//    CGFloat imageWidth = button.currentImage.size.width;
    button.imageView.contentMode = 2;
    
    CGFloat tempWidth=[button.currentTitle ax_sizeWithaFont:button.titleLabel.font].width;
    
    button.size = CGSizeMake(40+tempWidth, 40);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


+ (instancetype)ax_itemRightWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName title:(NSString *)title{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //绑定事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.imageView.contentMode = 2;
    // 设置尺寸
    CGFloat imageWidth = button.currentImage.size.width;
   
    CGFloat tempWidth=[button.currentTitle ax_sizeWithaFont:button.titleLabel.font].width;
     button.size = CGSizeMake(imageWidth+tempWidth, 30);
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth-15, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, tempWidth, 0, 0)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];

}

+ (instancetype)ax_itemRightWithTitle:(NSString *)title normalImage:(NSString *)normalImage  selectImage:(NSString *)selectImage target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //绑定事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设置图片
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    button.imageView.contentMode = 2;
    // 设置尺寸
    CGFloat imageWidth = button.currentImage.size.width;
    
    CGFloat tempWidth=[button.currentTitle ax_sizeWithaFont:button.titleLabel.font].width;
    button.size = CGSizeMake(imageWidth+tempWidth, 30);
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth-15, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, tempWidth+5, 0, 0)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}


/**封装Button封装一个item,并监听事件*/
+ (instancetype)ax_itemWithNormalImage:(NSString *)normal disabledImage:(NSString *)disabled title:(NSString *)title  target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //绑定事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
     [button setImage:[UIImage imageNamed:disabled] forState:UIControlStateDisabled];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    // 设置尺寸
    // 设置尺寸
    CGFloat imageWidth = button.currentImage.size.width;
    button.imageView.contentMode = 2;
    CGFloat tempWidth=[button.currentTitle ax_sizeWithaFont:button.titleLabel.font].width;
    button.size = CGSizeMake(imageWidth+tempWidth, 30);
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


/**
 初始化未渲染图标的 UIBarButtonItem

 @param image image
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype)ax_itemOriginalImage:(NSString *)image target:(id)target action:(SEL)action{
    
    return [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:action];
}


/**
 初始化 指定UIButton未自定义内容

 @param btn UIButton
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype )ax_itemByButton:(UIButton *)btn target:(id)target action:(SEL)action{
  
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
   return  [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end

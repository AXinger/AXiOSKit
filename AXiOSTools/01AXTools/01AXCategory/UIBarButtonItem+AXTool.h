//
//  UIBarButtonItem+AXTool.h
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AXTool)
/**
 初始化 UIBarButtonItem
 
 @param image image
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype)ax_itemWithImage:(UIImage *)image target:(id)target action:(SEL)action;


/**
 初始化 圆角图片UIBarButtonItem
 
 @param image image
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype)ax_itemRoundWithImage:(UIImage *)image target:(id)target action:(SEL)action;


/**
 封装Button作为一个item,并监听事件 图片和高亮图片
 */
+ (instancetype)ax_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
+ (instancetype)ax_itemWithImage:(UIImage *)image title:(NSString *)title Target:(id)target action:(SEL)action;
/**
 封装Button作为一个item,-> 图片,文字, 监听事件
 */
+ (instancetype)ax_itemWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName title:(NSString *)title;

/**
 封装Button作为一个item ->右返回按钮 图片,文字, 监听事件
 */
+ (instancetype)ax_itemRightWithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName title:(NSString *)title;

/**封装Button封装一个item,并监听事件*/
+ (instancetype)ax_itemWithNormalImage:(NSString *)normal disabledImage:(NSString *)disabled title:(NSString *)title  target:(id)target action:(SEL)action;

+ (instancetype)ax_itemRightWithTitle:(NSString *)title normalImage:(NSString *)normalImage  selectImage:(NSString *)selectImage target:(id)target action:(SEL)action;

/**
 初始化未渲染图标的 UIBarButtonItem
 
 @param image image
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype)ax_itemOriginalImage:(NSString *)image target:(id)target action:(SEL)action;

/**
 初始化 指定UIButton未自定义内容
 
 @param btn UIButton
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (instancetype )ax_itemByButton:(UIButton *)btn target:(id)target action:(SEL)action;

@end

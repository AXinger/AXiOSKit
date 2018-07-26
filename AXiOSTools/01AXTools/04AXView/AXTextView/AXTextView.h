//
//  MyTextView.h
//  AXiOSTools
//
//  Created by liuweixing on 16/8/2.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXTextView : UITextView
/**
 * 占位文字
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 * 占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end

//
//  AXVeriCodeView.h
//  BigApple
//
//  Created by liuweixing on 2017/8/3.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXVeriCodeView : UIView

/**
 * 显示的字符串集合,默认集合 0-9  a-z A-Z
 */
@property (nonatomic, copy) NSArray *codeArray;
/**
 * 字符串数量,默认值 4
 */
@property (nonatomic, assign) NSInteger codeCount;

/**
 * 获得生成的字符串
 */
- (void)didShowCode:(void(^)(NSString *code))did;

/**
 * 刷新字符串
 */
- (void)refreshCode;

@end

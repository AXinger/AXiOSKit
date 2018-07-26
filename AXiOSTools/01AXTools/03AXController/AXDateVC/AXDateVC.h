//
//  AXDateVC.h
//  AXiOSTools
//
//  Created by liuweixing on 16/4/28.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXBaseAlertVC.h"


@interface AXDateVC : AXBaseAlertVC

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

/**
 时间选择器

 @param datePickerMode 时间类型
 @param showDate 当前显示时间
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelectPickerMode:(UIDatePickerMode )datePickerMode showDate:(NSDate *)showDate confirm:(void(^)(NSDate *date))confirm cancel:(void(^)(void))cancel;

/**
 时间选择器 默认显示 UIDatePickerModeDate 年月日

 @param showDate 当前显示时间
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelectDate:(NSDate *)showDate confirm:(void(^)(NSDate *date))confirm cancel:(void(^)(void))cancel;

@end

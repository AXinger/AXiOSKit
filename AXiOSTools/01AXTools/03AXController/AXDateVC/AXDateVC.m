//
//  AXDateVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/4/28.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXDateVC.h"

@interface AXDateVC ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, copy) void(^confirmBloack)(NSDate *date);

@property (nonatomic, copy) void(^cancelBlock)(void);

@end

@implementation AXDateVC

- (instancetype)init{
    self = [super init];
    if (self) {
        self.alertAnimationType = AXAlertAnimationTypeUpward;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.axContentView = self.contentView;
    self.alertAnimationType = AXAlertAnimationTypeUpward;
    self.datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelBtnEvents:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)centerButtonEvents:(UIButton *)sender {
    if (self.confirmBloack) {
        self.confirmBloack(self.datePicker.date);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - set and get

/**
 时间选择器
 
 @param datePickerMode 时间类型
 @param showDate 当前显示时间
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelectPickerMode:(UIDatePickerMode )datePickerMode showDate:(NSDate *)showDate confirm:(void(^)(NSDate *date))confirm cancel:(void(^)(void))cancel{
    
    if (showDate) {
        self.datePicker.date = showDate;
    }
    self.datePicker.datePickerMode = datePickerMode;
    self.confirmBloack = confirm;
    self.cancelBlock = cancel;
}

/**
 时间选择器 默认显示 UIDatePickerModeDate 年月日
 
 @param showDate 当前显示时间
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelectDate:(NSDate *)showDate confirm:(void(^)(NSDate *date))confirm cancel:(void(^)(void))cancel{
    
    [self didSelectPickerMode:UIDatePickerModeDate showDate:showDate confirm:confirm cancel:cancel];
}
@end

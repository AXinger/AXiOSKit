//
//  AXSinglePickVC.m
//  BigApple
//
//  Created by liuweixing on 2016/10/21.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXSinglePickVC.h"


@interface AXSinglePickVC ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (nonatomic, copy) void(^confirmBlock)(NSInteger index);

@property (nonatomic, copy) void(^cancelBlock)(void);

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, assign) NSInteger showRow;


@end

@implementation AXSinglePickVC


- (AXAlertControllerStyle)axAlertControllerStyle{
    
    return AXAlertControllerStyleUpward;
}
- (UIView *)axAlertControllerView {
    return self.contentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //    if (component == 0) {
    //        //        [pickerView selectedRowInComponent:1];
    //        [pickerView reloadComponent:1];
    //    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)caccelBtnEvents:(UIButton *)sender {
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)confirmBtnEvents:(UIButton *)sender {
    
    if (self.confirmBlock) {
        NSInteger selectComp = [self.pickerView selectedRowInComponent:0];
        self.confirmBlock(selectComp);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


/**
 单选
 
 @param dataArray 内容
 @param row 当前显示的row
 @param confirm 确定
 @param cancel 取消
 */
- (void)didSelected:(NSArray <NSString *>*)dataArray showRow:(NSInteger )row confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    self.dataArray = dataArray;
    self.confirmBlock  = confirm;
    self.cancelBlock = cancel;
    self.showRow = row;
    [self.pickerView reloadComponent:0];
    
    if (row<self.dataArray.count) {
        [self.pickerView selectRow:row inComponent:0 animated:YES];
    }
    
}

@end

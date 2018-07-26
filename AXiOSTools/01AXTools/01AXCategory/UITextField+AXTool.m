//
//  UITextField+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 2016/12/16.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UITextField+AXTool.h"

#import <objc/runtime.h>
#import "AXMacros_runTime.h"
#import "NSObject+AXKVO.h"

@interface UITextField ()<UITextFieldDelegate>

@property (nonatomic, copy) void(^textFieldTargetBlock)(UITextField *textField) ;

@property (nonatomic, copy) void(^didBeginBlock)(UITextField *textField) ;

@property (nonatomic, copy) void(^didEndBlock)(UITextField *textField) ;

@end

@implementation UITextField (AXTool)

/**
 * - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 方法中调用,控制输入的字符为最多2位小数的数字 包含0
 */
- (BOOL)ax_getTF2FloatRange:(NSRange)range string:(NSString *)string{
    
    UITextField *textField = self;
    
    BOOL isHaveDian = YES;
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为小数点
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if([textField.text length]==1 && [textField.text isEqualToString:@"0"]){
                if(single != '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return isHaveDian;
                }else
                {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    NSInteger tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}


/**
 UITextField 文字变化事件
 
 @param block block description
 */
- (void)ax_addTargetTextChangedBlock:(void(^)(UITextField *textField))block{
    
    [self addTarget:self action:@selector(textChnageAction:) forControlEvents:UIControlEventEditingChanged];
    self.textFieldTargetBlock = block;
}

- (void)textChnageAction:(UITextField *)textField{
    if (self.textFieldTargetBlock){
        self.textFieldTargetBlock(textField);
    }
}



/**
 UITextField 开始编辑 事件

 @param block 回调
 */
- (void)ax_addTargetTextDidBeginBlock:(void(^)(UITextField *textField))block{
    
    self.didBeginBlock = block;
    
//    [self ax_addNotificationForName:UITextFieldTextDidBeginEditingNotification block:^(NSNotification * _Nonnull notification) {
//
//        if (self.didBeginBlock){
//            self.didBeginBlock(self);
//        }
//    }];
    
    self.delegate = self;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.didBeginBlock){
        self.didBeginBlock(self);
    }
    return YES;
}


/**
 UITextField 文字结束事件
 
 @param block block description
 */
- (void)ax_addTargetTextEndBlock:(void(^)(UITextField *textField))block{
    
    [self addTarget:self action:@selector(textEndAction:) forControlEvents:UIControlEventEditingDidEnd];
    self.didEndBlock = block;
}

- (void)textEndAction:(UITextField *)textField{
    if (self.didEndBlock){
        self.didEndBlock(textField);
    }
}

#pragma mark - set and get
- (void)setDidEndBlock:(void (^)(UITextField *))didEndBlock{
     ax_runtimePropertyObjSet(didEndBlock);
}

- (void (^)(UITextField *))didEndBlock{
     return ax_runtimePropertyObjGet(didEndBlock);
}

- (void)setTextFieldTargetBlock:(void (^)(UITextField *))textFieldTargetBlock{
    ax_runtimePropertyObjSet(textFieldTargetBlock);
    
}


- (void (^)(UITextField *))textFieldTargetBlock{
    return ax_runtimePropertyObjGet(textFieldTargetBlock);
}


- (void)setDidBeginBlock:(void (^)(UITextField *))didBeginBlock{
    ax_runtimePropertyObjSet(didBeginBlock);
}
- (void (^)(UITextField *))didBeginBlock{
    return ax_runtimePropertyObjGet(didBeginBlock);
}
@end

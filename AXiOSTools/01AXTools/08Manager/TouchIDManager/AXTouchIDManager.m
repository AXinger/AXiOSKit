//
//  AXTouchIDManager.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXTouchIDManager.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AXMacros.h"

@interface AXTouchIDManager ()

@property (nonatomic, copy)void(^successBlock)(void);

@property (nonatomic, copy)void(^failureBlock)(void);

@property (nonatomic, copy)void(^inputPasswordBlock)(void);

@property (nonatomic, copy)void(^cancelBlock)(void);

@end

@implementation AXTouchIDManager

/**
 是否支持touch id
 
 @return 是否
 */
+ (BOOL )supportTouchID{
    
    LAContext *context = [[LAContext alloc] init];
    return  [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
}


/**
 是否支持touch id

 @return 是否
 */
- (BOOL )supportTouchID{
    
    return  [AXTouchIDManager supportTouchID];
}


/**
 打开touch id
 
 @param successBlock 成功
 @param failureBlock 3次失败,避免5次失败
 @param inputPasswordBlock 失败后,点击输入密码
 @param cancelBlock 点击取消
 */
- (void)openTouchIDWithSuccess:(void(^)(void))successBlock failure:(void(^)(void))failureBlock inputPassword:(void(^)(void))inputPasswordBlock cancel:(void(^)(void))cancelBlock {
    
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    self.inputPasswordBlock = inputPasswordBlock;
    self.cancelBlock = cancelBlock;
    
    [self openTouchIDWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics success:successBlock failure:failureBlock inputPassword:inputPasswordBlock cancel:cancelBlock];
    
}

#pragma mark - 内部方法（Private）

/*
 typedef NS_ENUM(NSInteger, LAError)
 {
 LAErrorAuthenticationFailed,     // 验证信息出错，就是说你指纹不对
 LAErrorUserCancel               // 用户取消了验证
 LAErrorUserFallback             // 用户点击了手动输入密码的按钮，所以被取消了
 LAErrorSystemCancel             // 被系统取消，就是说你现在进入别的应用了，不在刚刚那个页面，所以没法验证
 LAErrorPasscodeNotSet           // 用户没有设置TouchID
 LAErrorTouchIDNotAvailable      // 用户设备不支持TouchID
 LAErrorTouchIDNotEnrolled       // 用户没有设置手指指纹
 LAErrorTouchIDLockout           // 用户错误次数太多，现在被锁住了
 LAErrorAppCancel                // 在验证中被其他app中断
 LAErrorInvalidContext           // 请求验证出错
 }
 
 typedef NS_ENUM(NSInteger, LAPolicy)
 {
 LAPolicyDeviceOwnerAuthenticationWithBiometrics NS_ENUM_AVAILABLE(NA, 8_0) __WATCHOS_AVAILABLE(3.0) __TVOS_AVAILABLE(10.0) = kLAPolicyDeviceOwnerAuthenticationWithBiometrics,
 LAPolicyDeviceOwnerAuthentication NS_ENUM_AVAILABLE(10_11, 9_0) = kLAPolicyDeviceOwnerAuthentication
 
 }
 第一个枚举LAPolicyDeviceOwnerAuthenticationWithBiometrics就是说，用的是手指指纹去验证的；NS_ENUM_AVAILABLE(NA, 8_0)iOS8 可用
 第二个枚举LAPolicyDeviceOwnerAuthentication少了WithBiometrics则是使用TouchID或者密码验证,默认是错误两次指纹或者锁定后,弹出输入密码界面;NS_ENUM_AVAILABLE(10_11, 9_0)iOS 9可用
 */


/// 开启指纹扫描
- (void)openTouchIDWithPolicy:(LAPolicy )policy success:(void(^)(void))successBlock failure:(void(^)(void))failureBlock inputPassword:(void(^)(void))inputPasswordBlock cancel:(void(^)(void))cancelBlock{
    
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"输入密码";
    
    axSelfWeak;
    [context evaluatePolicy:policy localizedReason:@"请验证已有指纹" reply:^(BOOL success, NSError * _Nullable error) {
        
        axSelfStrong;
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *message = @"";
            
            if (success) {
                
                message = @"通过了Touch ID 指纹验证";
                
                if (self.successBlock) {
                    self.successBlock();
                }
                
            } else {
                //失败操作
                LAError errorCode = error.code;
                BOOL inputPassword = NO;
                switch (errorCode) {
                    case LAErrorAuthenticationFailed: {
                        // -1
                        message = @"连续三次指纹识别错误";
                        if (self.failureBlock) {
                            self.failureBlock();
                        }
                    }
                        break;
                        
                    case LAErrorUserCancel: {
                        // -2
                        message = @"用户取消验证Touch ID";
                        
                        if (self.cancelBlock) {
                            self.cancelBlock();
                        }
                    }
                        break;
                        
                    case LAErrorUserFallback: {
                        // -3
                        inputPassword = YES;
                        message = @"用户选择输入密码";
                        
                        if (self.inputPasswordBlock) {
                            self.inputPasswordBlock();
                        }
                    }
                        break;
                        
                    case LAErrorSystemCancel: {
                        // -4 TouchID对话框被系统取消，例如按下Home或者电源键
                        message = @"取消授权，如其他应用切入";
                    }
                        break;
                        
                    case LAErrorPasscodeNotSet: {
                        // -5
                        message = @"设备系统未设置密码";
                    }
                        break;
                        
                    case LAErrorTouchIDNotAvailable: {
                        // -6
                        
                        message = @"此设备不支持 Touch ID";
                    }
                        break;
                        
                    case LAErrorTouchIDNotEnrolled: {
                        // -7
                        message = @"用户未录入指纹";
                    }
                        break;
                        
                    case LAErrorTouchIDLockout: {
                        
                        // -8 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                        
                            if (@available(iOS 9.0, *)) {
                                
                                [self openTouchIDWithPolicy:LAPolicyDeviceOwnerAuthentication success:successBlock failure:failureBlock inputPassword:inputPasswordBlock cancel:cancelBlock];
                            } else {
                                
                                [self openTouchIDWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics success:successBlock failure:failureBlock inputPassword:inputPasswordBlock cancel:cancelBlock];
                            }
                        
                        message = @"Touch ID被锁，需要用户输入密码解锁";
                    }
                        break;
                        
                    case LAErrorAppCancel: {
                        // -9 如突然来了电话，电话应用进入前台，APP被挂起啦
                        message = @"用户不能控制情况下APP被挂起";
                    }
                        break;
                        
                    case LAErrorInvalidContext: {
                        // -10
                        message = @"Touch ID 失效";
                    }
                        break;
                        
                    default:
                        break;
                }
                AXLog(@"message>> %@",message);
            }
        });
    }];
}



@end

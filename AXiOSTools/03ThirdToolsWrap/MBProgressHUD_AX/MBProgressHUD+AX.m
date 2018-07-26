//
//  MBProgressHUD+AX.m
//

#import "MBProgressHUD+AX.h"

#define MBPafterDelay 1.3

@implementation MBProgressHUD (AX)

#pragma mark setup
/**
 * 新版本中,控制菊花的颜色用 在AppDelegate中用  [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor redColor];
 */
+(MBProgressHUD *)ax_setupMBProgressHUDInView:(UIView *)view text:(NSString *)text{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.textColor =  [UIColor whiteColor];
    hud.detailsLabel.textColor =  [UIColor whiteColor];
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wdeprecated-declarations"
//
//    hud.activityIndicatorColor = [UIColor whiteColor];
//
//#pragma clang diagnostic pop
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}


#pragma mark 显示信息
+ (void)ax_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    MBProgressHUD *hud =  [self ax_setupMBProgressHUDInView:view text:text];
    // 设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD_AX.bundle/%@", icon]]];
    
     hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"ax_%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor =  [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:MBPafterDelay];
}

#pragma mark 显示错误信息
+ (void)ax_showError:(NSString *)error toView:(UIView *)view{
    [self ax_show:error icon:@"error.png" view:view];
}

+ (void)ax_showSuccess:(NSString *)success toView:(UIView *)view{
    [self ax_show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)ax_showMessage:(NSString *)message toView:(UIView *)view{
    MBProgressHUD *hud =  [self ax_setupMBProgressHUDInView:view text:message];
    return hud;
}

+ (void)ax_showSuccess:(NSString *)success{
    [self ax_showSuccess:success toView:nil];
}
/**
 * 显示文字,不需要图片
 */
+ (void)ax_showTitle:(NSString *)title{
    
    [self ax_show:title icon:@"" view:nil];
}

+ (void)ax_showSuccess:(NSString *)success completed:(void(^)(void))completed{
    
    [self ax_showSuccess:success toView:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MBPafterDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (completed) {
            completed();
        }
    });
    
}


+ (void)ax_showError:(NSString *)error{
    [self ax_showError:error toView:nil];
}

+ (MBProgressHUD *)ax_showMessage:(NSString *)message{
    return [self ax_showMessage:message toView:nil];
}

+ (MBProgressHUD *)ax_showUpLoadMessage:(NSString *)message toView:(UIView *)view{
    MBProgressHUD *hud = [self ax_showMessage:message toView:view];
    hud.mode = MBProgressHUDModeDeterminate;
    return hud;
}

+ (MBProgressHUD *)ax_showUpLoadMessage:(NSString *)message{
    MBProgressHUD *hud = [self ax_showMessage:message];
    hud.mode = MBProgressHUDModeDeterminate;
    return hud;
}

+ (void)ax_showWarning:(NSString *)warning{
    [self ax_showWarning:warning toView:nil];
}

+ (void)ax_showWarning:(NSString *)warning toView:(UIView *)view{
    [self ax_show:warning icon:@"warning.png" view:view];
}


+ (void)ax_hideHUDForView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)ax_hideHUD{
    [self ax_hideHUDForView:nil];
}


@end

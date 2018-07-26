
//
//  MBProgressHUD+AX.h
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (AX)

/**
 显示菊花控件和文字 显示在window中,不会自动消失

 @param message 字符串
 @return MBProgressHUD
 */
+ (MBProgressHUD *)ax_showMessage:(NSString *)message;

/**
 显示菊花控件和文字 显示在toView中,不会自动消失

 @param message 字符串
 @param view view
 @return MBProgressHUD
 */
+ (MBProgressHUD *)ax_showMessage:(NSString *)message toView:(UIView *)view;

/**
 显示进度 控制 progress 显示在window中,不会自动消失

 @param message 字符串
 @return MBProgressHUD
 */
+ (MBProgressHUD *)ax_showUpLoadMessage:(NSString *)message;

/**
 显示进度 控制 progress 显示在toView中,不会自动消失

 @param message 字符串
 @param view toView
 @return MBProgressHUD
 */
+ (MBProgressHUD *)ax_showUpLoadMessage:(NSString *)message toView:(UIView *)view;


/**
 显示含有 √ 成功图片 显示在window中,会自动消失

 @param success 字符串
 */
+ (void)ax_showSuccess:(NSString *)success;

/**
 显示含有 √ 成功图片 显示在toView中,会自动消失

 @param success 文字
 @param view view
 */
+ (void)ax_showSuccess:(NSString *)success toView:(UIView *)view;


/**
 显示含有 ✘ 成功图片 显示在window中,会自动消失

 @param error 文字
 */
+ (void)ax_showError:(NSString *)error;

/**
 显示含有 ✘ 成功图片 显示在toView中,会自动消失

 @param error 文字
 @param view toView
 */
+ (void)ax_showError:(NSString *)error toView:(UIView *)view;

/**
 显示含有 ！ 成功图片 显示在window中,会自动消失

 @param warning 文字
 */
+ (void)ax_showWarning:(NSString *)warning;

/**
 显示含有 ！ 成功图片 显示在toView中,会自动消失

 @param warning 文字
 @param view toView
 */
+ (void)ax_showWarning:(NSString *)warning toView:(UIView *)view;

/**
  隐藏  window中的
 */
+ (void)ax_hideHUD;

/**
 隐藏 view中的

 @param view view
 */
+ (void)ax_hideHUDForView:(UIView *)view;

/**
 显示成功,含有回调

 @param success 文字
 @param completed completed
 */
+ (void)ax_showSuccess:(NSString *)success completed:(void(^)(void))completed;

/**
 显示文字,不需要图片

 @param title title
 */
+ (void)ax_showTitle:(NSString *)title;

@end

//
//  UIViewController+AXAlert.h
//  AXiOSTools
//
//  Created by liuweixing on 16/9/19.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AXAlert)


#pragma mark - sheet


/**
 *选择照片(相册或者拍照)含有编辑的样式
 @param edit  是否编辑
 @param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit block:(void(^)(UIImage *originalImage,UIImage *editedImage))block;

/**
 * Sheet  没有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm;

/**
 * Sheet 有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm  cancel:(void(^)(void))cancel;

/**
 * Sheet 退出登录
 */
- (void)ax_showSheeLogout:(void(^)(void))confirm;


#pragma mark - Alert


/**
 * Alert 只有确定,没有回调,只显示确定按钮文字
 */
- (void)ax_showAlertByTitle:(NSString *)title;

/**
 * Alert 只有确回调
 */
/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title confirm:(void(^)(void))confirm;

/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm;

/**
 * 有确定,取消 ,确定按钮文字
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel;


/**
 * Alert 有确定和取消
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel;


/**
 * Alert含有输入文本框
 */
- (void)ax_showAlertTFByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)( NSString *text))confirm cancel:(void(^)(void))cancel;

/**
 * Alert含有输入文本框
 */
- (void)ax_showAlertTF:(UITextField *)textF Title:(NSString *)title message:(NSString *)message confirm:(void(^)(UITextField *textF))confirm cancel:(void(^)(void))cancel;

/**
 * 流量网络下载,提示
 */
- (void)ax_showNetDownloadGo:(void(^)(void))confirm cancel:(void(^)(void))cancel;

/**
 * 数组 Alert 有取消回调
 */
- (void)ax_showAlertArrayByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel;
@end

//
//  UIViewController+AXAlert.m
//  AXiOSTools
//
//  Created by liuweixing on 16/9/19.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UIViewController+AXAlert.h"
#import <objc/runtime.h>
#import "UIViewController+AXTool.h"
#import "UIViewController+AXiPadAlert.h"

typedef void(^CameraEditBlock)(UIImage *originalImage,UIImage *editedImage);

@interface UIViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong)CameraEditBlock cameraEditBlock;

@end

@implementation UIViewController (AXAlert)

#pragma mark - Sheet


/**
 *选择照片(相册或者拍照)含有编辑的样式
 *@param edit  是否编辑
 *@param block originalImage原图  editedImage编辑后图片
 */
- (void)ax_showCameraWithEditing:(BOOL)edit block:(void(^)(UIImage *originalImage,UIImage *editedImage))block{
    [self  ax_showCameraWithEditing:edit showiPadView:nil block:block];
}

/**
 * Sheet  没有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm{
    
    [self ax_showSheetByiPadView:nil title:title message:message actionArray:actionArray confirm:confirm];
    
}

/**
 * Sheet 有取消回调
 */
- (void)ax_showSheetByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    [self ax_showSheetByiPadView:nil title:title message:message actionArray:actionArray confirm:confirm cancel:cancel];
}

/**
 * Sheet 退出登录
 */
- (void)ax_showSheeLogout:(void(^)(void))confirm{
    [self ax_showSheeLogoutByPadView:nil confirm:confirm];
}

#pragma mark - Alert

/**
 * 数组 Alert 有取消回调
 */
- (void)ax_showAlertArrayByTitle:(NSString *)title message:(NSString*)message actionArray:(NSArray <NSString*>*)actionArray confirm:(void(^)(NSInteger index))confirm cancel:(void(^)(void))cancel{
    
    [self ax_showAlertByiPadView:nil title:title message:message actionArray:actionArray confirm:confirm cancel:cancel];
    
}


/**
 * 只有确定,没有回调
 */
- (void)ax_showAlertByTitle:(NSString *)title{
    [self ax_showAlertByTitle:title confirm:nil];
}


/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title confirm:(void(^)(void))confirm{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(@"ax.i.know") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/**
 * 有确定和回调
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(@"ax.i.know") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
/*=======================================*/

/**
 * 有确定,取消 ,确定按钮文字
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(confirmTitle )style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 * 有确定,取消
 */
- (void)ax_showAlertByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel{
    
    [self ax_showAlertByTitle:title message:message confirmTitle:AXToolsLocalizedString(@"ax.confirm") confirm:confirm cancel:cancel];
}

/**
 * 流量网络下载,提示
 */
- (void)ax_showNetDownloadGo:(void(^)(void))go cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:AXToolsLocalizedString(@"当前网络为数据流量") message:AXToolsLocalizedString(@"是否取消下载") preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(@"继续下载") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (go) {
            go();
        }
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(@"取消下载") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark Alert+UITextField
/**
 * Alert含有输入文本框
 */
- (void)ax_showAlertTFByTitle:(NSString *)title message:(NSString *)message confirm:(void(^)( NSString *text))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    

    UITextField * textF=nil;
    __block typeof(textF)weaktextF = textF;

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        weaktextF = textField;
        textField.placeholder = message;
    }];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(@"ax.confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(weaktextF.text);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 * Alert含有输入文本框
 */
- (void)ax_showAlertTF:(UITextField *)textF Title:(NSString *)title message:(NSString *)message confirm:(void(^)( UITextField *textF))confirm cancel:(void(^)(void))cancel{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
     __block typeof(textF)weaktextF = textF;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = textF.placeholder;
        textField.keyboardType = textF.keyboardType;
        textField.secureTextEntry = textF.secureTextEntry;

        weaktextF = textField;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(@"ax.confirm") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(weaktextF);
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:AXToolsLocalizedString(@"ax.cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        if (cancel) {
            cancel();
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark分类重写 set get 方法
/**
 * cameraEditBlock set方法
 */
- (void)setCameraEditBlock:(CameraEditBlock)cameraEditBlock{
    objc_setAssociatedObject(self, @selector(cameraEditBlock),cameraEditBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 * cameraEditBlock get方法
 */
- (CameraEditBlock)cameraEditBlock{
    return objc_getAssociatedObject(self,@selector(cameraEditBlock));
}

@end

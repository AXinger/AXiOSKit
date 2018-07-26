//
//  AXOC2C.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXOC2C.h"
#import "AXMacros_log.h"

@implementation AXOC2C

/**
 是否能打开url
 
 @param str url str
 
 @return 是否打开
 */
BOOL ax_CanOpenURL(NSString *str){
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]];
}

/**
 * 打开URL
 */
BOOL ax_OpenURL(NSString *str){
    
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
#pragma clang diagnostic pop
    
    
}

/**
 拨打电话,弹出alert界面
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTelprompt(NSString *phone){
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phone]];
    return [[UIApplication sharedApplication] openURL:url];
#pragma clang diagnostic pop
}

/**
 拨打电话,直接拨打 拨打完电话回不到原来的应用，会停留在通讯录里，而且是直接拨打，不弹出提示
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTel(NSString *phone){
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
    return [[UIApplication sharedApplication] openURL:url];
#pragma clang diagnostic pop
}


/**
 xcode 奔溃日志
 */
void ax_LogXcodeCache(void){
    
    NSSetUncaughtExceptionHandler(&ax_uncaughtExceptionHandler);
}

static void ax_uncaughtExceptionHandler(NSException*exception) {
    AXLog(@"↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓  xcode运行崩溃  ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓");
    
    AXLog(@"xcode运行崩溃--> %@\n%@", exception, exception.callStackSymbols);
    
    AXLog(@"↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑  xcode运行崩溃  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑");
    
}



/**
 * AppStore链接,填写自己的iD
 */
NSString * ax_AppStoreURL(NSString *appId){
    return [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",appId];
}

/**
 AppStore 评分 url
 
 @param AppStoreID AppStoreID
 @return url String
 */
NSString * ax_AppStoreScoreURL(NSString *AppStoreID){
    return [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review",AppStoreID];
}

/**
 * int --> NSString
 */
NSString *ax_intToString(int aInt){
    return  [NSString stringWithFormat:@"%d",aInt];
}

/**
 * double --> NSString
 */
NSString *ax_doubleToString(double aDouble){
    return  [NSString stringWithFormat:@"%lf",aDouble];
}

/**
 * double --> NSString
 */
NSString *ax_floatToString(float aFloat){
    return  [NSString stringWithFormat:@"%f",aFloat];
}


/**
 * 获取一个随机整数，范围在包括0，不包括自身
 */
int ax_getRandomZeroToValue(int to){
    return arc4random() % to;
}


/**
 * 获取一个随机整数，范围在[from,to），包括from，包括to
 */
int ax_getRandomFromTo(int from ,int to){
    return (int)(from + (arc4random() % (to - from + 1)));
}

/**
 * 打开通用设置
 */
BOOL ax_OpenPrefsRoot(){
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
#pragma clang diagnostic pop
}

/**
 * str to URL
 */
NSURL *ax_URLStr(NSString *str){
    return [NSURL URLWithString:str];
}

/**
 是debug 环境下
 
 @return 是否
 */
BOOL ax_isDebug(){
    
#ifdef DEBUG
    return YES;
#else
    return NO;
#endif
    
}

/**
 创建xib

 @param name xib 名称
 @return UINib
 */
UINib * ax_Nib(NSString *name){
    return  [UINib nibWithNibName:name bundle:nil];
}

/**
 UIImage

 @param name 图片名
 @return UIImage
 */
UIImage * ax_Image(NSString *name){
    return  [UIImage imageNamed:name];
}


/*
 // 以下是设置其他界面
 prefs:root=General&path=About
 prefs:root=General&path=ACCESSIBILITY
 prefs:root=AIRPLANE_MODE
 prefs:root=General&path=AUTOLOCK
 prefs:root=General&path=USAGE/CELLULAR_USAGE
 prefs:root=Brightness
 prefs:root=Bluetooth
 prefs:root=General&path=DATE_AND_TIME
 prefs:root=FACETIME
 prefs:root=General
 prefs:root=General&path=Keyboard
 prefs:root=CASTLE
 prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 prefs:root=General&path=INTERNATIONAL
 prefs:root=LOCATION_SERVICES
 prefs:root=ACCOUNT_SETTINGS
 prefs:root=MUSIC
 prefs:root=MUSIC&path=EQ
 prefs:root=MUSIC&path=VolumeLimit
 prefs:root=General&path=Network
 prefs:root=NIKE_PLUS_IPOD
 prefs:root=NOTES
 prefs:root=NOTIFICATIONS_ID
 prefs:root=Phone
 prefs:root=Photos
 prefs:root=General&path=ManagedConfigurationList
 prefs:root=General&path=Reset
 prefs:root=Sounds&path=Ringtone
 prefs:root=Safari
 prefs:root=General&path=Assistant
 prefs:root=Sounds
 prefs:root=General&path=SOFTWARE_UPDATE_LINK
 prefs:root=STORE
 prefs:root=TWITTER
 prefs:root=FACEBOOK
 prefs:root=General&path=USAGE prefs:root=VIDEO
 prefs:root=General&path=Network/VPN
 prefs:root=Wallpaper
 prefs:root=WIFI
 prefs:root=INTERNET_TETHERING
 prefs:root=Phone&path=Blocked
 prefs:root=DO_NOT_DISTURB
 */

@end

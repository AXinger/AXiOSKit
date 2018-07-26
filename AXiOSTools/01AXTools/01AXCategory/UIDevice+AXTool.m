//
//  UIDevice+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/9/13.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UIDevice+AXTool.h"
#import <sys/utsname.h>
@implementation UIDevice (AXTool)


+ (NSArray *)ax_DeviceSize{
    
    NSArray *array = @[
                       @{
                           @"type":@(AXiPhone_4_0),
                           @"width":@(320),
                           @"height":@(568)
                           },
                       @{
                           @"type":@(AXiPhone_4_7),
                           @"width":@(375),
                           @"height":@(667)
                           },
                       @{
                           @"type":@(AXiPhone_5_5),
                           @"width":@(414),
                           @"height":@(736)
                           },
                       @{
                           @"type":@(AXiPhone_5_8),
                           @"width":@(375),
                           @"height":@(812)
                           },
                       @{
                           @"type":@(AXiPad_7_9),
                           @"width":@(768),
                           @"height":@(1024)
                           },
                       @{
                           //768x1024
                           @"type":@(AXiPad_9_7),
                           @"width":@(768),
                           @"height":@(1024)
                           },
                       @{
                           //1024x1366
                           @"type":@(AXiPad_12_9),
                           @"width":@(1024),
                           @"height":@(1366)
                           },
                       
                       ];
    
    return array;
}


+ (AXDeviceSize)ax_getiPhoneSize{
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    /** 获取当前程序界面的方向 */
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    /** 未知 */
    if (orientation == UIInterfaceOrientationUnknown) {
        return AXUnKnown;
    }
    
    NSArray *arry = [self ax_DeviceSize];
    
    /** 竖屏方向 */
    if (orientation == UIInterfaceOrientationPortrait) {
       
        for (NSDictionary *dict in arry) {
            
            if (width == [dict[@"width"]integerValue] && height == [dict[@"height"]integerValue]) {
                return [dict[@"type"]integerValue];
            }
        }
        
        
        /** 横屏方向 */
    }else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {//landscape
        
        for (NSDictionary *dict in arry) {
            if (height == [dict[@"width"]integerValue] && width == [dict[@"height"]integerValue]) {
                return [dict[@"type"]integerValue];
            }
        }
        
    }
    /** 其他情况 */
    return AXUnKnown;
}



/**
 * 手机型号
 */
+ (NSString *)ax_devicePlatForm{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}


@end

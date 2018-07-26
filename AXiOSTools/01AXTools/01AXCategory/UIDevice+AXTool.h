//
//  UIDevice+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 16/9/13.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

 /** 点 不是像素 */
typedef NS_ENUM(NSInteger, AXDeviceSize) {
    
    AXUnKnown=0,
    
    /*Phone 5
     iPhone 5s
     iPhone 5c
     iPhone SE
     
     320x568
     */
    AXiPhone_4_0,
    
    /*iPhone 6
     iPhone 6s
     iPhone 7
     iPhone 8
     
     375x667
     */
    AXiPhone_4_7,
    
    /*
     Phone 6 Plus
     iPhone 6s Plus
     iPhone 7 Plus
     iPhone 8 Plus
     
     414x736
     */
    AXiPhone_5_5,
    
    /*
     iPhone X
     
     375x812
     */
    AXiPhone_5_8,
    
    /*
     iPad Mini
     
     iPad Mini 2
     iPad Mini 3
     iPad Mini 4
     
     768x1024
     */
    AXiPad_7_9,
    
    /*
     Pad
     iPad 2
     
     iPad 3
     iPad 4
     iPad Air
     iPad Air 2
     iPad Pro 9.7
     
     768x1024
     
     */
    AXiPad_9_7,
    
    /*
     iPad Pro 12.9
     
     1024x1366
     */
    AXiPad_12_9,
};

@interface UIDevice (AXTool)

+ (AXDeviceSize)ax_getiPhoneSize;

/**
 * 手机型号
 */
+ (NSString *)ax_devicePlatForm;
@end

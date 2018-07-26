//
//  AXLocationManager.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

/**
 解决部分情况下 不弹出 定位 界面 直接初始化改实例对象
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, AXLocationState) {
    AXLocationStateWhenInUseAuthorization, // 使用时定位,普遍使用
    AXLocationStateAlwaysAuthorization // 一直定位
};

@interface AXLocationManager : NSObject

/**
 * <#注释#>
 */
@property(nonatomic,assign,readonly)AXLocationState locationState;


+ (instancetype )managerWithState:(AXLocationState )state result:(void(^)( BOOL resultState, CLLocation *location))resultBlock;



@end

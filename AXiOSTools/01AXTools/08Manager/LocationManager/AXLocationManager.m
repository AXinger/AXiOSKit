//
//  AXLocationManager.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXLocationManager.h"

@interface AXLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;


/**
 * 定位是否成功
 */
@property (nonatomic, assign,)BOOL isLocationSuccess;

@property (nonatomic, copy) void(^resultBlock)(BOOL state, CLLocation *location);

@end

@implementation AXLocationManager


+ (instancetype )managerWithState:(AXLocationState )state result:(void(^)( BOOL state, CLLocation *location))resultBlock{
    
    AXLocationManager *obj = [[AXLocationManager alloc]initWithState:state result:resultBlock];
  
    return obj;
}

- (instancetype )initWithState:(AXLocationState )state result:(void(^)( BOOL state, CLLocation *location))resultBlock{
    
    if (self = [super init]) {
        _locationState = state;
        self.resultBlock = resultBlock;
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10;//定位的频率,位置超出多少米定位一次
        [self.locationManager startUpdatingLocation];//启动定位
    }
    return self;
}


- (void)locationResult:(void(^)( BOOL resultState, CLLocation *location))resultBlock{
    
    self.resultBlock = resultBlock;
}


/**
 解决部分情况下 不弹出 定位 界面 直接初始化改实例对象
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:
            
            if (self.locationState == AXLocationStateWhenInUseAuthorization) {
                
                if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                    [manager requestWhenInUseAuthorization];
                }
            }else if (self.locationState == AXLocationStateAlwaysAuthorization){
                
                if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                    [manager requestAlwaysAuthorization];
                }
                
            }
            
            break;
        default:
            break;
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location = locations.firstObject;
    
    if (self.resultBlock) {
        self.resultBlock(YES,location);
    }
    
}




/**定位失败*/
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
 
    if (self.resultBlock) {
        self.resultBlock(NO,nil);
    }
    
}

@end

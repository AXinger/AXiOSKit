//
//  LocationManager.m
//  
//
//  Created by liuweixing on 15/11/9.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "LocationManager.h"
typedef void(^Location2D)(CLLocationCoordinate2D coordinate2D);

typedef void(^LocationBlock)(CLLocation *location);

@interface LocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, copy)Location2D  location2D;
/**
 * <#注释#>
 */
@property (nonatomic, copy) LocationBlock locationBlock;

@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong)CLGeocoder *geocoder;

@end



@implementation LocationManager
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupLocation];
    }
    return self;
}
- (void)setupLocation{
    
    self.locationManager = [[CLLocationManager alloc]init];//创建对象

    if (![CLLocationManager locationServicesEnabled]) { //判断是否开启定位功能
//        AXLog(@"未开启定位");
        if (self.location2D) {
            self.location2D(CLLocationCoordinate2DMake(-1, -1));
        }
        return;
    }
    

    
    if ([CLLocationManager authorizationStatus]<3) {
//        AXLog(@"请求开启定位");
//        self.noAuthorizationStatus = YES;
        [self.locationManager requestWhenInUseAuthorization];//请求开启定位服务
//         self.locationName(CLLocationCoordinate2DMake(-1, -1));
        return;
    }
    
    self.locationManager.delegate = self;//设置代理
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.locationManager.distanceFilter = 10;//定位的频率,位置超出多少米定位一次

    [ self.locationManager startUpdatingLocation];//启动定位
    
    
    
}


/**定位成功*/
//位置方法改变后执行(第一次定位某个位置之后执行)
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location = locations.firstObject;

    if ( self.location2D) {
        self.location2D(location.coordinate);
    }
    
    if (self.locationBlock) {
        self.locationBlock(location);
    }
    
    //编码
//    self.geocoder =[[CLGeocoder alloc]init];//地理编码
//    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        
//        CLPlacemark *placemark = placemarks.firstObject;
//        NSString *cityName = placemark.locality;//城市名称
////        NSString * country = placemark.country;
////        NSString * name= placemark.name;
//        AXLog(@"定位城市:%@",cityName);
//        //        self.locationName = cityName;
//       
//        self.locationName(cityName,location.coordinate);
//        
//    }];
    
}
- (void)Location2D:(void(^)(CLLocationCoordinate2D coordinate2D))location2D{
    if (location2D) {
         self.location2D = location2D;
    }
}

- (void)location:(void(^)(CLLocation *location))location{
    if (location) {
        self.locationBlock =location;
    }
}


/**定位失败*/
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    
//    AXLog(@"定位失败:");
    if (self.location2D) {
         self.location2D(CLLocationCoordinate2DMake(-1, -1));
    }
   
    

}

//始终定位代理方法
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
//    switch (status) {
//        case kCLAuthorizationStatusNotDetermined:
//            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
//            {
//                [self.locationManager requestWhenInUseAuthorization];
//            }
//            break;
//        default:
//            break;
//    }
//}
@end

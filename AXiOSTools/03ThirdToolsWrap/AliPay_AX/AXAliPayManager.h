//
//  AliPay.h
//  LearnDriving
//
//  Created by mac on 17/9/20.
//  Copyright © 2017年 chelichewai. All rights reserved.
//

#import <Foundation/Foundation.h>

/*AlipaySDK 里面的*/
//#import "Order.h"
//#import "DataSigner.h"
//#import <AlipaySDK/AlipaySDK.h>

typedef void(^AlipayBlock)(void);

@interface AXAliPayParamModel : NSObject

/**
 支付宝支付 key
 */
@property (nonatomic, copy) NSString *partner;

/**
 卖方key
 */
@property (nonatomic, copy) NSString *seller;

/**
 私钥
 */
@property (nonatomic, copy) NSString *privateKey;


/**
 通知回调url
 */
@property (nonatomic, copy) NSString *notifyURL;

/**
 appScheme 支付宝跳转 本app
 */
@property (nonatomic, copy) NSString *appScheme;

/**
 订单号
 */
@property (nonatomic, copy) NSString *tradeNO;

/**
 产品说明
 */
@property (nonatomic, copy) NSString *productName;


/**
 价格
 */
@property (nonatomic, copy) NSNumber *price;

@end


@interface AXAliPayManager : NSObject

/**
 支付宝支付

 @param paramModel 参数model
 @param success 成功
 @param failure 失败
 */
+ (void)AliPayWithParam:(AXAliPayParamModel *)paramModel success:(void(^)(void))success failure:(void(^)(NSString *errorName)) failure;


@end

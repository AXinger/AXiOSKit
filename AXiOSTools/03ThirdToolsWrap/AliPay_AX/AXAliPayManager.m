//
//  AliPay.m
//  LearnDriving
//
//  Created by mac on 17/9/20.
//  Copyright © 2017年 chelichewai. All rights reserved.
//

#import "AXAliPayManager.h"
#import "AXMacros_log.h"

@implementation AXAliPayParamModel

@end

@implementation AXAliPayManager


/**
 支付宝支付
 
 @param paramModel 参数model
 @param success 成功
 @param failure 失败
 */
+ (void)AliPayWithParam:(AXAliPayParamModel *)paramModel success:(void(^)(void))success failure:(void(^)(NSString *errorName)) failure{
    
//    NSString *partner = paramModel.partner;
//    NSString *seller = paramModel.seller;
//    NSString *privateKey = paramModel.privateKey;
//    NSString *notifyURL = paramModel.notifyURL;
//
//    if ([partner length] == 0 ||
//        [seller length] == 0 ||
//        [privateKey length] == 0 || notifyURL.length==0){
//
//        if (failure) {
//            failure(@"秘钥错误");
//        }
//        return;
//    }
//
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//
//    order.tradeNO = paramModel.tradeNO; //订单ID（由商家自行制定）
//    order.productName = paramModel.productName; //商品标题
//    order.amount = paramModel.price.description;
//
//    order.productDescription = @"e学e驾"; //商品描述
//    order.notifyURL = notifyURL; //回调URL
//
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"5m"; //超时时间
//    order.showUrl = @"m.alipay.com";
//
//
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//
//    NSString *signedString = [signer signString:orderSpec];
//
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                             orderSpec, signedString, @"RSA"];
//
//
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = paramModel.appScheme;
//
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//
//        AXLog(@"支付宝支付>> %@",resultDic);
//
//        if ([resultDic[@"resultStatus"] integerValue] == 9000) {
//
//            if (success) {
//                success();
//            }
//        }else{
//            if (failure) {
//                failure(resultDic[@"memo"]);
//            }
//        }
//    }];
}

@end

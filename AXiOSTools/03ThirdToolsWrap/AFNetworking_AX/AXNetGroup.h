//
//  AXNetGroup.h
//  BigApple
//
//  Created by liuweixing on 2017/11/15.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 参数 封装对象
 */
@interface AXNetGroup : NSObject
/**
 * url
 */
@property (nonatomic, copy) NSString *url;

/**
 * 参数
 */
@property (nonatomic, copy) NSMutableDictionary *parameter;

@end

/**
 * 返回结果,封装对象
 */
@interface AXNetGroupResult : NSObject
/**
 * url
 */
@property (nonatomic, copy) NSString *url;

/**
 * 当前请求 是否成功
 */
@property (nonatomic, assign,getter=isSuccess) BOOL success;

/**
 * 状态
 */
@property (nonatomic, assign) NSInteger state;

/**
 * 返回内容
 */
@property (nonatomic, strong)id  json;

@end

//
//  NSObject+AXRuntime.h
//  AXiOSToolsDemo
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 AX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AXRuntime)
/**
 *  得到一个类所有属性
 */
+ (NSArray *)ax_getProperties;

/**
 *  获得实例对象的属性及属性值
 *
 *  @return 字典
 */
- (NSDictionary *)ax_getProperties_aps;

/**
 * 把另外对象的属性值,赋值给自己
 */
- (void)ax_getValueFromObj:(NSObject *)otherObj;


/**
 *  替换 实例 方法 Instance
 */
+ (void)ax_replaceInstanceMethodWithOriginal:(SEL)originalSEL newSelector:(SEL)newSEL;

/**
 * 更换 类 方法
 */
+ (void)ax_replaceClassMethodWithOriginal:(SEL)originalSEL newSelector:(SEL)newSEL;

@end

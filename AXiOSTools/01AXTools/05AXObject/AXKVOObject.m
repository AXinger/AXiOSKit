//
//  AXKVOObject.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXKVOObject.h"

@implementation AXKVOObject

- (NSMutableArray *)muArray{
    if (!_muArray) {
        _muArray = [NSMutableArray array];
    }
    return _muArray;
}

- (NSMutableDictionary *)muDict{
    if (!_muDict) {
        _muDict = [NSMutableDictionary dictionary];
    }
    return _muDict;
}

@end

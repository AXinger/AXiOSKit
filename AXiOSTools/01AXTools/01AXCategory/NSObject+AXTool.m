//
//  NSObject+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSObject+AXTool.h"
#import "AXMacros_runTime.h"
#import <UIKit/UIKit.h>

@interface NSObject ()

@end

@implementation NSObject (AXTool)

/**
 NSObject转换json字串
 */
- (NSString *)ax_toJSONString{
    
    if ([self isKindOfClass:[NSString class]]) {
        
        return (NSString *)self;
        
    } else if ([self isKindOfClass:[NSData class]]) {
        
        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return  jsonStr;
}


/**
 封装 alloc]init]
 */
+ (instancetype)ax_init{
    return [[self alloc]init];
}

/**
 传值
 使用协议必须实现,不好用,使用属性,重写set无值,所以用方法
 
 @param value 值
 */
- (void)ax_setValue:(id)value{
    
}



/**
 获得 类 私有属性
 
 @return 数组
 */
+ (NSArray *)ax_getPrivateProperty{
    
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList(self.class, &outCount);
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (NSInteger i = 0; i < outCount; ++i) {
        // 遍历取出该类成员变量
        Ivar ivar = *(ivars + i);
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"name"] = @(ivar_getName(ivar)).description;
        dict[@"type"] = @(ivar_getTypeEncoding(ivar)).description;
        [temp addObject:dict];
        
    }
    // 根据内存管理原则释放指针
    free(ivars);
    
    return temp.copy;
}


/**
 是否 DEBUG 模式
 YES ->DEBUG
 NO-> release
 
 @return 结果
 */
+ (BOOL)isDebug{
    
#ifdef DEBUG
    
    return YES;
#else
    return No;
#endif
    
}

/**
 是否 iPad
 YES ->iPad
 NO-> iPhone
 @return 结果
 */
+ (BOOL)isiPad{
    
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
        return YES;
        
    }else{
        return NO;
    }
    
}


#pragma mark - set and get


- (void)setAx_pageIndex:(NSInteger)ax_pageIndex{
    ax_runtimePropertyAssSet(ax_pageIndex);
}

- (NSInteger)ax_pageIndex{
    return [ax_runtimePropertyAssGet(ax_pageIndex)integerValue];
}


- (void)setAx_backBlock:(AX_backBlock)ax_backBlock{
    ax_runtimePropertyObjSet(ax_backBlock);
}

- (AX_backBlock)ax_backBlock{
    return ax_runtimePropertyObjGet(ax_backBlock);
}

- (void)setAx_byValue:(id)ax_byValue{
    ax_runtimePropertyObjSet(ax_byValue);
}

- (id)ax_byValue{
    return ax_runtimePropertyObjGet(ax_byValue);
}



@end

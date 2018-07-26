//
//  NSObject+AXRuntime.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 AX. All rights reserved.
//

#import "NSObject+AXRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (AXRuntime)
/**
 *  得到一个类所有属性
 *
 *  @param cls 类型
 *
 *  @return 数组
 */
+ (NSArray *)ax_getProperties{
    Class class = self;
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList(class, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    free(properties);//释放内存
    
    return mArray.copy;
}


/**
 *  获得实例对象的属性及属性值
 *
 *  @return 字典
 */
- (NSDictionary *)ax_getProperties_aps{
    id class = self;
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([class class], &outCount);
    
    for (i = 0; i<outCount; i++){
        
        objc_property_t property = properties[i];
        
        const char* char_f =property_getName(property);
        
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue = [class valueForKey:(NSString *)propertyName];
        
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    
    free(properties);
    
    return props;
    
}

/**
 * 把另外对象的属性值,赋值给自己
 */
- (void)ax_getValueFromObj:(NSObject *)otherObj{
    NSObject *myObj = self;
    NSArray *myArray = [myObj.class ax_getProperties];
    
    NSDictionary *othrDict = [otherObj ax_getProperties_aps];
    
    for (NSString *str in myArray) {
        for (NSString *key in othrDict) {
            if ([str isEqualToString:key]) {
                //                id otherValue = othrDict[key];
                //                id myValue =objc_getAssociatedObject(self, (__bridge const void *)(str));
                //                myValue = [otherValue copy];
            }
        }
    }
    
}

/**
 * 更换方法
 */
+ (void)ax_replaceInstanceMethodWithOriginal:(SEL)originalSEL newSelector:(SEL)newSEL{
    
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, newSEL);
    BOOL didAddMethod = class_addMethod(class,originalSEL,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,newSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


/**
 * 更换 类 方法
 */
+ (void)ax_replaceClassMethodWithOriginal:(SEL)originalSEL newSelector:(SEL)newSEL{
    
    Class class = [self class];
    Method originalMethod = class_getClassMethod(class, originalSEL);
    Method swizzledMethod = class_getClassMethod(class, newSEL);
    BOOL didAddMethod = class_addMethod(class,originalSEL,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,newSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end

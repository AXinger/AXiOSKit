//
//  AXMacros_runTime.h
//  BigApple
//
//  Created by liuweixing on 2017/6/28.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#ifndef AXMacros_runTime_h
#define AXMacros_runTime_h
#import <objc/runtime.h>

/*
 
 分类重写set get 方法说明
 
 OBJC_ASSOCIATION_ASSIGN;            //assign策略
 OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
 OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
 
 OBJC_ASSOCIATION_RETAIN;
 OBJC_ASSOCIATION_COPY;
 
 
 * id object 给哪个对象的属性赋值
 const void *key 属性对应的key
 id value  设置属性值为value
 objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
 */


/**
 runtime 定义 NSObject 属性时,重新set方法
 
 @param value 属性名
 */
#define ax_runtimePropertyObjSet(value) objc_setAssociatedObject(self, @selector(value),value, OBJC_ASSOCIATION_COPY_NONATOMIC);

/**
 runtime 定义 NSObject 属性时,重新set方法
 
 @param value 属性名
 
 @return 当前属性
 */

#define ax_runtimePropertyObjGet(value) objc_getAssociatedObject(self,@selector(value));


/**
 runtime 定义 非NSObject 属性时,重新set方法
 
 @param value 属性名
 */
#define ax_runtimePropertyAssSet(value) objc_setAssociatedObject(self, @selector(value),@(value), OBJC_ASSOCIATION_COPY_NONATOMIC)

/**
 runtime 定义 非NSObject 属性时,重新set方法
 
 @param value 属性名
 
 @return 当前属性
 */
#define ax_runtimePropertyAssGet(value) objc_getAssociatedObject(self,@selector(value))


#endif /* AXMacros_runTime_h */

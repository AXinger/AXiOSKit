//
//  AXMacros.h
//  AXiOSTools
//
//  Created by liuweixing on 2017/1/3.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXMacros_runTime.h"
#import "AXMacros_addProperty.h"
#import "AXMacros_log.h"
#import "AXMacros_instance.h"
#import "AXMacros_value.h"




//import 不同类型
//#if __has_include(<YYWebImage/YYWebImage.h>)
//#import <YYWebImage/YYWebImage.h>
//#else
//#import "YYWebImage.h"
//#endif

/*
 过期宏 三种方式都是 第一种的宏
 
 __attribute__((deprecated(" ")));
 
 DEPRECATED_MSG_ATTRIBUTE ()
 
 DEPRECATED_ATTRIBUTE
 
 
 NS_UNAVAILABLE 当我们不想要其他开发人员，用普通的 init 方法去初始化一个类，我们可以在.h 文件里这样写：
 - (instancetype)init NS_UNAVAILABLE;
 
 NS_DESIGNATED_INITIALIZER 指定的初始化方法。当一个类提供多种初始化方法时，所有的初始化方法最终都会调用这个指定的初始化方法。比较常见的有：
 - (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
 
 */

//#define AX_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//
//#define AX_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


/**
 Class   alloc]init] 初始化

 @param Class Class
 @return 当前对象
 */
#define ax_Obj_init(Class) [[Class alloc]init]

/**
 * ax_kWeakObj(block 外面使用)
 */
#define axWeakObj(obj) __weak typeof(obj) obj##Weak = obj;

/**
 * StrongObj(block 里面使用)
 */
#define axStrongObj(obj) __strong typeof(obj) obj = obj##Weak;

/**
 * 弱引用 self
 */
#define axSelfWeak axWeakObj(self);

/**
 * 强引用 self
 */
#define axSelfStrong axStrongObj(self);


/***/

/**
 * ax_kWeakObj(block 外面使用)
 */
#define AX_WEAK_OBJ(obj) __weak typeof(obj) AxWeak##obj = obj;

/**
 * StrongObj(block 里面使用) obj = obj##Weak;
 */
#define AX_STRONG_OBJ(obj) __strong typeof(obj) obj = AxWeak##obj;

/**
 * 弱引用 self
 */
#define AX_WEAK_SELF AX_WEAK_OBJ(self);

/**
 * 强引用 self
 */
#define AX_STRONG_SELF AX_STRONG_OBJ(self);

/**
 * NSNotificationCenter
 */
#define axNotificationCenter [NSNotificationCenter defaultCenter]

/**
 * NSUserDefaults
 */
#define axUserDefaults [NSUserDefaults standardUserDefaults]

/**
 * NSUserDefaults synchronize
 */
#define axUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]

/**
 self.tableView.tableFooterView
 */
#define axTableFooterViewZero self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];


/**
 view 中 加载xib自定义view
 */
#define ax_load_xib_view \
self = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].lastObject;\
self.frame = frame;\

/**
 showHUD
 */
#define AX_showHUD_Message(String)  MBProgressHUD *hud = [MBProgressHUD ax_showMessage:String];
/**
 hideHUD 
 */
#define AX_hideHUD  [hud hideAnimated:YES];


/**
 * vc中定义一个同名的view替代原来的 aViewClass 需要替代的view
 */
#define AX_REDEFINE_CONTROLLER_VIEW_IMPL(aViewClass)\
@dynamic view;\
- (void)loadView{\
[super loadView];\
self.view = [[aViewClass alloc]init];\
}\
- (void)setView:(aViewClass *)view{\
[super setView:view];\
}\
- (aViewClass *)view{\
return (aViewClass *)[super view];\
}\

/**GCD 信号量创建*/
#define AX_LOCK_INIT dispatch_semaphore_t sem = dispatch_semaphore_create(0);
/**GCD 信号量发送*/
#define AX_UNLOCK dispatch_semaphore_signal(sem);
/**GCD 信号量等待*/
#define AX_LOCK dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);

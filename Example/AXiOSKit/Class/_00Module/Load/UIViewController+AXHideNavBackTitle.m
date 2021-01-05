//
//  UIViewController+AXHideNavBackTitle.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/5.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "UIViewController+AXHideNavBackTitle.h"

#import <objc/runtime.h>
#import <AXiOSKit/NSObject+AXRuntime.h>


@implementation UIViewController (AXHideNavBackTitle)

+(void)load {
    [UIViewController ax_replaceInstanceMethodWithOriginal:@selector(viewDidAppear:) newSelector:@selector(ac_viewDidAppear)];
}
 
/// 设置导航栏返回按钮文字
- (void)ac_viewDidAppear{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@""
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:nil];
    [self ac_viewDidAppear];
}



@end


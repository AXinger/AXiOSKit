//
//  AXAlertCenterAnimation.h
//  AXiOSToolsDemo
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 AX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXBaseAlertVC.h"

@interface AXAlertCenterAnimation : NSObject<UIViewControllerAnimatedTransitioning>
/**
 <#Description#>
 */
@property (nonatomic, strong)AXBaseAlertVC *alertVC;

- (instancetype)initWithVC:(AXBaseAlertVC *)alertVC;

@end

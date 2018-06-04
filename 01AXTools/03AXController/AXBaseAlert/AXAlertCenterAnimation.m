//
//  AXAlertCenterAnimation.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 AX. All rights reserved.
//

#import "AXAlertCenterAnimation.h"

@implementation AXAlertCenterAnimation

-(instancetype)initWithVC:(AXBaseAlertVC *)alertVC{
    if (self = [super init]) {
        self.alertVC = alertVC;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 1
    UIViewController *toVC = (AXBaseAlertVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (toVC.isBeingPresented) {
        return 0.3;
    }
    else if (fromVC.isBeingDismissed) {
        return 0.1;
    }
    
    return 0.3;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    AXBaseAlertVC *toVC = (AXBaseAlertVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (!toVC || !fromVC) {
        return;
    }
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (toVC.isBeingPresented) {
        
        [containerView addSubview:toVC.view];
        
        toVC.view.frame = containerView.bounds;
        
        toVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        
        CGAffineTransform oldTransform = toVC.axContentView.transform;
        toVC.axContentView.transform = CGAffineTransformScale(oldTransform, 0.3, 0.3);
        toVC.axContentView.center = containerView.center;
        
        [UIView animateWithDuration:duration animations:^{
            
            toVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            toVC.axContentView.transform = oldTransform;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    else if (fromVC.isBeingDismissed) {
        
        [UIView animateWithDuration:duration animations:^{
            fromVC.view.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}
@end

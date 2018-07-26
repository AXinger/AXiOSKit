//
//  AXBaseAlertVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/10/12.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXBaseAlertVC.h"
#import "UIView+AXFrame.h"
#import "AXAlertCenterAnimation.h"
#import "AXAlertUpwardAnimation.h"

@interface AXBaseAlertVC ()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>


@end

@implementation AXBaseAlertVC
// 以前方法
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//
//        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        self.view.backgroundColor = [UIColor clearColor];
//    }
//    return self;
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.axTouchesBeganDismiss = YES;
     self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.axTouchesBeganDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - 专场动画 UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    switch (self.alertAnimationType) {
        case AXAlertAnimationTypeCenter:
            return [[AXAlertCenterAnimation alloc] init];
            break;
            
        case AXAlertAnimationTypeUpward:
            return [[AXAlertUpwardAnimation alloc] init];
            break;
            
        default:
            break;
    }
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    switch (self.alertAnimationType) {
        case AXAlertAnimationTypeCenter:
            return [[AXAlertCenterAnimation alloc] init];
            break;
            
        case AXAlertAnimationTypeUpward:
            return [[AXAlertUpwardAnimation alloc] init];
            break;
            
        default:
            break;
    }
}


#pragma mark - 专场动画 UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
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
        
        toVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
        
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

//
//  MyViewController.m
//  AXiOSTools
//
//  Created by liuweixing on 16/5/26.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXViewController.h"
#import "AXToolsHeader.h"
@interface AXViewController ()

@end

@implementation AXViewController

+(AXNaviC *)navigationVC{
    
    AXViewController *myVC = [[self alloc]init];
    AXNaviC *nav = [[AXNaviC alloc]initWithRootViewController:myVC];
    return nav;
}

- (void)setShowDisItem:(BOOL)showDisItem{
    _showDisItem = showDisItem;
    if (self.showDisItem) {
        self.navigationItem.leftBarButtonItem =[[ UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(setButtonEvests:)];
    }
}
- (void)setButtonEvests:(UIBarButtonItem *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)loadView{
//    [super loadView];
//    self.view.bounds = [UIScreen mainScreen].bounds;
//}
- (void)dealloc{
    
    axLong_dealloc;
}

@end

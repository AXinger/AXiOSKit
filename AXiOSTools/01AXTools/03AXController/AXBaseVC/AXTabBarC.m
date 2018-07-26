//
//  AXTabBarC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/10/14.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXTabBarC.h"
#import "AXToolsHeader.h"
@interface AXTabBarC ()

@end

@implementation AXTabBarC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitle];
}
#pragma mark - 主题字体颜色等
- (void)setupTitle{
    NSDictionary *noDic= @{NSForegroundColorAttributeName : [UIColor grayColor]};
    NSDictionary *seDic= @{NSForegroundColorAttributeName : [UIColor lightGrayColor]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:noDic forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:seDic forState:UIControlStateSelected];
}


@end

//
//  MyTableViewController.m
//  AXiOSTools
//
//  Created by liuweixing on 16/5/26.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXTableViewController.h"
#import "AXToolsHeader.h"
@interface AXTableViewController ()

@end

@implementation AXTableViewController

+(AXNaviC *)navigationVC{
    AXNaviC *myVC = [[self alloc]init];
    AXNaviC *nav = [[AXNaviC alloc]initWithRootViewController:myVC];
    return nav;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView ax_footerViewZero];;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
}
- (void)dealloc{
    
    axLong_dealloc;
}

@end

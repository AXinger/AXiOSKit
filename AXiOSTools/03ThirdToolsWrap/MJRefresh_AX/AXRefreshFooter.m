//
//  AXRefreshFooter.m
//  BigApple
//
//  Created by liuweixing on 2018/4/18.
//  Copyright © 2018年 MoleDeveloper. All rights reserved.
//

#import "AXRefreshFooter.h"

@implementation AXRefreshFooter

- (void)prepare {
    [super prepare];
    self.stateLabel.textColor = [UIColor grayColor];
    //    [self setTitle:@"向上拉加载更多内容喔..." forState:MJRefreshStateIdle];
    //    [self setTitle:@"正在连接网络加载中...." forState:MJRefreshStateRefreshing];
    //    UISwitch *swith = [[UISwitch alloc] init];
    //    [self addSubview:swith];
    //    UIImageView *logoView = [[UIImageView alloc] init];
    //    logoView.image = [UIImage imageNamed:@"meinv02"];
    //    [self addSubview:logoView];
    //    self.logoView = logoView;
    [self setTitle:@"-我是有底线的-" forState:MJRefreshStateNoMoreData];
    
    self.stateLabel.textColor = [UIColor redColor];
}

/** * 摆放子控件 */
//- (void)placeSubviews {
//    [super placeSubviews];
//    self.logoView.x = 0;
//    self.logoView.width = self.width;
//    self.logoView.height = 100;
//    self.logoView.y = -self.logoView.height;
//
//}

@end

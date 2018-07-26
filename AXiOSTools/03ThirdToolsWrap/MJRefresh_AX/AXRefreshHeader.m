//
//  AXRefreshHeader.m
//  BigApple
//
//  Created by liuweixing on 2018/4/18.
//  Copyright © 2018年 MoleDeveloper. All rights reserved.
//

#import "AXRefreshHeader.h"

@implementation AXRefreshHeader

/** 初始化设置 */
- (void)prepare {
    [super prepare];
//    //创建UIImageView
//    UIImageView *logoView = [[UIImageView alloc] init];
//    //添加图片
//    logoView.image = [UIImage imageNamed:@"meinv02"];
//    //将该UIImageView添加到当前header中
//    [self addSubview:logoView];
//    self.arrowView = logoView;
//    //根据拖拽的情况自动切换透明度
//    self.automaticallyChangeAlpha = YES;
//    //隐藏时间
//    self.lastUpdatedTimeLabel.hidden = YES;
    //设置文字颜色
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

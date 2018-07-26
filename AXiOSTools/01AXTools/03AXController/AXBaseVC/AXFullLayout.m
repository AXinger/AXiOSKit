//
//  AXFullLayout.m
//  AXiOSTools
//
//  Created by liuweixing on 16/6/20.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXFullLayout.h"
#import "AXMacros.h"
@implementation AXFullLayout

- (void)invalidateLayout{
    [super invalidateLayout];
    [self setupLayout];
}

- (void)setupLayout{
    
    self.sectionInset = UIEdgeInsetsMake(0,0,0,0);//分区间的内边距
    //minimumLineSpacing = 0;这个是水平的间距 minimumInteritemSpacing
    self.minimumInteritemSpacing = 0;//列间距
    self.minimumLineSpacing = 0;//行间距
    self.itemSize = CGSizeMake(axScreenWidth, axScreenHeight-64-49); //item尺寸,
    self.scrollDirection =UICollectionViewScrollDirectionHorizontal;//滚动方向
}
@end

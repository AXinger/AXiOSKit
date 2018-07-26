//
//  AXHalfWidthLayout.m
//  AXiOSTools
//
//  Created by liuweixing on 16/8/24.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXHalfWidthLayout.h"
#import "AXToolsHeader.h"
@implementation AXHalfWidthLayout
//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        [self setupLay];
//    }
//    return self;
//}
//
//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self setupLay];
//    }
//    return self;
//}


- (void)invalidateLayout{
    [super invalidateLayout];
    //    self.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    
    self.itemSize = CGSizeMake(axScreenWidth*0.5-0.5, axScreenWidth*0.5-0.5); //item尺寸
    self.minimumInteritemSpacing = 1;//列间距
    self.minimumLineSpacing = 1;//行间距
    
    self.scrollDirection =UICollectionViewScrollDirectionVertical;//滚动方向
}
@end

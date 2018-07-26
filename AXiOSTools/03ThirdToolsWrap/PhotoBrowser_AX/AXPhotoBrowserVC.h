//
//  AXPhotoBrowserVC.h
//  AXiOSToolsDemo
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXViewController.h"
#import "GKPhotoBrowser.h"

@interface AXPhotoBrowserVC : GKPhotoBrowser

- (instancetype )initWithPhotoURLs:(NSArray *)photoURLsArray animatedFromView:(UIImageView *)view showIndex:(NSInteger )showIndex;

@end

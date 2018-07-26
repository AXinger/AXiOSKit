//
//  AXCycleScrollView.h
//  广告栏无限滚动
//
/**
 广告栏无限滚动AXCycleScrollView
 封装UICollectionView,定时滚动,手动滚动时,定时暂停.第一页,最后一页无缝滚动.
 
 主要思路为:数组 @[@"1.png",@"2.png",@"3.png"] 强制更改为  @[@"3.png",@"1.png",@"2.png",@"3.png",@"1.png"],
 初始化直接显示 [1]元素 位置;
 
 滚动完成后显示[0]元素(3.png) 时,直接强制滚动到 [4]元素(3.png),从而能无缝滚动,
 同理 滚动完成后显示[5]元素(1.png) 时,直接强制滚动到 [1]元素(1.png)
 
 代码:
 
 self.axView = [[AXCycleScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) imageNamesArray:temp];
 [self.view addSubview:self.axView];
 
 [self.axView didSelectItemAtIndex:^(NSInteger index) {
 NSLog(@"%ld",index);
 }];

 **/

//  Created by Mole Developer on 2017/7/6.
//  Copyright © 2017年 mole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXCycleScrollView : UIView

/**
 本地图片 轮播初始化方式
 
 @param frame frame
 @param imageNamesArray 本地图片名称 数组
 @return AXCycleScrollView
 */
- (instancetype)initWithFrame:(CGRect)frame imageNamesArray:(NSArray <NSString *>*)imageNamesArray;


/**
 网络图片URL 轮播初始化方式

 @param frame frame
 @param imageURLArray  网络图片 url sting 数组
 @param placeholderImage 无法加载网络图片 占位图片
 @return AXCycleScrollView
 */
-(instancetype)initWithFrame:(CGRect)frame imageURLArray:(NSArray <NSString *>*)imageURLArray placeholderImage:(UIImage *)placeholderImage;

/**
 * 本地图片名称 数组
 */
@property (nonatomic, strong)NSArray <NSString *>*imageNamesArray;

/**
 * 网络图片url 数组
 */
@property (nonatomic, strong)NSArray <NSString *> *imageURLArray;

/**
 * 网络图片时 占位图片
 */
@property (nonatomic, strong)UIImage *placeholderImage;

/**
 * 自动滚动间隔 默认3s
 */
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;

/**
 * 点击图片回调
 */
-(void)didSelectItemAtIndex:(void(^)(NSInteger index))blokc;


@end


@interface AXCycleScrollCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *aImageView;

@end

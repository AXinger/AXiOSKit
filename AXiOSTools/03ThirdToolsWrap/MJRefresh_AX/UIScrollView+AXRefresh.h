//
//  UIScrollView+AXRefresh.h
//  Xile
//
//  Created by Mole Developer on 2017/3/22.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface UIScrollView (AXRefresh)
/**
 * 初始化刷新
 */
- (void)ax_setRefreshHeader:(void(^)(void))header foot:(void(^)(void))foot;

/**
 控制 Footer hidden ,一般 有数据 YES 没有数据 NO
 
 @param hidden hidden description
 */
- (void)ax_setRefreshFooterHidden:(BOOL)hidden;

/**
 * 头开始刷新
 */
- (void)ax_setHeaderBeginRefreshing;

/**
 * 尾始刷新
 */
- (void)ax_setFootBeginRefreshing;

/**
 * 设置尾部无更多内容
 */
- (void)ax_setFootNoMore;

/**
 * 结束刷新
 */
- (void)ax_setEndRefresh;

/**
 * 取消头
 */
- (void)ax_setHeaderNULL;

/**
 * 取消尾
 */
- (void)ax_setFootNULL;

@end

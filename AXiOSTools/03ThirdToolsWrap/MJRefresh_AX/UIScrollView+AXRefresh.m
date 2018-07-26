//
//  UIScrollView+AXRefresh.m
//  Xile
//
//  Created by Mole Developer on 2017/3/22.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import "UIScrollView+AXRefresh.h"
#import "AXRefreshHeader.h"
#import "AXRefreshFooter.h"
@implementation UIScrollView (AXRefresh)
/**
 * 初始化刷新
 */
- (void)ax_setRefreshHeader:(void(^)(void))header foot:(void(^)(void))foot{
    if (header) {
        //        MJRefreshNormalHeader
        self.mj_header = [AXRefreshHeader headerWithRefreshingBlock:^{
            header();
        }];
        [self.mj_header beginRefreshing];
    }
    
    if (foot) {
        //        MJRefreshAutoNormalFooter
        self.mj_footer = [AXRefreshFooter footerWithRefreshingBlock:^{
            
            foot();
        }];
        //        self.mj_footer.automaticallyHidden = YES;
    }
}

/**
 控制 Footer hidden ,一般 有数据 YES 没有数据 NO
 
 @param hidden hidden description
 */
- (void)ax_setRefreshFooterHidden:(BOOL)hidden{
    
    if (self.mj_footer) {
        self.mj_footer.hidden = hidden;
    }
    
}

/**
 * 头开始刷新
 */
- (void)ax_setHeaderBeginRefreshing{
    [self.mj_header beginRefreshing];
}

/**
 * 尾始刷新
 */
- (void)ax_setFootBeginRefreshing{
    [self.mj_footer beginRefreshing];
}
/**
 * 设置尾部无更多内容
 */
- (void)ax_setFootNoMore{
    [self.mj_footer endRefreshingWithNoMoreData];
}

/**
 * 结束刷新
 */
- (void)ax_setEndRefresh{
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer) {
        [self.mj_footer endRefreshing];
    }
}

/**
 * 取消头
 */
- (void)ax_setHeaderNULL{
    if (self.mj_header) {
        self.mj_header = nil;
    }
}

/**
 * 取消尾
 */
- (void)ax_setFootNULL{
    if (self.mj_footer) {
        self.mj_footer = nil;
    }
}

@end

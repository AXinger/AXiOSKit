//
//  NSArray+AXTool.h
//  
//
//  Created by liuweixing on 15/11/18.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (AXTool)


/**
 * 0-9 a-z A-Z 集合
 */
+ (NSArray *)ax_numbernAndAlphabet;

/**
 倒数 内容
 
 @param count 个数
 @return 内容
 */
- (NSArray *)ax_lastObjetCount:(NSInteger )count;

/**
 总数组中,不重复随机一个数组
 
 @param count 个数
 @return array
 */
-(NSArray *)ax_randomArrayWithCount:(NSInteger )count;

/**
 升序
 
 @return NSArray
 */
- (NSArray *)ax_sortedAscending;
/**
 降序
 
 @return NSArray
 */
- (NSArray *)ax_sortedDescending;

@end

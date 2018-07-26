//
//  NSArray+AXTool.m
//  
//
//  Created by liuweixing on 15/11/18.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "NSArray+AXTool.h"

@implementation NSArray (AXTool)

/**
 * 0-9 a-z A-Z 集合
 */
+ (NSArray *)ax_numbernAndAlphabet{
    
    NSMutableArray *temp = [NSMutableArray array];
    
    //0-9
    for(int index=48; index<=57; index++) {
        unichar ch =index;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        [temp addObject:str];
    }
    
    
    //小写字母
    for(int index=97; index<=122; index++) {
        unichar ch =index;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        [temp addObject:str];
    }
    
    //大写字母
    for(int index=65; index<=90; index++) {
        unichar ch =index;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        [temp addObject:str];
    }
    
    return temp.copy;
    
}

/**
 倒数 内容

 @param count 个数
 @return 内容
 */
- (NSArray *)ax_lastObjetCount:(NSInteger )count{
    
    if (count>self.count) {
        count = self.count;
    }
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.count-count, count)];
    
    NSArray *temp = [self objectsAtIndexes:set];
    //倒序
    temp = [[temp reverseObjectEnumerator] allObjects];
    return temp;
}

/**
 总数组中,不重复随机一个数组
 
 @param count 个数
 @return array
 */
-(NSArray *)ax_randomArrayWithCount:(NSInteger )count{
    
    //随机数从这里边产生
    NSMutableArray *startArray = self.mutableCopy;
    
    //随机数产生结果
    NSMutableArray *resultArray = [NSMutableArray array];
    //随机数个数
    
    for (int i=0; i<count; i++) {
        int t=arc4random()%startArray.count;
        resultArray[i]=startArray[t];
        startArray[t]=[startArray lastObject]; //为更好的乱序，故交换下位置
        [startArray removeLastObject];
    }
    return resultArray;
}

/**
 升序
 
 @return NSArray
 */
- (NSArray *)ax_sortedAscending{
    
    NSArray *sortedArray = [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2];
    }];
    return sortedArray;
}

/**
 降序
 
 @return NSArray
 */
- (NSArray *)ax_sortedDescending{
    
    NSArray *sortedArray = [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj2 compare:obj1];
    }];
    return sortedArray;
}
@end

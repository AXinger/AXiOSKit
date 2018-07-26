//
//  AXNetManager+Group.m
//  BigApple
//
//  Created by liuweixing on 2017/11/15.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "AXNetManager+Group.h"
#import "AXNetManager+Base.h"
@implementation AXNetManager (Group)

dispatch_group_t _group;

//+ (void)postGroupURL:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(id json))success failure:(void(^)(NSInteger state))failure isLog:(BOOL )log{

+ (void)postGroup:(NSArray<AXNetGroup *> *)group complete:(void(^)(NSArray<AXNetGroupResult *> *results))complete isLog:(BOOL )log{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:group.count];
    
    for (int index=0; index<group.count; index++) {
        [results addObject:[AXNetGroupResult new]];
    }
    
    
//    dispatch_async(queue, ^{
    
        _group = dispatch_group_create();
        
        for (int index=0; index<group.count; index++) {
            
            dispatch_group_enter(_group);
            dispatch_group_async(_group, queue, ^{
                
                
                AXNetGroup *model  = group[index];
                
                [self postURL:model.url parameter:model.parameter success:^(id json) {
                    
                   AXNetGroupResult *result = results[index];
                    result.success = YES;
                    result.json = json;
                    
                    dispatch_group_leave(_group);
                    
                } failure:^(NSInteger state) {
                    
                    AXNetGroupResult *result = results[index];
                    result.success = NO;
                    result.state = state;
                    
                    dispatch_group_leave(_group);
                    
                } isLog:log];
                
            });
        }
    
        //因上面请求中有加入dispatch_group_enter 和 dispatch_group_leave,所以真正等待上面线程执行完才执行这里面的请求
        dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
            if (complete) {
                complete(results);
            }
        });
//    });
    
    
}


@end

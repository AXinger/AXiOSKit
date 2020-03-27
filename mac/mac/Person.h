//
//  Person.h
//  mac
//
//  Created by liuweixing on 2020/1/1.
//  Copyright © 2020 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSCopying>
/**
 *
 */
@property(nonatomic,copy)NSString *name;

+(void)add:(NSString *)str,...;

-(void)logShowTest;

@property(nonatomic,strong)id<TestProtocol> test;

@end

NS_ASSUME_NONNULL_END

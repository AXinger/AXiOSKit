//
//  NSURL+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/6/17.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSURL+AXTool.h"

@implementation NSURL (AXTool)

+(NSURL *)ax_URLByPhone:(NSString *)phone{
    return [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phone]];
}


@end

//
//  AXSetValueProtocol.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AXSetValueProtocol <NSObject>


- (void)ax_setCellWithValue:(id)value;

- (void)ax_setCellWithValue:(id)value indexPath:(NSIndexPath *)indexPath;

- (void)ax_setCellithValue:(id)value title:(NSString *)title;

- (void)ax_setCellWithValue:(id)value title:(NSString *)title indexPath:(NSIndexPath *)indexPath;

- (void)ax_setHeadViewWithValue:(id)model;

- (void)ax_setFootViewWithValue:(id)model;


+(void)ax_setCell:(id )cell value:(id)value;

+(void)ax_setCell:(id)cell value:(id)value indexPath:(NSIndexPath *)indexPath;

+(void)ax_setCell:(id )cell title:(NSString *)title value:(id)value;

+(void)ax_setCell:(id)cell title:(NSString *)title value:(id)value indexPath:(NSIndexPath *)indexPath;

+(void)ax_setHeadView:(UIView *)view value:(id)value;

+(void)ax_setFootView:(UIView *)view value:(id)value;


@end

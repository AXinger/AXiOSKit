////
////  DataBase.h
////  FMDB
////
////  Created by liuweixing on 16/4/5.
////  Copyright © 2016年 liuweixing. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "FMDB.h"
//
//@interface DataBase : NSObject
//
//
///**
// *  初始化方法 创建数据库
// *
// *  @param baseName 数据库名称
// */
//+ (instancetype)dataBaseWithName:(NSString *)baseName;
//
///**
// * 数据库路径
// */
//@property (nonatomic, copy) NSString *dbPath;
//
///**
// *  创建表
// *
// *  @param tableName 表名
// *  @param field     例-> {@"name":[NSString class]}  ......(图片-->NSData)
// */
//- (BOOL)createTable:(NSString*)tableName field:(NSDictionary *)field;
//
///**
// *  增 无判断条件
// *
// *  @param tableName 表名
// *  @param content 新增数据的内容 例-> {@"age" : @20}
// */
//- (BOOL)insertDataTable:(NSString *)tableName content:(NSDictionary *)content;
///**
// *  增 有判断条件
// *
// *  @param tableName 表名
// *  @param condition 新增数据的判断条件 例-> {@"age" : @20}
// *  @param condition 新增数据的内容 例-> {@"age" : @20}
// */
//- (BOOL)insertDataTable:(NSString *)tableName condition:(NSDictionary *)condition content:(NSDictionary *)content;
///**
// *  清除 指定条件的数据
// *
// *  @param tableName 表名
// *  @param condition 删除 例-> {@"age" : @20}
// */
//- (BOOL)removeDataTable:(NSString *)tableName condition:(NSDictionary *)condition;
//
///**
// *  清除表中所有数据
// *
// *  @param tableName 表名
// */
//- (BOOL)removeDataTable:(NSString *)tableName;
//
///**
// *  删除表
// *
// *  @param tableName 表名
// */
//- (BOOL)deleteTable:(NSString *)tableName;
//
///**
// *  改 where指定条件 set 修改的目标
// *
// *  @param tableName 表名
// *  @param condition 指定条件  例-> @{@"age" : @20}
// *  @param need      修改的目标  例-> @{@"age" : @20}
// */
//- (BOOL)updateDataTable:(NSString *)tableName condition:(NSDictionary *)condition need:(NSDictionary *)need;
//
///**
// *  查询表所有数据
// *
// *  @param tableName 表名 字典数组
// */
//- (NSMutableArray *)selectAllTable:(NSString *)tableName;
//
///**
// *  查询表 最后 几条 数据
// *
// *  @param table  表名
// */
//- (NSMutableArray *)selectAllTable:(NSString *)table number:(NSInteger )number;
//
///**
// *  查询指定条件 ( 2者都可以为空 )
// *
// *  @param tableName 表名
// *  @param condition 指定条件  例->@{@"age" : @20}
// *  @param need      返回字段  例-> @[@"age"] 字典数组
// */
//- (NSMutableArray *)selectTable:(NSString *)tableName condition:(NSDictionary *)condition need:(NSArray <NSString *>*)need;
//
///**
// *  查询表 数据数量
// *
// *  @param tableName 表名
// */
//- (NSInteger )selectTableCount:(NSString *)tableName;
//
//
//
//@end


////
////  DataBase.m
////  FMDB
////
////  Created by liuweixing on 16/4/5.
////  Copyright © 2016年 liuweixing. All rights reserved.
////
//
//#import "DataBase.h"
//#import "DBStatements.h"
//@interface DataBase()
//
///**
// *
// */
//@property (nonatomic, strong)FMDatabase *fmdb;
///**
// *
// */
//@property (nonatomic, strong)FMDatabaseQueue *fmdbQueue;
//
//@end
//
//@implementation DataBase
//
///**
// *  初始化方法
// *
// *  @param baseName 数据库名称
// */
//+ (instancetype)dataBaseWithName:(NSString *)baseName{
//    DataBase *dataBase = [[self alloc]init];
//    
//    NSString *dbPath =  [DBStatements dataBaseWithName:baseName];
//    dataBase.dbPath = dbPath;
//    AXLog(@"dbPath--> %@",dbPath);
//    dataBase.fmdb = [FMDatabase databaseWithPath:dbPath];
//    
//    dataBase.fmdbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
//    
//    BOOL open = [dataBase.fmdb open];
//    
//    if (!open) {
//        [dataBase.fmdb close];
//    }
//    return dataBase;
//}
//
//
///**
// *  创建表
// *
// *  @param tableName 表名
// *  @param field     例-> {@"name":[NSString class]}  ......(图片-->NSData)
// */
//- (BOOL)createTable:(NSString*)tableName field:(NSDictionary *)field{
//    [self.fmdb open];
//    NSString *executeUpdate =  [DBStatements createTable:tableName field:field];
//    BOOL create = [self.fmdb executeUpdate:executeUpdate];
//     AXLog(@"新建表 %@",create ? @"成功" :@"失败" );
//    return create;
//}
//
///**
// *  增 无判断条件
// *
// *  @param tableName 表名
// *  @param condition 新增数据 例-> {@"age" : @20}
// */
//- (BOOL)insertDataTable:(NSString *)tableName content:(NSDictionary *)content{
//
//    [self.fmdb open];
//    //    NSString *executeUpdate =  [DBStatements insertDataTable:table content:condition];
//    
//    NSString *executeUpdate = [DBStatements insertDataTable:tableName content:content];
//    
//    
//    
//    BOOL insert = [self.fmdb executeUpdate:executeUpdate];
//    
//    AXLog(@"新增语句 %@",insert ? @"成功" :@"失败" );
//    
//    return insert;
//
//}
///**
// *  增 有判断条件
// *
// *  @param tableName 表名
// *  @param condition 新增数据的判断条件 例-> {@"age" : @20}
// *  @param condition 新增数据的内容 例-> {@"age" : @20}
// */
//- (BOOL)insertDataTable:(NSString *)tableName condition:(NSDictionary *)condition content:(NSDictionary *)content{
//    [self.fmdb open];
////    NSString *executeUpdate =  [DBStatements insertDataTable:table content:condition];
//    
//    NSString *executeUpdate = [DBStatements insertDataTable:tableName condition:condition content:content];
//    
//    
//    BOOL insert = [self.fmdb executeUpdate:executeUpdate];
//    
//    AXLog(@"新增语句 %@",insert ? @"成功" :@"失败" );
//    
//    return insert;
//}
//
///**
// *  清除 指定条件的数据
// *
// *  @param tableName 表名
// *  @param condition 删除 例-> {@"age" : @20}
// */
//- (BOOL )removeDataTable:(NSString *)table condition:(NSDictionary *)condition{
//    [self.fmdb open];
//    NSString *executeUpdate =  [DBStatements removeDataTable:table content:condition];
//    BOOL delete = [self.fmdb executeUpdate:executeUpdate];
//    return delete;
//}
//
///**
// *  清除表中所有数据
// *
// *  @param tableName 表名
// */
//- (BOOL)removeDataTable:(NSString *)tableName{
//
//    return [self removeDataTable:tableName condition:nil];
//}
//
///**
// *  删除表
// *
// *  @param tableName 表名
// */
//- (BOOL)deleteTable:(NSString *)tableName{
//
//    [self.fmdb open];
//    NSString *executeUpdate =  [DBStatements deleteTable:tableName];
//    BOOL delete = [self.fmdb executeUpdate:executeUpdate];
//    return delete;
//}
//
///**
// *  改 where指定条件 set 修改的目标
// *
// *  @param tableName 表名
// *  @param condition 指定条件  例-> @{@"age" : @20}
// *  @param need      修改的目标  例-> @{@"age" : @20}
// *  @param result     回调
// */
//- (BOOL )updateDataTable:(NSString *)tableName condition:(NSDictionary *)condition need:(NSDictionary *)need{
//     [self.fmdb open];
//    
//    NSString *executeUpdate =  [DBStatements updateDataTable:tableName content:condition need:need];
//    BOOL update = [self.fmdb executeUpdate:executeUpdate];
//    return update;
//}
//
///**
// *  查询表 数据数量
// *
// *  @param tableName 表名
// */
//- (NSInteger)selectTableCount:(NSString *)tableName{
//    [self.fmdb open];
//    
//    NSString *executeUpdate =  [DBStatements selectTableCount:tableName];
//    NSInteger tableCount =[self.fmdb longForQuery:executeUpdate];
//    return tableCount;
//}
//
///**
// *  查询表所有数据
// *
// *  @param table  表名
// */
//- (NSMutableArray *)selectAllTable:(NSString *)table{
//    
//    return [self selectTable:table condition:nil need:nil];
//}
///**
// *  查询表 最后 几条 数据
// *
// *  @param table  表名
// */
//- (NSMutableArray *)selectAllTable:(NSString *)table number:(NSInteger )number{
//    
//    NSString *executeQuery =  [DBStatements selectTable:table nuber:number];
//    
//    FMResultSet *resultSet = [self.fmdb executeQuery:executeQuery];
//    
//    NSMutableArray *dataArray  = [NSMutableArray array];
//    //得到表的字段
//    NSArray *fieldArray = resultSet.columnNameToIndexMap.allKeys;
//    while (resultSet.next) {
//        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//        for (NSString * key in fieldArray) {
//            
//            dataDic[key] = [resultSet objectForColumnName:key];
//        }
//        
//        [dataArray addObject:dataDic];
//    }
//    
//    return dataArray;
//    
//}
//
///**
// *  查询指定条件,返回指定内容 ( 2者都可以为空 )
// *
// *  @param table  表名
// *  @param result 返回字段 数组
// *  @param condition  指定条件 数组
// *
// *  @return 字典数组
// */
//- (NSMutableArray *)selectTable:(NSString *)tableName condition:(NSDictionary *)condition need:(NSArray <NSString *>*)need{
//
//    [self.fmdb open];
//
//     NSString *executeQuery =  [DBStatements selectTable:tableName content:condition need:need];
//    
//    FMResultSet *resultSet = [self.fmdb executeQuery:executeQuery];
//
//    NSMutableArray *dataArray  = [NSMutableArray array];
//     //得到表的字段
//    NSArray *fieldArray = resultSet.columnNameToIndexMap.allKeys;
//    while (resultSet.next) {
//        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//        for (NSString * key in fieldArray) {
//            
//            dataDic[key] = [resultSet objectForColumnName:key];
//        }
//        
//        [dataArray addObject:dataDic];
//    }
//    
//    return dataArray;
//}
//
//@end


////
////  DBStatements.m
////  FMDB
////
////  Created by liuweixing on 16/4/7.
////  Copyright © 2016年 liuweixing. All rights reserved.
////
//
//#import "DBStatements.h"
//
//@implementation DBStatements
//
///**
// * 创建数据库路径
// */
//+(NSString *)dataBaseWithName:(NSString *)baseName{
//
//    //拼接路径
//    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *pathComponent = [NSString stringWithFormat:@"%@.sqlite",baseName];
//    NSString *dbPath = [docPath stringByAppendingPathComponent:pathComponent];
//    
//    //判断文件夹路径是否存在
//    NSString *deletingLastPath = [dbPath  stringByDeletingLastPathComponent];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:deletingLastPath]) {
//        [[NSFileManager defaultManager] createDirectoryAtPath:deletingLastPath withIntermediateDirectories:YES attributes:nil error:nil];
//        
//    } else {
//        
//    }
//    return dbPath;
//}
///**
// * 创建表
// */
//+(NSString *)createTable:(NSString*)tableName field:(NSDictionary *)field{
//    NSMutableArray *tempArray = [NSMutableArray array];
//    
//    for (NSString * key in field) {
//        
//        NSObject *value = field[key];
//        // text
//        if ( [value isEqual:[NSString class]]) {
//            
//            NSString *str = [NSString stringWithFormat:@"%@ text",key];
//            [tempArray addObject:str];
//        }
//        
//        //int   integer 属于 longLongIntForColumn
//        else   if ( [value isEqual:[NSNumber class]]) {
//            NSString *str = [NSString stringWithFormat:@"%@ int",key];
//            [tempArray addObject:str];
//        }
//        
//        // blob 图片  UIImage NSData
//        else if ( [value isEqual:[NSData class]]) {
//            NSString *str = [NSString stringWithFormat:@"%@ blob",key];
//            [tempArray addObject:str];
//        }
//        else {
//            NSAssert(0, @"**创建表字段为不正确的数据类型**");
//        }
//    }
//    
//    NSString *tempStr = [tempArray componentsJoinedByString:@","];
//    NSString *tempStr2 = [NSString stringWithFormat:@"(%@)",tempStr];
//    
//    //新建表 IF NOT EXISTS
//    NSString  *executeUpdate = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ %@",tableName,tempStr2];
//    
//    return executeUpdate;
//}
//
//
///**
// * 插入数据 语句
// */
//+(NSString *)insertDataTable:(NSString *)table content:(NSDictionary *)content{
//
//    NSString *key = [content.allKeys componentsJoinedByString:@","];
//
//    //拼接 ' ' 样式
//    NSMutableArray *valueArray = [NSMutableArray array];
//    
//    for (NSObject * value in content.allValues) {
//        
//        NSString *valueStr = [NSString stringWithFormat:@"'%@'",value];
//        
//        [valueArray addObject:valueStr];
//    }
//    
//    NSString *value = [valueArray componentsJoinedByString:@","];
//    
//    NSString *executeUpdate = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",table,key,value];
//    
//    return executeUpdate;
//    
//}
//
///**
// * 插入数据 含有判断字段 condition判断的条件 content需要插入的数据
// */
//+(NSString *)insertDataTable:(NSString *)table condition:(NSDictionary *)condition content:(NSDictionary *)content{
//
//    //所有的字段拼接,,所有值拼接,,形成 需要插入的字段 VALUES 需要插入的值 格式
//
//    NSString *key = [content.allKeys componentsJoinedByString:@","];
//    
//    //拼接 ' ' 样式
//    NSMutableArray *valueArray = [NSMutableArray array];
//    
//    for (NSObject * value in content.allValues) {
//        
//        NSString *valueStr = [NSString stringWithFormat:@"'%@'",value];
//        
//        [valueArray addObject:valueStr];
//    }
//    
//    NSString *value = [valueArray componentsJoinedByString:@","];
//    
//    NSString *executeUpdate = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",table,key,value];
//    
//    
//    
//    
//
//    NSString *conditionkey = [content.allKeys componentsJoinedByString:@","];
//    
//    //拼接 ' ' 样式
//    NSMutableArray *conditionvalueArray = [NSMutableArray array];
//    
//    for (NSObject * value in content.allValues) {
//        
//        NSString *valueStr = [NSString stringWithFormat:@"'%@'",value];
//        
//        [conditionvalueArray addObject:valueStr];
//    }
//    
//    NSString *conditionvalue = [valueArray componentsJoinedByString:@","];
//    
//    NSString *exists = [NSString stringWithFormat:@" if not exists (select * from %@ where %@ = %@ ) ",table,conditionkey,conditionvalue];
//    
//    
////if not exists (select * from myTable where iD=2 ) INSERT INTO myTable name VALUES 'TOM'
//    
////    return executeUpdate;
//    
//    return [NSString stringWithFormat:@"%@ %@",exists,executeUpdate];
//
//}
//
///**
// * 清除 语句
// */
//+(NSString *)removeDataTable:(NSString *)table content:(NSDictionary *)content{
//    
//    NSString *executeUpdate = nil;
//    
//    if (content.count>0) {
//        NSMutableArray *tempArray = [NSMutableArray array];
//        
//        //拼接  key = 'value'  样式
//        for (NSString * key in content) {
//            NSString *value = content[key];
//            
//            NSString *str = [NSString stringWithFormat:@"%@ = '%@'",key,value];
//            [tempArray addObject:str];
//        }
//        
//        NSString *tempStr = [tempArray componentsJoinedByString:@" AND "];
//        
//        executeUpdate = [NSString stringWithFormat:@"DELETE FROM  %@ WHERE %@",table,tempStr];
//    }else{
//        executeUpdate = [NSString stringWithFormat:@"DELETE FROM %@",table];
//    
//    }
//    
//    
//    return executeUpdate;
//}
//
///**
// * 删除表
// */
//+(NSString *)deleteTable:(NSString *)tableName{
//    NSString *drop = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@",tableName];
//    
//    return drop;
//}
//
///**
// * 修改语句
// */
//+(NSString *)updateDataTable:(NSString *)tableName content:(NSDictionary *)content need:(NSDictionary *)need{
//   
//    //拼接 条件字段语句
//    NSMutableArray *contentArray = [NSMutableArray array];
//    for (NSString * key in content) {
//        
//        NSString *value = content[key];
//        
//        NSString *str = [NSString stringWithFormat:@"%@ = '%@'",key,value];
//        [contentArray addObject:str];
//    }
//    NSString *contentStr = [contentArray componentsJoinedByString:@" and "];
//    
//    //拼接 返回字段语言
//    NSMutableArray *needArray = [NSMutableArray array];
//    for (NSString * key in need) {
//        NSString *value = need[key];
//        
//        NSString *str = [NSString stringWithFormat:@"%@ = '%@'",key,value];
//        [needArray addObject:str];
//    }
//    NSString *needStr = [needArray componentsJoinedByString:@","];
//    
//    NSString *executeUpdate = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",tableName,needStr,contentStr];
//    return executeUpdate;
//}
//
//
///**
// * 查询 最后几条 语句
// */
//+(NSString *)selectTable:(NSString *)tableName nuber:(NSInteger )number{
//
//
//    NSString * executeQuery = [NSString stringWithFormat:@"SELECT TOP %ld * FROM %@",(long)number,tableName];
//    return executeQuery;
//}
///**
// * 查询 语句
// */
//+(NSString *)selectTable:(NSString *)tableName content:(NSDictionary *)content need:(NSArray <NSString *>*)need{
//    
//    NSString *executeQuery = nil;
//    
//    //拼接条件字段 key = 'value' AND key = 'value' 样式
//    NSString *contentStr = nil;
//    
//    if (content != nil && content.count!=0) {
//        
//        NSMutableArray *array = [NSMutableArray array];
//        
//        for (NSString *key in content) {
//            
//            NSString *str = [NSString stringWithFormat:@"%@ = '%@'",key,content[key]];
//            [array addObject:str];
//        }
//        contentStr = [array componentsJoinedByString:@" AND "];
//    }
//    
//    //拼接返回字段 key,key  样式
//    NSString *needStr = nil;
//    if (need != nil && need.count!=0) {
//        
//        needStr =[need componentsJoinedByString:@" , "];
//    }
//    
//    BOOL needBOOL = need.count>0 ? YES :NO;
//    BOOL contentBOOL = content.count>0 ? YES :NO;
//    
//    
//    //所有数据
//    if ( !needBOOL && !contentBOOL) {
//        executeQuery = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
//    }
//    //查询条件,返回所有字段内容
//    else if (!needBOOL && contentBOOL){
//        
//        executeQuery = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@",tableName,contentStr];
//    }
//    //不需要条件,返回指定字段内容
//    else if ( needBOOL && !contentBOOL) {
//        
//        executeQuery = [NSString stringWithFormat:@"SELECT %@ FROM %@ ",needStr,tableName];
//    }
//    //指定条件,指定内容
//    else{
//        
//        executeQuery = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@",needStr,tableName,contentStr];
//    }
//    
//    return executeQuery;
//}
//
///**
// * 查询表 数据数量
// */
//+(NSString *)selectTableCount:(NSString *)tableName{
//
//    return [NSString stringWithFormat:@"select count(*) from %@",tableName];
//}
//
//
//@end


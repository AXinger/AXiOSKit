//
//  NSString+AXTool.h
//  44
//
//  Created by liuweixing on 15/8/25.
//  Copyright (c) 2015年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AXToolsHeader.h"
@interface NSString (AXTool)

/**
 * 文件路径
 */
+(NSString *)ax_documentPath;

/**
 * 文件路径
 */
+(NSString *)ax_libraryPaths;

/**
 * 文件路径
 */
+(NSString *)ax_tmpPath;

/**
 * 获得home后部分的路径,
 */
- (NSString *)ax_getDidHomePath;

/**
 * 拼接home路径,得到全路径
 */
- (NSString *)ax_addHomePath;

/**
 * 文字:计算单行文字size(系统重名)
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font;

/**
 * 文字:计算多行文字size(系统重名)
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font lineNumber:(NSInteger )number;

/**
 * 文字:根据指定宽度,得到高度
 
 */
- (CGFloat )ax_heightWithaFont:(UIFont *)font width:(CGFloat )width;

/**
 * 文字:根据指定宽度,得到size
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font width:(CGFloat )width;


/**
 * 随机生成指定长度的数字,字母组合的字符串
 */
+(NSString *)ax_stringRandomlyWithCount:(NSInteger )count;

/**
 * 项目工程版本号
 */

+(NSString *)ax_getAppVersion;

/**
 * 获取应用程序名称
 */
+ (NSString*)ax_getAppName;

/**
 * 获取应用程序 编译版本
 */
+ (NSString*)ax_getAppBulid;

/**
 * 获取应用程序的 BundleID
 */
+ (NSString*)ax_getAppBundleID;

/**
 * 获取应用程序的 infor 路径
 */
+ (NSString*)ax_getAppInfoPlistPath;

/**
 * 获取应用程序的 URLSchemes URLName为手工填入的
 */
+ (NSString*)ax_getAppURLSchemesByURLName:(NSString *)URLName;

/**
 * 获取设备的ip地址
 */
+(NSString *)ax_getDeviceIP;

/**
 * 获取设备信息
 */
+ (NSString *)ax_getDeviceInfo;

/**
 * string 生成二维码
 */
- (UIImage *)ax_stringToQRCodeWithWH:(CGFloat )wh;

/**
 * 拼接 tel://
 */
- (NSString *)ax_byPhone;

/**
 * 是否含有Emoji表情
 */
- (BOOL)ax_isContainsEmoji;

/**
 * 转换为UTF8,与UTF8String有区别
 */
- (NSString *)ax_toUTF8;

/**
 url Encoding 编码集
 
 @return NSString
 */
- (NSString *)ax_toEncoding;

/**
 Encoding 编码集 转  中文
 
 @return NSString
 */
- (NSString *)ax_toUnEncoding;

/**
 * 获得文件内,指定文件,只有文件名
 */
- (NSMutableArray *)ax_getFileNameListName:(NSString *)name;

/**
 * 获得文件内,指定文件,全路径
 */
- (NSMutableArray *)ax_getFileNameListFullpath:(NSString *)name;

/**
 * 获得文件内所以内容
 */
- (NSArray *)ax_getContentsOfDirectory;

/**
 * 显示万元单位
 */
- (NSString *)ax_keepWanYuan;

/**
 * 显示万元单位 ,有前缀
 */
- (NSString *)ax_keepWanYuanWithPrefix:(NSString *)prefix;

/**
 * 头部拼接一个字串
 */
- (NSString *)ax_addHeadPrefix:(NSString *)prefix;

/**
 截取头尾  中间显示*号
 
 @param headLength 头 需要保留的长度
 @param endLength 尾 需要保留的长度
 @return 返回结果
 */
- (NSString *)ax_substringHeadLength:(NSInteger )headLength endLength:(NSInteger )endLength;

/**
 11位手机号码,中间4位省略
 
 @return 号码
 */
- (NSString *)ax_phoneNumSecret;

/**
 * url 拼接,用别的办法,不然就出现 http:// 变成  http:/ 或者? 不识别
 */
- (NSString *)ax_urlStringtAppending:(NSString *)str;

/**
 生成唯一的字符串UUID
 
 @return 字符串
 */
+(NSString *)ax_uuid;

/**
 拼接成 tel:// 格式
 
 @return return value description
 */
- (NSURL *)ax_toTelURL;

/**
 2位小数 解决json解析小数异常,一般因为该小数为2位,所以这里强制用.2lf
 如用另外方法 ax_to2Decimal2
 
 @return NSString
 */
- (NSString *)ax_to2Decimal ;

/**
 2位小数
 @return NSString
 */
- (NSString *)ax_to2Decimal2;

/**
 NSString 转化 NSData
 
 @return NSData
 */
- (NSData *)ax_toData;

+(NSString *)ax_getHHMMSSWithSeconds:(NSInteger )seconds;

@end

//
//  NSString+AXTool.m
//  44
//
//  Created by liuweixing on 15/8/25.
//  Copyright (c) 2015年 liuweixing. All rights reserved.
//

#import "NSString+AXTool.h"
#import <CommonCrypto/CommonCrypto.h>
#include<stdio.h>
#include<stdlib.h>
#include<errno.h>
#include<string.h>
#include<sys/types.h>
#include<netinet/in.h>
#include<sys/socket.h>
#include<sys/wait.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<unistd.h>
#include <arpa/inet.h>
#include<netdb.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <net/if.h>
@implementation NSString (AXTool)


+(NSString *)ax_documentPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES ).firstObject;
}

+(NSString *)ax_libraryPaths {
    return  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
}

+(NSString *)ax_tmpPath{
    return  NSTemporaryDirectory();
}


/**
 * 获得home后部分的路径,
 */
- (NSString *)ax_getDidHomePath{
    NSString *temp = [NSString stringWithFormat:@"%@/",NSHomeDirectory()];
    return  [self componentsSeparatedByString:temp].lastObject;
}
/**
 * 拼接home路径,得到全路径
 */
- (NSString *)ax_addHomePath{
    NSString *home = NSHomeDirectory();
    return [home stringByAppendingPathComponent:self];
}


- (CGSize )ax_sizeWithLabel:(UILabel *)label{
    
    NSDictionary *attributes = @{NSFontAttributeName:label.font};
    CGSize size=[label.text boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}
/**
 * 文字:计算单行文字size(系统重名)
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}
/**
 * 文字:计算多行文字size(系统重名)
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font lineNumber:(NSInteger )number{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size=[self boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return CGSizeMake(size.width/number, size.height*number);
    
}

/**
 * 文字:根据指定宽度,得到高度
 */
- (CGFloat )ax_heightWithaFont:(UIFont *)font width:(CGFloat )width{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size.height;
}
/**
 * 根据指定宽度,得到size
 */
- (CGSize )ax_sizeWithaFont:(UIFont *)font width:(CGFloat )width{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
    
}
/**
 * 随机生成指定长度的数字,字母组合的字符串
 */
+(NSString *)ax_stringRandomlyWithCount:(NSInteger )count{
    
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < count; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

+ (NSDictionary*)ax_getAppInfo{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return info;
}

/**
 * 项目工程版本号
 */

+(NSString *)ax_getAppVersion{
    NSDictionary *info = [self ax_getAppInfo];
    return [info[@"CFBundleShortVersionString"]description];
}

/**
 * 获取应用程序名称
 */
+ (NSString*)ax_getAppName{
    NSDictionary *info = [self ax_getAppInfo];
    return info[@"CFBundleName"];
}

/**
 * 获取应用程序 编译版本
 */
+ (NSString*)ax_getAppBulid{
    NSDictionary *info = [self ax_getAppInfo];
    return info[@"CFBundleVersion"];
}

/**
 * 获取应用程序的 BundleID
 */
+ (NSString*)ax_getAppBundleID{
    NSDictionary *info = [self ax_getAppInfo];
    return info[@"CFBundleIdentifier"];
}

/**
 * 获取应用程序的 infor 路径
 */
+ (NSString*)ax_getAppInfoPlistPath{
    NSDictionary *info = [self ax_getAppInfo];
    return info[@"CFBundleInfoPlistURL"];
}

/**
 * 获取应用程序的 URLSchemes URLName为手工填入的
 */
+ (NSString*)ax_getAppURLSchemesByURLName:(NSString *)URLName{
    
    NSDictionary *bundleInfo = [NSBundle mainBundle].infoDictionary;
    NSArray *URLTypes = bundleInfo[@"CFBundleURLTypes"];
    
    //    NSString *bundleID=bundleInfo[@"CFBundleIdentifier"];
    
    
    NSString *scheme = nil;
    for (NSDictionary *dic in URLTypes) {
        if ([dic[@"CFBundleURLName"] isEqualToString:URLName]) {
            scheme = dic[@"CFBundleURLSchemes"][0];
            break;
        }
        ;
    }
    return scheme;
}

/** 获取设备的ip地址 */
+ (NSString *)ax_getDeviceIP{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd < 0) return nil;
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *deviceIP = ips.lastObject;
    return deviceIP;
}

/** 获取设备信息 */
+ (NSString *)ax_getDeviceInfo {
    UIDevice *device = [[UIDevice alloc] init];
    return [NSString stringWithFormat:@"%@|%@|%@",device.name,device.systemName,device.systemVersion];
}


/**
 * string 生成二维码
 */
- (UIImage *)ax_stringToQRCodeWithWH:(CGFloat )wh{
    NSString *codeStr = self;
    // 生成二维码图片
    NSData *data = [codeStr dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:YES];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage *codeImage = filter.outputImage;
    
    // 消除模糊
    CGFloat scaleX = wh / codeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = wh / codeImage.extent.size.height;
    CIImage *transformedImage = [codeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

/**
 * 拼接 tel://
 */
- (NSString *)ax_byPhone{
    return [NSString stringWithFormat:@"tel://%@",self];
}



//是否含有Emoji表情
- (BOOL)ax_isContainsEmoji{
    NSString *string = self;
    __block BOOL returnValue = NO;
    
    //    xF0\x9F\xA4\x97
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                    
                                    
                                    
                                }
                            }];
    
    return returnValue;
}


/**
 * 转换为UTF8,与UTF8String有区别
 */
- (NSString *)ax_toUTF8{
    return  [NSString stringWithCString:self.UTF8String encoding:NSUTF8StringEncoding];
}

/**
中文转 Encoding 编码集

 @return NSString
 */
- (NSString *)ax_toEncoding {
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];;
}

/**
 Encoding 编码集 转  中文
 
 @return NSString
 */
- (NSString *)ax_toUnEncoding {
    
    return [self stringByRemovingPercentEncoding];
}


/**
 * 获得文件内所有内容
 */
- (NSArray *)ax_getContentsOfDirectory{
    
    NSString *dirPath = self;
    
    
    //    NSMutableArray *filenamelist = [NSMutableArray array];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
        
        return @[];
    }
    
    
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    
    
    return tmplist;
}




/**
 * 获得文件内,指定文件,只有文件名
 */
- (NSMutableArray *)ax_getFileNameListName:(NSString *)name{
    
    return  [self ax_toolFileName:name type:@"Name"];
}

/**
 * 获得文件内,指定文件,全路径
 */
- (NSMutableArray *)ax_getFileNameListFullpath:(NSString *)name{
    
    return  [self ax_toolFileName:name type:@"Full"];
}

/**
 * 获得文件内,封装方法
 */
- (NSMutableArray *)ax_toolFileName:(NSString *)name  type:(NSString *)type{
    
    NSString *hostPath = self;
    
    NSMutableArray *temp = [NSMutableArray array];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:hostPath]) {
        
        return temp;
    }
    
    
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:hostPath error:nil];
    
    for (NSString *filename in tmplist) {
        
        NSString *fullpath = [hostPath stringByAppendingPathComponent:filename];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullpath]) {
            
            if ([[filename pathExtension] isEqualToString:name]) {
                if ([type isEqual:@"Full"]) {
                    [temp  addObject:fullpath];
                    
                }
                
                if ([type isEqual: @"Name"]) {
                    [temp  addObject:filename];
                    
                }
                
            }
        }
    }
    
    return temp;
    
}

/**
 * 显示万元单位
 */
- (NSString *)ax_keepWanYuan{
    if (self.doubleValue>10000) {
        return [NSString stringWithFormat:@"%.2lf 万元",self.doubleValue/10000];
    }else if (self.doubleValue>0){
        return [NSString stringWithFormat:@"%@ 元",self];
        
    }else{
        return  @"0 元";
    }
}

/**
 * 显示万元单位 ,有前缀
 */
- (NSString *)ax_keepWanYuanWithPrefix:(NSString *)prefix{
    if (self.doubleValue>10000) {
        return [NSString stringWithFormat:@"%@%.2lf 万元",prefix,self.doubleValue/10000];
    }else if (self.doubleValue>0){
        return [NSString stringWithFormat:@"%@%@ 元",prefix,self];
        
    }else{
        return [NSString stringWithFormat:@"%@0 元",prefix];
    }
}

/**
 * 头部拼接一个字串
 */
- (NSString *)ax_addHeadPrefix:(NSString *)prefix{
    return [NSString stringWithFormat:@"%@%@",prefix,self];
}


/**
 * 截取头尾  中间显示*号
 */
- (NSString *)ax_substringHeadLength:(NSInteger )headLength endLength:(NSInteger )endLength{
    
    NSInteger middleLength = self.length - headLength - endLength;
    
    if (middleLength<=0) {
        return self;
    }
    
    NSString *str1 = [self substringToIndex:headLength];
    NSString *str2 = [self substringFromIndex:self.length-endLength];
    NSMutableString *tempStr = [NSMutableString string];
    for (NSInteger index=0; index<middleLength; index++) {
        [tempStr appendString:@"*"];
    }
    
    return [NSString stringWithFormat:@"%@%@%@",str1,tempStr,str2];
    
}

/**
 * url 拼接,用别的办法,不然就出现 http:// 变成  http:/ 或者? 不识别
 */
- (NSString *)ax_urlStringtAppending:(NSString *)str{
    
    //    NSString *temp = nil;
    NSString *head = nil;
    if ( [self hasPrefix:@"https://"]) {
        head = @"https://";
    }else if ( [self hasPrefix:@"http://"]){
        head = @"http://";
    }
    NSString *temp = [[self componentsSeparatedByString:head].lastObject stringByAppendingPathComponent:str];
    return [NSString stringWithFormat:@"%@%@",head,temp];
}

/**
 生成唯一的字符串UUID
 
 @return 字符串,大写
 */
+(NSString *)ax_uuid{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uuidStr = (__bridge NSString *)uuidStrRef;
    CFRelease(uuidStrRef);
    return uuidStr;
}


/**
 11位手机号码,中间4位省略
 
 @return 号码
 */
- (NSString *)ax_phoneNumSecret{
    
    if (self.length==11) {
        NSString *numberString = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        return numberString;
    }else{
        return self;
    }
}



/**
 拼接成 tel:// 格式
 
 @return return value description
 */
- (NSURL *)ax_toTelURL{
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self]];
}



/**
 2位小数 解决json解析小数异常,一般因为该小数为2位,所以这里强制用.2lf
 如用另外方法 ax_to2Decimal2
 
 @return NSString
 */
- (NSString *)ax_to2Decimal {
    
    return [NSString stringWithFormat: @"%.2lf", self.doubleValue];
    
    //    double conversionValue = self.doubleValue;
    //    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    //    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    //    return decNumber.stringValue;
}

/**
 2位小数
 @return NSString
 */
- (NSString *)ax_to2Decimal2 {
    
    double conversionValue = self.doubleValue;
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return decNumber.stringValue;
}


/**
 NSString 转化 NSData
 
 @return NSData
 */
- (NSData *)ax_toData{
    
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}


+ (NSString *)ax_getHHMMSSWithSeconds:(NSInteger )seconds{
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
    
}

    
@end


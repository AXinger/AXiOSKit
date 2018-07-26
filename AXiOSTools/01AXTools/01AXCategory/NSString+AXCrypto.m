//
//  NSString+AXCrypto.m
//  BigApple
//
//  Created by liuweixing on 2016/12/1.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSString+AXCrypto.h"
#import "NSData+AXTool.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (AXCrypto)

/**
 MD5加密_普通算法
 */
- (NSString *)ax_MD5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result );
    
    NSMutableString *hash = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
        [hash appendFormat:@"%02X",result[i]];
    }
    return hash;
}

/**
 * DES 加密
 */
- (NSString *)ax_encryptDESWithKey:(NSString *)key
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSUInteger bufferSize = 1024 * 900;
    unsigned char buffer[bufferSize];
    memset(buffer, 0, bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSMutableString *result = [[NSMutableString alloc] init];
        short* b = (short*)malloc(numBytesEncrypted*2);
        for (int i = 0; i <numBytesEncrypted; i++)
        {
            [result appendFormat:@"%02X",buffer[i]];
        }
        free(b);
        plainText = result;
    }
    return plainText;
}

/**
 * DES  解密
 */
- (NSString*)ax_decryptDESWithKey:(NSString *)key{
    NSData* cipherData = [self ax_toBase64];
    NSUInteger bufferSize = 1024 * 100;
    unsigned char buffer[bufferSize];
    memset(buffer, 0,bufferSize);
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    
    if (cryptStatus == kCCSuccess) {
        plainText = [[NSString alloc] initWithBytes:buffer length:numBytesDecrypted encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
/**
 * 利用 GTMBase64 解碼 Base64 字串
 */
- (NSData *)ax_toBase64{
    NSInteger len = [self length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
       *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    free( buf );
    return data;
}


/**
 * DES 加密 Base64
 */
- (NSString *)ax_encryptDESBase64WithKey:(NSString *)key{
    NSData *textData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    NSUInteger  bufferSize = 1024;
    unsigned char buffer[bufferSize];
    memset(buffer, 0,bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          nil,
                                          [textData bytes], dataLength,
                                          buffer,bufferSize,
                                          &numBytesEncrypted);
    
    NSString *result = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        result = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    return result;
}

/**
 * DES  解密 Base64
 */
- (NSString*)ax_decryptDESBase64WithKey:(NSString *)key{
    NSData *cipherdata =  [[NSData alloc]initWithBase64EncodedString:self options:0];
    NSUInteger  bufferSize = 1024;
    unsigned char buffer[bufferSize];
    memset(buffer, 0,bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          nil,
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    NSString *result = nil;
    if(cryptStatus == kCCSuccess) {
        result = [[NSString alloc]initWithBytes:buffer length:(NSUInteger)numBytesDecrypted encoding:NSUTF8StringEncoding];
    }
    return result;
}

#pragma mark - 加密
/**
 * hmacSha1 加密
 */
- (NSString *)ax_hmacSha1:(NSString*)key{
    NSString *text = self;
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen (cKey), cData, strlen (cData), cHMAC);
    NSString *hash;
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for ( int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@ "%02x" , cHMAC[i]];
    hash = output;
    return hash;
}

/**
 * 对publickey和privatekey进行加密
 */
- (NSString *)ax_hmacSha1:(NSString*)public_key :(NSString*)private_key{
    
    NSData* secretData = [private_key dataUsingEncoding:NSUTF8StringEncoding];
    NSData* stringData = [public_key dataUsingEncoding:NSUTF8StringEncoding];
    
    const void* keyBytes = [secretData bytes];
    const void* dataBytes = [stringData bytes];
    
    void* outs = malloc(CC_SHA1_DIGEST_LENGTH);
    
    CCHmac(kCCHmacAlgSHA1, keyBytes, [secretData length], dataBytes, [stringData length], outs);
    
    NSData* signatureData = [NSData dataWithBytesNoCopy:outs length:CC_SHA1_DIGEST_LENGTH freeWhenDone:YES];
    return [signatureData base64EncodedStringWithOptions:0].uppercaseString;
}



/*
 *加密 3DES
 */
- (NSString *)ax_encrypt3DESWithKey:(NSString *)key{
    NSString *src  =self;
    const void *vplainText;
    size_t plainTextBufferSize;
    NSData* data = [src dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    plainTextBufferSize = [data length];
    vplainText = (const void *)[data bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *)[key UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return [myData ax_dataToHexString];
}

/*
 * 解密 3DES
 */
- (NSString *)ax_decrypt3DESWithKey:(NSString *)key{
    const void *vplainText;
    size_t plainTextBufferSize;
    NSData *EncryptData =  [self hexStrToNSData];
    
    plainTextBufferSize = [EncryptData length];
    vplainText = [EncryptData bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *)[key UTF8String];
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *dataBuf = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return [[NSString alloc] initWithData:dataBuf
                                 encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]
    ;
}


//十六进制字符串转化为二进制
- (NSData *)hexStrToNSData{
    NSString *hexStr = self;
    NSMutableData* data = [NSMutableData data];
    for (int i = 0; i+2 <= hexStr.length; i+=2) {
        NSRange range = NSMakeRange(i, 2);
        NSString* ch = [hexStr substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:ch];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    
    return data;
}


@end

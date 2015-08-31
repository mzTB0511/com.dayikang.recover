//
//  SignTool.m
//
//  Created by dd .
//  Copyright (c) 2014年 YangXudong. All rights reserved.
//

#import "SignTool.h"
#import <CommonCrypto/CommonHMAC.h>
#import "MF_Base64Additions.h"

@implementation SignTool

+(NSDictionary *)makeSignDict:(NSDictionary *)signDict secret:(NSString *)secret signKey:(NSString *)signKey{
    
    //如果没有需要加密的字典 直接返回nil
    if (!signDict || !signDict.count)
    {
        return nil;
    }
    
    //需加密字典的key值数组
    NSArray *arr_keys = [signDict.allKeys copy];
    
    //按升序排列
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    
    //排序以后的数组
    arr_keys = [arr_keys sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    //等待拼接的参数字符串
    NSString *paramsString = @"";
    
    //遍历数组 拼接参数字符串
    for (NSString *aKey in arr_keys)
    {
        paramsString = [paramsString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",aKey,[signDict objectForKey:aKey]]];
    }
    
    paramsString = [paramsString substringToIndex:[paramsString length] - 1];
    
    NSString *signString = [SignTool hmacsha1:paramsString secret:secret];
    
    NSLog(@"拼接字符串:%@ , 加密字符串:%@",paramsString,signString);
    
    //返回的带加密信息的字典
    NSMutableDictionary *dic_postParamsDictionary = [NSMutableDictionary dictionaryWithDictionary:signDict];
    
    [dic_postParamsDictionary setValue:signString forKey:signKey];

    return dic_postParamsDictionary;
}


/**
 *  加密方法
 *
 *  @param data 待加密字符串
 *  @param key  密钥
 *
 *  @return 返回的加密参数
 */
+ (NSString *)hmacsha1:(NSString *)data secret:(NSString *)key {
    
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];//CC_SHA1_DIGEST_LENGTH
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return hash;
}

@end

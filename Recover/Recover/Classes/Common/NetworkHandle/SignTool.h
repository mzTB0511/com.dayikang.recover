//
//  SignTool.h
//
//  Created by dd .
//  Copyright (c) 2014年 YangXudong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignTool : NSObject

/**
 *  将字典加密
 *
 *  @param signDict 原字典
 *  @param secret   秘钥
 *  @param signKey  签名字符串对应的key
 *
 *  @return 加密后的字典
 */
+ (NSDictionary *) makeSignDict:(NSDictionary *)signDict secret:(NSString *)secret signKey:(NSString *)signKey;

@end

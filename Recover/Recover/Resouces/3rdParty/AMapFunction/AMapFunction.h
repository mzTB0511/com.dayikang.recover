//
//  AMapFunction.h
//  BabySante
//
//  Created by YangXudong on 15/5/12.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AMapFunctionBlockUserLocation)(NSString *latitude, NSString *longitude);

typedef void(^AMapFunctionBlockUserLocationAndCity)(NSString *latitude, NSString *longitude, NSString *city);

typedef void(^AMapFunctionBlockSearchResult)(NSArray *result);

typedef void(^AMapFunctionBlockFailure)(void);

/**
 *  高德地图相关处理
 */
@interface AMapFunction : NSObject

/**
 *  获取用户经纬度和地理位置并执行方法
 *
 *  @param block    执行的方法
 *  @param failure  失败后执行的方法
 */
+ (void) action_getUserLocationAndCityWithBlock:(AMapFunctionBlockUserLocationAndCity)block failure:(AMapFunctionBlockFailure)failure;

@end

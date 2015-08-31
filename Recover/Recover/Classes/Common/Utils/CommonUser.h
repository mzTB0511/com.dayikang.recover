//
//  CommonUser.h
//  BabySante
//
//  Created by dd on 15/4/14.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

/**
 *  用户信息操作 登录相关等
 */
@interface CommonUser : NSObject

#pragma mark - 设置底部栏的badge

/**
 *  重新设置状态
 */
+ (void) action_resetTabBarStatus;

+ (void) action_cacheTabBarBadgeInfo:(NSArray *)badgeInfo;

+ (NSArray *) action_getCacheTabBarBadgeInfo;

+ (void) action_setTabBarBadge:(NSString *)badge atIndex:(NSInteger)index;

#pragma mark - 把app启动后要执行的动作缓存在本地

+ (void) action_setCacheAction:(NSDictionary *)action;

+ (NSDictionary *) action_getCacheAction;

#pragma mark - 缓存餐别数据

/**
 *  缓存餐别数据
 */
+ (void) action_cacheMealType;

/**
 *  从本地获取缓存数据
 */
+ (NSArray *) action_getMealType;


#pragma mark - 缓存最新数据到本地 / 读取本地数据

/**
 *  缓存首页数据到本地
 *
 *  @param homeData 首页数据
 */
+ (void) action_cacheHomeData:(NSArray *)homeData;

/**
 *  从本地获取缓存数据
 *
 *  @return 缓存数据  如果为nil则没有数据
 */
+ (NSArray *) action_getCacheData;

#pragma mark - 上传用户位置

/**
 *  上传用户经纬度
 */
+ (void) action_uploadUserLocation;

#pragma mark - 上传状态数据

/**
 *  上传用户状态数据
 *
 *  @param info             状态数据
 *  @param completionBlock  如果设置了block 则设置状态完成后会执行此block  如果不设置 则默认直接跳转到首页
 */
+ (void) uploadUserStatusInfo:(NSDictionary *)info completionBlock:(CommonBlock)completionBlock;

/**
 *  上传用户的体征数据
 *
 *  @param data            体征数据
 *  @param completionBlock 上传完成后调用方法
 */
+ (void) uploadUserDataInfo:(NSDictionary *)data completionBlock:(CommonBlock)completionBlock;

#pragma mark - 切换 Root VC

/**
 *  获取 main tab bar vc
 */
+ (UITabBarController *) mainTabBarViewController;

/**
 *  切换到下一个视图
 */
+ (void) pushToNextViewController;

/**
 *  切换到首页
 */
+ (void) pushToMainViewController;

/**
 *  切换到选择用户状态
 */
+ (void) pushToUserStatusChooseViewController;

/**
 *  切换到用户引导页
 */
+ (void) pushToUserGuideViewController;

/**
 *  切换到登录页
 */
+ (void) pushToUserLoginViewController;

#pragma mark - 用户数据

/**
 *  用户退出登录
 */
+ (void) userLogout;

/**
 *  登录成功后执行的方法
 *
 *  @param responseDictionary 成功后返回的数据
 *  @param block              其他执行的方法
 */
+ (void) userLoginSuccess:(NSDictionary *)responseDictionary block:(CommonBlock)block;

/**
 *  获取user id
 */
+ (NSString *) userID;

/**
 *  用户数据 isTempUser 为1说明是临时用户
 */
+ (UserInfo *) userInfo;

/**
 *  用户是否登录了 yes说明已登录
 */
+ (BOOL) ifUserHasLogin;

/**
 *  用户是否已经设置了用户状态(在服务器设置了)
 */
+ (BOOL) ifUserSetStatus;

/**
 *  将用户信息存储在本地
 */
+ (void) setUserInfo:(UserInfo *)userInfo;

/**
 *  取设备UDID
 */
+ (NSString *) udid;

/**
 *  注册百度云推
 *
 *  @param bdcid 百度云推返回的channelID
 *  @param bduid 百度云推返回的userID
 */
+ (void) userRegisterPushWithBdcid:(NSString *)bdcid bduid:(NSString *)bduid;

#pragma mark - 判断用户是否填写状态资料

/**
 *  直接返回用户当前状态值
 */
+ (int) userStatusValue;

/**
 *  用户状态信息 如果为nil说明未填写
 *
 *  @return 相关信息
 */
+ (NSDictionary *) userStatusInfo;

/**
 *  将用户状态信息存在本地
 */
+ (void) setUserStatusInfo:(NSDictionary *)userStatusInfo;

#pragma mark - 判断用户是否是第一次打开App

/**
 *  用户是否是第一次打开App
 */
+ (BOOL) ifUserFirstOpenApp;

/**
 *  用户已经打开App
 */
+ (void) userOpenedAppAlready;

/**
 *  获取用户位置信息
 */
+ (NSString *) userLocation;

/**
 *  设置用户位置信息
 */
+ (void) setUserLocation:(NSString *)city;


@end

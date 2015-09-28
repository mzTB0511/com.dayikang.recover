//
//  CommonUser.m
//  BabySante
//
//  Created by dd on 15/4/14.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "CommonUser.h"
#import "AppDelegate.h"
#import "MainViewController.h"
//#import "MoudleUserGuideViewController.h"
//#import "MoudleUserStatusChooseViewController.h"
#import "NetworkHandle.h"
#import "OpenUDID.h"
#import "BaseNavigationViewController.h"
//#import "MoudleUserLoginViewController.h"
#import "AMapFunction.h"
//#import "MoudleFourthViewController.h"


@implementation CommonUser

#pragma mark - 设置底部栏的badge

+(void)action_resetTabBarStatus {
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"other/servicemsg")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              NSArray *list = responseDictionary[@"list"];
                                              [CommonUser action_cacheTabBarBadgeInfo:list];
                                              for (NSDictionary *info in list) {
                                                  NSInteger tabIndex = [info[@"tabIndex"] integerValue];
                                                  NSInteger messageCount = [info[@"tabMsgNums"] integerValue];
                                                  NSString *message = mNSStringByInt((int)messageCount);
                                                  if (messageCount == 0) {
                                                      message = nil;
                                                  }
                                                  [CommonUser action_setTabBarBadge:message atIndex:tabIndex-1];
                                              }
                                              
//                                              //手动刷新第四模块的小红点
//                                              BaseNavigationViewController *nvc_fouth = [[CommonUser mainTabBarViewController].viewControllers lastObject];
//                                              MoudleFourthViewController *vc_fourth = [nvc_fouth.viewControllers firstObject];
//                                              [vc_fourth action_refreshPoint];
                                          }
                                          failure:nil
                                   networkFailure:nil];
}

+ (void) action_cacheTabBarBadgeInfo:(NSArray *)badgeInfo {
    [CommonIO setLocalValue:badgeInfo key:@"Cache_Badge_Info"];
}

+ (NSArray *) action_getCacheTabBarBadgeInfo {
    return [CommonIO getLocalValue:@"Cache_Badge_Info"];
}

+ (void) action_setTabBarBadge:(NSString *)badge atIndex:(NSInteger)index {
    UITabBar *bar = [self mainTabBarViewController].tabBar;
    if (index < bar.items.count) {
        UITabBarItem *item = bar.items[index];
        item.badgeValue = badge;
    }
}

#pragma mark - 把app启动后要执行的动作缓存在本地

+ (void) action_setCacheAction:(NSDictionary *)action {
    [CommonIO setLocalValue:action key:@"Cache_Launch_Action"];
}

+ (NSDictionary *) action_getCacheAction {
    return [CommonIO getLocalValue:@"Cache_Launch_Action"];
}

#pragma mark - 缓存餐别数据

/**
 *  缓存餐别数据
 */
+ (void) action_cacheMealType {
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"measuredata/getmealstype")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              [CommonIO setLocalValue:responseDictionary[@"list"] key:@"Cache_Meal_Type"];
                                          }
                                          failure:nil
                                   networkFailure:nil
                                      showLoading:NO];
}

/**
 *  从本地获取缓存数据
 */
+ (NSArray *) action_getMealType {
    return [CommonIO getLocalValue:@"Cache_Meal_Type"];
}

#pragma mark - 缓存最新数据到本地 / 读取本地数据

/**
 *  缓存首页数据到本地
 *
 *  @param homeData 首页数据
 */
+ (void) action_cacheHomeData:(NSArray *)homeData {
    [CommonIO setLocalValue:homeData key:[NSString stringWithFormat:@"Cache_Home_Data_%@",[CommonUser userID]]];
}

/**
 *  从本地获取缓存数据
 *
 *  @return 缓存数据  如果为nil则没有数据
 */
+ (NSArray *) action_getCacheData {
    return [CommonIO getLocalValue:[NSString stringWithFormat:@"Cache_Home_Data_%@",[CommonUser userID]]];
}


#pragma mark - 上传用户位置

/**
 *  上传用户经纬度
 */
+ (void) action_uploadUserLocation {
    [AMapFunction action_getUserLocationAndCityWithBlock:^(NSString *latitude, NSString *longitude, NSString *city) {
        [NetworkHandle loadDataFromServerWithParamDic:@{@"posLa":latitude,@"posLon":longitude}
                                              signDic:nil
                                        interfaceName:InterfaceAddressName(@"user/uploadposition")
                                              success:nil
                                              failure:nil
                                       networkFailure:nil
                                          showLoading:NO];
        //*记录城市位置
        [CommonUser setUserLocation:city];
        
    } failure:nil];
    

    
}

#pragma mark - 上传状态数据

/**
 *  上传用户状态数据
 *
 *  @param info             状态数据
 *  @param completionBlock  如果设置了block 则设置状态完成后会执行此block  如果不设置 则默认直接跳转到首页
 */
+ (void) uploadUserStatusInfo:(NSDictionary *)info completionBlock:(CommonBlock)completionBlock {
    
    [NetworkHandle loadDataFromServerWithParamDic:info
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"account/updatestatus")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              [CommonUser userLoginSuccess:responseDictionary block:completionBlock];
                                          }
                                          failure:nil
                                   networkFailure:nil];
}

/**
 *  上传用户的体征数据
 *
 *  @param data            体征数据
 *  @param completionBlock 上传完成后调用方法
 */
+ (void) uploadUserDataInfo:(NSDictionary *)data completionBlock:(CommonBlock)completionBlock {
    
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"measuredata/adddata") success:^(NSDictionary *responseDictionary, NSString *message) {
                                        NSDictionary *dic_returnData = responseDictionary[@"return_data"];
                                        NSDictionary *dic_userStatus = dic_returnData?dic_returnData[@"statusvalue"]:nil;
                                        if (dic_userStatus) {
                                            //保存用户状态信息
                                            [CommonUser setUserStatusInfo:dic_userStatus];
                                        }
                                        
                                        if (completionBlock) {
                                            completionBlock();
                                        }
                                    }
                                          failure:nil
                                   networkFailure:nil];
}

#pragma mark - 切换 Root VC

/**
 *  获取 main tab bar vc
 */
+ (UITabBarController *) mainTabBarViewController {
    
    id rootVc = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
    
    if ([rootVc isKindOfClass:[UITabBarController class]]) {
        return rootVc;
    }
    
    return nil;
}

/**
 *  切换到下一个视图
 */
+ (void) pushToNextViewController {
    
    if ([CommonUser userInfo]) {                    //判断是否已经登录
        if (![CommonUser ifUserSetStatus]) {
            //跳转到状态选择
            [CommonUser pushToUserStatusChooseViewController];
        } else {
            //跳转到首页
            [CommonUser pushToMainViewController];
        }
    } else if ([CommonUser userStatusInfo]) {       //是否已经填写用户状态
        //跳转到首页
        [CommonUser pushToMainViewController];
    } else {
        //跳转到状态选择页
        [CommonUser pushToUserStatusChooseViewController];
    }
}

/**
 *  切换到首页
 */
+ (void) pushToMainViewController {
    [CommonUser setRootViewController:mLoadViewController(sbStoryBoard_Main, NSStringFromClass([MainViewController class]))];
}

/**
 *  切换到选择用户状态
 */
+ (void) pushToUserStatusChooseViewController {
//    BaseNavigationViewController *nvc = mLoadViewController(sbStoryBoard_MoudleUserStatus, @"MoudleUserStatusChooseViewNavigationController");
//    MoudleUserStatusChooseViewController *vc = (MoudleUserStatusChooseViewController *)nvc.visibleViewController;
//    vc.completionBlock = ^ {
//        [CommonUser pushToMainViewController];
//    };
//    [CommonUser setRootViewController:nvc];
}

/**
 *  切换到用户引导页
 */
+ (void) pushToUserGuideViewController {
  //  [CommonUser setRootViewController:mLoadViewController(sbStoryBoard_MoudleUserGuide, NSStringFromClass([MoudleUserGuideViewController class]))];
}

/**
 *  切换到登录页
 */
+ (void) pushToUserLoginViewController {
//    BaseNavigationViewController *nvc = mLoadViewController(sbStoryBoard_MoudleUserLoginRegister, @"MoudleUserLoginRegisterNavigationController");
//    MoudleUserLoginViewController *login = (MoudleUserLoginViewController *)nvc.visibleViewController;
//    login.completionBlock = ^{
//        [CommonUser pushToNextViewController];
//    };
//    [CommonUser setRootViewController:nvc];
}

+ (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (void) setRootViewController:(UIViewController *)viewController {
    [CommonUser appDelegate].window.rootViewController = viewController;
}

#pragma mark - 用户数据

/**
 *  用户退出登录
 */
+ (void) userLogout {
    
    void(^logoutCompletion)(void) = ^{
        [CommonUser action_cacheHomeData:nil];
        [CommonUser setUserStatusInfo:nil];
        [CommonUser setUserInfo:nil];
        [CommonUser pushToUserLoginViewController];
    };
    
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/logout")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              logoutCompletion();
                                          }
                                          failure:logoutCompletion
                                   networkFailure:logoutCompletion];
}

/**
 *  登录成功后执行的方法
 *
 *  @param responseDictionary 成功后返回的数据
 *  @param block              其他执行的方法
 */
+ (void) userLoginSuccess:(NSDictionary *)responseDictionary block:(CommonBlock)block {
    
    //存储用户信息
    UserInfo *userInfo = [UserInfo objectWithData:responseDictionary[Return_data]];
    
    [CommonUser setUserInfo:userInfo];
    
    NSDictionary *bdDict = [CommonIO getLocalValue:@"BPushRequestResponseParamsKey"];
    
    if (bdDict) {
        
        [CommonUser userRegisterPushWithBdcid:[CommonIO ifNilValueReturnStr:[bdDict objectForKey:@"channel_id"]] bduid:[CommonIO ifNilValueReturnStr:[bdDict objectForKey:@"user_id"]]];
        
    }
    
    if (block) {
        block();
    }
}

/**
 *  获取user id
 */
+ (NSString *) userID {
    return [CommonUser userInfo].userID?:@"";
}

/**
 *  用户数据 isTempUser 为1说明是临时用户
 */
+ (UserInfo *) userInfo {
    return [CommonIO getLocalData:@"DataUserInfoKey"];
}

/**
 *  用户是否登录了
 */
+ (BOOL) ifUserHasLogin {
    return [[CommonUser userInfo].isTempUser isEqualToString:@"0"];
}


/**
 *  将用户信息存储在本地
 */
+ (void) setUserInfo:(UserInfo *)userInfo {
    [CommonIO setLocalData:userInfo key:@"DataUserInfoKey"];
}

/**
 *  取设备UDID
 */
+ (NSString *) udid {
    
    NSString *udid = [CommonIO getLocalValue:@"DeviceUDIDValue"];
    
    if (!udid) {
        
        udid = [OpenUDID value];
        
        [CommonIO setLocalValue:udid key:@"DeviceUDIDValue"];
    }

    return udid;
}

/**
 *  注册百度云推
 *
 *  @param bdcid 百度云推返回的channelID
 *  @param bduid 百度云推返回的userID
 */
+ (void) userRegisterPushWithBdcid:(NSString *)bdcid bduid:(NSString *)bduid {
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"bdcid":bdcid,@"bduid":bduid}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/registerbdpush")
                                          success:^(NSDictionary *responseDictionary , NSString *message){
                                              
                                              NSLog(@"responseDictionary is %@",responseDictionary);
                                              
                                          }
                                          failure:^{
                                              
                                          }
                                   networkFailure:nil
                                      showLoading:NO];
}

#pragma mark - 判断用户是否填写状态资料

/**
 *  直接返回用户当前状态值
 */
+ (int) userStatusValue {
    NSDictionary *userStatusInfo = [CommonUser userStatusInfo];
    NSString *userStatusString = userStatusInfo?userStatusInfo[@"status"]:@"";
    return [userStatusString intValue];
}

/**
 *  用户状态信息 如果为nil说明未填写
 *
 *  @return 相关信息
 */
+ (NSDictionary *) userStatusInfo {
    return [CommonIO getLocalData:@"DataUserStatusInfoKey"];
}

/**
 *  将用户状态信息存在本地
 */
+ (void) setUserStatusInfo:(NSDictionary *)userStatusInfo {
    [CommonIO setLocalData:userStatusInfo key:@"DataUserStatusInfoKey"];
}

#pragma mark - 判断用户是否是第一次打开App

/**
 *  用户是否是第一次打开App
 */
+ (BOOL) ifUserFirstOpenApp {
    return [CommonIO isFirstOpen:[NSString stringWithFormat:@"ConstUserOpenedAppFlag_%@",[CommonIO appVersion]]];
}

/**
 *  用户已经打开App
 */
+ (void) userOpenedAppAlready {
    [CommonIO isOpened:[NSString stringWithFormat:@"ConstUserOpenedAppFlag_%@",[CommonIO appVersion]]];
}


/**
 *  获取用户位置信息
 */
+ (NSString *) userLocation {
     return [CommonIO getLocalData:@"DataUserLocalPostion"];
}

/**
 *  设置用户位置信息
 */
+ (void) setUserLocation:(NSString *)city {
    [CommonIO setLocalData:city key:@"DataUserLocalPostion"];
}


@end

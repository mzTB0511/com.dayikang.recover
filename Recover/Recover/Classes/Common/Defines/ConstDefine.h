//
//  ConstDefine.h
//
//  Created by Yang Xudong .
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *定义一些项目中使用的常量
 */

//系统顶部颜色
#define Color_System_Tint_Color                 mRGBColor(247, 84, 98)

//系统主色调
#define Color_System_Main_Color                 mRGBColor(47, 154, 161)

//view背景色
#define Color_System_View_bgColor               mRGBColor(234, 234, 234)

//Mob短信验证
#define Mob_Key                                 @""
#define Mob_App_Secret                          @""

//微信开放平台ID/Secret
#define WX_App_ID                               @"wxa6428af98aa625a3"
#define WX_App_Secret                           @"cfb98f4d9ed78d863557cde7b77ee6bc"

//友盟统计App Key
#define UMeng_App_Key                           @"5440f28cfd98c51e6b002346"
//分发渠道
#define UMeng_Channel                           @""

//高德地图key
#define AMap_Key                                @"30e52afa7811e4af40b7990ec587ca66"

//百度云推送开放平台Appid
#define BD_PUSH_App_ID                          @"SMGx2wz6TbdRqr3d8CjpsYs9"


//故事板
#define sStoryBoard_Main                        @"Main"
#define sbStoryBoard_Main                       [UIStoryboard storyboardWithName:sStoryBoard_Main bundle:nil]

//四个主要模块
#define sbStoryBoard_HomePage                [UIStoryboard storyboardWithName:@"SBHomePage" bundle:nil]
#define sbStoryBoard_More                    [UIStoryboard storyboardWithName:@"SBMore" bundle:nil]
#define sbStoryBoard_MySelf                  [UIStoryboard storyboardWithName:@"SBMySelf" bundle:nil]
#define sbStoryBoard_Order                   [UIStoryboard storyboardWithName:@"SBOrder" bundle:nil]
#define sbStoryBoard_Reservation             [UIStoryboard storyboardWithName:@"SBReservation" bundle:nil]

//用户登陆注册
#define sbStoryBoard_MoudleUserLoginRegister    [UIStoryboard storyboardWithName:@"StoryboardMoudleUserLoginRegister" bundle:nil]

//用户引导
#define sbStoryBoard_MoudleUserGuide            [UIStoryboard storyboardWithName:@"StoryboardMoudleUserGuide" bundle:nil]


//【首页】
#define StoryBoard_HomePage    @"SBHomePage"
//【更多】模块
#define StoryBoard_More        @"SBMore"
//【我】模块
#define StoryBoard_MySelf      @"SBMySelf"
//【订单】模块
#define StoryBoard_Order       @"SBOrder"
//【预约】模块
#define StoryBoard_Reservation @"SBReservation"
//【康复师】模块
#define StoryBoard_Doctor      @"SBDoctor"



//**************************** 消息通知名称 键宏定义***********************************************/
//** 调用微信授权信息
#define COM_NOTIFATION_WECHATBLOCK    @"com_notifation_weichat_block"

//登录成功
#define Notification_User_Login_Success         @"Notification_User_Login_Success"



// APP 字体文件定义
#define FontViewTitle(fontSize) [UIFont fontWithName:@"FZLTCHJW--GB1-0" size:fontSize]
#define FontOthers_CH(fontSize) [UIFont fontWithName:@"FZLTHJW--GB1-0" size:fontSize]
#define FontOthers_Number(fontSize) [UIFont fontWithName:@"DINAlternate-Bold" size:fontSize]




/**
 *  获取食物返回默认图片
 */
#define getDefatult_FoodImage getImageWithRes(@"img_moudle_first_food_icon")




/**
 *  MJRefresh Tableview停止刷新
 */
#define stopTableViewRefreshAnimation(tableview)\
[tableview headerEndRefreshing];\
[tableview footerEndRefreshing];


//** 添加广告点击事件 UserDefault 值
#define DeafultKey_ModuleOtherGoAdDetail    @"DeafultKey_ModuleOtherGoAdDetail"





#define User_Status_Before_Pregnancy            1001
#define User_Status_During_Pregnancy            1002
#define User_Status_After_Pregnancy             1003
#define User_Status_Just_Look                   1004





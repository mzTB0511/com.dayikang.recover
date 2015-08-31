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
#define sbStoryBoard_MoudleFirst                [UIStoryboard storyboardWithName:@"StoryboardMoudleFirst" bundle:nil]
#define sbStoryBoard_MoudleSecond               [UIStoryboard storyboardWithName:@"StoryboardMoudleSecond" bundle:nil]
#define sbStoryBoard_MoudleThird                [UIStoryboard storyboardWithName:@"StoryboardMoudleThird" bundle:nil]
#define sbStoryBoard_MoudleThirdStore           [UIStoryboard storyboardWithName:@"StoryboardMoudleThirdStore" bundle:nil]
#define sbStoryBoard_MoudleFourth               [UIStoryboard storyboardWithName:@"StoryboardMoudleFourth" bundle:nil]
//用户登陆注册
#define sbStoryBoard_MoudleUserLoginRegister    [UIStoryboard storyboardWithName:@"StoryboardMoudleUserLoginRegister" bundle:nil]
//用户选择状态
#define sbStoryBoard_MoudleUserStatus           [UIStoryboard storyboardWithName:@"StoryboardMoudleUserStatus" bundle:nil]
//用户引导
#define sbStoryBoard_MoudleUserGuide            [UIStoryboard storyboardWithName:@"StoryboardMoudleUserGuide" bundle:nil]

//用户数据模块
#define sbStoryBoard_MoudleData                 [UIStoryboard storyboardWithName:@"StoryboardMoudleData" bundle:nil]

//营养模块
#define sbStoryBoard_Nutrition                  [UIStoryboard storyboardWithName:@"Nutrition" bundle:nil]

//新营养模块
#define StoryBoard_ModuleNutrition  @"StoryboardModuleNutrition"

//新营养模块
#define StoryBoard_MoudleData  @"StoryboardMoudleData"
//新营养模块
#define StoryBoard_MoudleFirst  @"StoryboardMoudleFirst"
//新营养模块
#define StoryBoard_FunctionMod @"FunctionalMod"
//新营养模块
#define StoryBoard_MoudleFourth @"StoryboardMoudleFourth"
//新营养套餐模块
#define Storyboard_Module_NutritionPkg @"StoryboardModuleNutritionPkg"



//** StoryBoard 文件定义
#define SB_Nutrition    @"Nutrition"






//**************************** 消息通知名称 键宏定义***********************************************/
//** 调用微信授权信息
#define COM_NOTIFATION_WECHATBLOCK    @"com_notifation_weichat_block"

//** 刷新套餐查看量
#define COM_NOTIFATION_PKGLOOKCOUNT    @"com_notifation_pkg_lookcount"

//** 更新选择的食物列表
#define COM_NOTIFATION_UPDATEFOODLIST    @"com_notifation_sel_foodlist"

//** 更新饮食记录列表
#define COM_NOTIFATION_UPDATEFOODRECORD    @"com_notifation_sel_foodrecord"



//首页接收到新消息推送 显示小红点
#define Notification_Recieve_New_Message        @"Notification_Recieve_New_Message"

//登录成功
#define Notification_User_Login_Success         @"Notification_User_Login_Success"

//糖妈妈记录饮食完成
#define Notification_Suger_Mom_Add_Food         @"Notification_Suger_Mom_Add_Food"

//强制刷新首页列表
#define Notification_Home_Page_Refresh          @"Notification_Home_Page_Refresh"

//进入医生问答页面
#define Notification_Push_DoctorQA              @"Notification_Push_DoctorQA"

//进入医生指导意见页面
#define Notification_Push_DoctorAdvice          @"Notification_Push_DoctorAdvice"

//进入医生回访通知
#define Notification_Push_DoctorVisit           @"Notification_PushDoctorVisit"

//下单成功以后 刷新购物车
#define Notification_Need_Refresh_Product_Cart  @"Notification_Need_Refresh_Product_Cart"

//添加餐桌食物到饮食记录
#define Notification_Need_Refresh_Food_Record  @"Notification_Need_Refresh_Food_Record"

//体征数据提交成功后刷新体征数据对应图表数据
#define Notification_Need_Refresh_Measure_Data_Chart  @"Notification_Need_Refresh_Measure_Data_Chart"


//进入系统消息页面刷新系统消息
#define Notification_Push_SystemInfo              @"Notification_Push_SystemInfo"

//进入活动消息页面刷新活动消息
#define Notification_Push_AcivityInfo              @"Notification_Push_AcivityInfo"




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


/**
 添加Umeng统计事件
 */
#define addUmentEvent(eventID)  [MobClick event:eventID]



//** 添加本地键值存储键声明
#define DeafultKey_ModuleFoodSearchHistory    @"DeafultKey_ModuleFoodSearchHistory"



//** 添加广告点击事件 UserDefault 值
#define DeafultKey_ModuleOtherGoAdDetail    @"DeafultKey_ModuleOtherGoAdDetail"





#define User_Status_Before_Pregnancy            1001
#define User_Status_During_Pregnancy            1002
#define User_Status_After_Pregnancy             1003
#define User_Status_Just_Look                   1004


typedef enum : NSUInteger {
    MoudleThirdSugerMomMealType_1 = 1,      //早餐前
    MoudleThirdSugerMomMealType_2 = 2,      //早餐后
    MoudleThirdSugerMomMealType_3 = 3,      //午餐前
    MoudleThirdSugerMomMealType_4 = 4,      //午餐后
    MoudleThirdSugerMomMealType_5 = 5,      //晚餐前
    MoudleThirdSugerMomMealType_6 = 6,      //晚餐后
    MoudleThirdSugerMomMealType_7 = 7       //凌晨
} MoudleThirdSugerMomMealType;


typedef enum : NSUInteger {
    Notification_Message_Type_BloodPressure = 1,        //血压
    Notification_Message_Type_Weight        = 2,        //体重
    Notification_Message_Type_Sport         = 3,        //运动量
    Notification_Message_Type_BloodSugar    = 5,        //血糖
    Notification_Message_Type_DoctorReply   = 100,      //医生回复
    Notification_Message_Type_DoctorAdvice  = 200,      //医生指导意见
    Notification_Message_Type_DoctorVisit   = 300,      //回访通知
    Notification_Message_Type_SystemMsg       = 400,      //系统消息
    Notification_Message_Type_Artivity       = 500,      //活动
    Notification_Message_Type_Article       = 600,      //健康咨询
    Notification_Message_Type_AD              = 700,      //广告
} Notification_Message_Type;


//** 硬件检测类型
typedef enum {
    MeasureType_BloodPress = 1,
    MeasureType_Weight = 2,
    MeasureType_Steps = 3,
    MeasureType_BloodGlcose = 5
}MeasureType;





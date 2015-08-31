//
//  FoodModule.h
//  Project_App
//
//  Created by 刘轩 on 15/1/27.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FoodModule_rowID      @"rowid"
#define FoodModule_productID      @"nfid"
#define FoodModule_name    @"name"
#define FoodModule_img     @"imgurl"
#define FoodModule_value   @"value"
#define FoodModule_unit    @"unit"
#define FoodModule_type    @"type"
#define FoodModule_gitype   @"gitype"
#define FoodModule_givalue    @"givalue"
#define FoodModule_giremind    @"giremind"



//** 食物包含的能量(能量，碳水化合物，蛋白质，脂肪)
@interface FoodElementTotal  : NSObject
// 含量ID
@property(nonatomic,strong) NSString* neid ;
// 名称
@property(nonatomic,strong) NSString* name ;
// 单位
@property(nonatomic,strong) NSString* unit ;
// 图片
@property(nonatomic,strong) NSString* imgurl ;
// 数量
@property(nonatomic,strong) NSString* value ;

@end


//** 食物包含的微量元素列表
@interface FoodTraceElements  : NSObject
// 含量ID
@property(nonatomic,strong) NSString* neid ;
// 名称
@property(nonatomic,strong) NSString* name ;
// 单位
@property(nonatomic,strong) NSString* value ;
// 含量
@property(nonatomic,strong) NSString* unit ;
// 元素缩略图
@property(nonatomic,strong) NSString* imgurl;


@end



//** 食物分类信息定义
@interface FoodTypeModule  : NSObject
// 分类ID
@property(nonatomic,strong) NSString* ncid ;
// 分类名称
@property(nonatomic,strong) NSString* name ;
// 分类缩略图
@property(nonatomic,strong) NSString* imgurl ;

@end




@interface FoodModule : NSObject

// 记录唯一标示ID
@property(nonatomic,strong) NSString *rowid;

// 物品ID
@property(nonatomic,strong) NSString *nfid;

// 物品名字
@property(nonatomic,strong) NSString *name;

// 物品别名
@property(nonatomic,strong) NSString *othername;

// 物品图片
@property(nonatomic,strong) NSString *imgurl;

// 含量
@property(nonatomic,strong) NSString *value;

// 标签（1健康；2亚健康；3非健康）
@property(nonatomic,strong) NSString *type;

// 单位
@property(nonatomic,strong) NSString *unit;

// GI标签（1-谨慎吃；2-食量吃；3-少量吃；4-正常吃）
@property(nonatomic,strong) NSString *gitype;

// GI值
@property(nonatomic,strong) NSString *givalue;

// GI提醒内容
@property(nonatomic,strong) NSString *giremind;

// 状态值
@property(nonatomic,strong) NSString *status;

// 90千卡对应卡路里
@property(nonatomic,strong) NSString *kcal_gram;

// 食材卡路里数量
@property(nonatomic,strong) NSString *foodkcal;

// 估算重量ID
@property(nonatomic,strong) NSString *estimate_id;

// 估算重量图示
@property(nonatomic,strong) NSString *estimate_img;

// 估算重量说明提示
@property(nonatomic,strong) NSString *estimate_message;



// 四大含量值
@property (nonatomic,strong) NSArray * FoodElementTotalList;

// 食物中微量元素列表
@property (nonatomic,strong) NSArray * FoodTraceElementsList;


@end


/**
 *  推荐套餐时间段模型定义
 */
@interface TimeSectionModule : NSObject

// 时间段ID
@property(nonatomic,strong) NSString *timeid;

// 时间段名称
@property(nonatomic,strong) NSString *name;

// 总的卡路里数量
@property(nonatomic,strong) NSString *mealkcal;


// 时间段 时间区间
@property(nonatomic,strong) NSString *timeRegion;
;
// 食物列表
@property(nonatomic,strong) NSMutableArray *foodList;


@end


/**
 *  推荐套餐数据模型定义
 */
@interface FoodRecommendPackageModule : NSObject
// 套餐ID
@property(nonatomic,strong) NSString *pkgid;

// 套餐名字
@property(nonatomic,strong) NSString *name;

// 套餐简介
@property(nonatomic,strong) NSString *desc;

// 套餐缩略图片
@property(nonatomic,strong) NSString *imgurl;

// 收藏数量
@property(nonatomic,strong) NSString *favouritecount;

// 查看量
@property(nonatomic,strong) NSString *lookcount;

// 时间段
@property(nonatomic,strong) NSArray *timeSection;

// 类型套餐 / 单菜
@property(nonatomic,strong) NSString *type;

// 营养标签 add 1.8.5
@property(nonatomic,strong) NSArray *marks;
//医生名字add 1.8.5
@property(nonatomic,strong)NSString *doctor_name;
//医生抬头add 1.8.5
@property(nonatomic,strong)NSString *doctor_title;
//医生照片add 1.8.5
@property(nonatomic,strong)NSString *doctor_imgurl;
//标签add 1.8.5
@property(nonatomic,strong)NSArray *symptomlist;
//医生id
@property(nonatomic,strong)NSString *docyorID;
@end
//推荐套餐数x详细情况模型定义

@interface FoodRecommendPackageDetailModule : NSObject


@property(nonatomic,strong) NSString *doctor_id;


@property(nonatomic,strong) NSString *doctor_name;


@property(nonatomic,strong) NSString *doctor_title;


@property(nonatomic,strong) NSString *doctor_imgurl;


@property(nonatomic,strong) NSString *doctor_txt;


@property(nonatomic,strong) NSString *mama_txt;


@property(nonatomic,strong) NSArray *list;


@property(nonatomic,strong)NSArray *symptomlist;

@property(nonatomic,strong)NSArray *mama_bbs;



@end
//推荐套餐数评论情况模型定义

@interface FoodRecommendPackageCommentModule : NSObject


@property(nonatomic,strong) NSString *comment_id;


@property(nonatomic,strong) NSString *publish_id;


@property(nonatomic,strong) NSString *content;


@property(nonatomic,strong) NSString *create_time;


@property(nonatomic,strong) NSString *like_count;


@property(nonatomic,strong) NSString *user_ico;


@property(nonatomic,strong) NSString *user_name;


@property(nonatomic,strong) NSString *user_status;


@property(nonatomic,strong) NSString *user_city;


@property(nonatomic,strong) NSString *is_like;

@end


/**
 *  营养评估数据
 */
@interface RecommendReportModule : NSObject

// ID
@property(nonatomic,strong) NSString *neid;

// 营养成分名字
@property(nonatomic,strong) NSString *name;

// 营养成分缩略图片
@property(nonatomic,strong) NSString *imgurl;

// 理想摄入值
@property(nonatomic,strong) NSString *standvalue;

// 实际摄入值
@property(nonatomic,strong) NSString *curvalue;

// 单位
@property(nonatomic,strong) NSString *unit;

// 标记
@property(nonatomic,strong) NSString *flag;

@end




/**
 *   单菜数据模型
 */

@interface DishModule : NSObject


// 记录唯一标示ID
@property(nonatomic,strong) NSString *rowid;

// ID
@property(nonatomic,strong) NSString *nfid;

// 营养成分名字
@property(nonatomic,strong) NSString *name;

// 营养成分缩略图片
@property(nonatomic,strong) NSString *imgurl;

// 理想摄入值
@property(nonatomic,strong) NSMutableArray *foodList;


@end









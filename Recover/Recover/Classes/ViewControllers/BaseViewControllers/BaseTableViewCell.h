//
//  BaseTableViewCell.h
//  BabySante
//
//  Created by dd on 15/4/9.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MoudleFirstCellType_Meal_Combo                  = 100,  //套餐
    MoudleFirstCellType_Meal                        = 101,  //单菜
    MoudleFirstCellType_Food                        = 102,  //食材
    MoudleFirstCellType_Music                       = 200,  //音乐
    MoudleFirstCellType_HealthyWarning              = 201,  //健康提醒
    MoudleFirstCellType_Pregnancy_Guide              = 202,  //孕期提醒
    MoudleFirstCellType_AD                          = 301,  //广告
    
    MoudleFirstCellType_HealthyData_WeightMom       = 1,    //体重
    MoudleFirstCellType_HealthyData_WeightBaby      = 2,    //宝宝体重
    MoudleFirstCellType_HealthyData_Temp            = 3,    //体温
    MoudleFirstCellType_HealthyData_Pregnancy       = 4,    //好孕率
    MoudleFirstCellType_HealthyData_BloodSuger      = 5,    //血糖
    MoudleFirstCellType_HealthyData_BabyAction      = 6,    //胎动
    MoudleFirstCellType_HealthyData_BabyHeight      = 7,    //宝宝身高
    MoudleFirstCellType_HealthyData_BabyHeadLength  = 8     //宝宝头围
    
} MoudleFirstCellType;

@interface BaseTableViewCell : UITableViewCell

/**
 *  Cell 类型
 */
@property (nonatomic, assign) MoudleFirstCellType cellType;

/**
 *  数据
 */
@property (nonatomic, strong) NSDictionary *data;

/**
 *  统一赋值入口
 */
- (void) action_setData:(NSDictionary *)data;

@end

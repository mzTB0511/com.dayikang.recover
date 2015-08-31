//
//  FormatData.h
//  TXFishing
//  将从服务器上面请求下来的数据转化成应用内部的数据对象
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FormatData : NSObject

+ (id)shareInstance;

/*请求下来的数据封装成营养项目的数据*/
- (NSMutableArray *)formatDictToNaturitionItemData:(NSArray *)dictArray;

/*请求下来的数据封装成食物数据*/
- (NSMutableArray *)formatDictToFoodItemData:(NSArray *)dictArray;


/*请求下来的数据封装成食物营养含量模块数据*/
- (NSMutableArray *)formatDictToFoodNutritionTotalData:(NSArray *)dictArray;

/*请求下来的数据封装成食物营养元素模块数据*/
- (NSMutableArray *)formatDictToFoodTraceElementsData:(NSArray *)dictArray;

/*请求下来的数据封装成食物分类数据*/
- (NSMutableArray *)formatDictToFoodTypeData:(NSArray *)dictArray;

/*请求下来的数据封装成营养套餐数据*/
- (NSMutableArray *)formatDictToRecommendPackageData:(NSArray *)dictArray;
//营养套餐评论数据封装
-(NSMutableArray *)formatDictToRecommendPackageCommentData:(NSArray *)dictArray;



@end

//
//  FormatData.m
//  请求下来的数据转化成数据对象
//
//  AppDelegate.h
//  ShouGouAPP
//
//  Created by yczx on 13-3-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//
#import "CommonFunc.h"
#import "FormatData.h"
#import "NaturtionItemModule.h"
#import "FoodModule.h"


static FormatData *fdata;

@implementation FormatData

+ (id)shareInstance
{
    
//    static FormatData *instance = nil;
    static dispatch_once_t pred;
	if(fdata == nil)
	{
     dispatch_once(&pred, ^{  //单例
		fdata = [[self alloc] init];
//        instance = [[self alloc] initFormmatData];
	  });
    }
	return fdata;
}

//+ (id)shareInstance
//{
//    static dispatch_once_t pred;
//    static FormatData *instance = nil;
//    dispatch_once(&pred, ^{
//        instance = [[self alloc] initFormmatData];
//    });
//    return instance;
//}

- (id)initFormmatData{
    self  = [super init];
    if (self == [super init]){
        
    }
    return self;
}

/*请求下来的数据封装成营养项目的数据*/
- (NSMutableArray *)formatDictToNaturitionItemData:(NSArray *)dictArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < [dictArray count]; i ++) {
        NaturtionItemModule *data = [[NaturtionItemModule alloc]init];
        
        NSDictionary *dict = [dictArray objectAtIndex:i];        
      
        data.neid= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:NaturtionItem_id]];
        data.name= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:NaturtionItem_name]];
        data.imgurl= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:NaturtionItem_img]];
        data.value= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:NaturtionItem_value]];
        data.unit= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:NaturtionItem_unit]];
        
        [tempArray addObject:data];
   
    }
    
     return tempArray;
}


/*请求下来的数据封装成食物数据*/
- (NSMutableArray *)formatDictToFoodItemData:(NSArray *)dictArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < [dictArray count]; i ++) {
        FoodModule *data = [[FoodModule alloc]init];
        
        NSDictionary *dict = [dictArray objectAtIndex:i];
        
        data.nfid= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:FoodModule_productID]];
        data.name= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:FoodModule_name]];
        data.imgurl= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:FoodModule_img]];
        data.value= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:FoodModule_value]];
        data.unit= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:FoodModule_unit]];
        
        data.type= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:FoodModule_type]];
        
        data.gitype= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:FoodModule_gitype]];
        data.givalue= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:FoodModule_givalue]];
        
        data.giremind= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:FoodModule_giremind]];
        
        data.status= @"0";
 
        [tempArray addObject:data];
        
    }
    
    return tempArray;
}


/*请求下来的数据封装成食物营养含量模块数据*/
- (NSMutableArray *)formatDictToFoodNutritionTotalData:(NSArray *)dictArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < [dictArray count]; i ++) {
        FoodElementTotal *data = [[FoodElementTotal alloc]init];
        
        NSDictionary *dict = [dictArray objectAtIndex:i];
        
        data.neid= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"neid"]];
        data.name= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"name"]];
        data.unit= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"unit"]];
        data.imgurl= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"imgurl"]];
        data.value= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"value"]];
    
        [tempArray addObject:data];
        
    }
    
    return tempArray;
}


/*请求下来的数据封装成食物营养元素模块数据*/
- (NSMutableArray *)formatDictToFoodTraceElementsData:(NSArray *)dictArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < [dictArray count]; i ++) {
        FoodTraceElements *data = [[FoodTraceElements alloc]init];
        
        NSDictionary *dict = [dictArray objectAtIndex:i];
        
        data.neid= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"neids"]];
        data.name= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"name"]];
        data.value= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"value"]];
        data.unit= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"unit"]];
        data.imgurl= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"imgurl"]];
        
        [tempArray addObject:data];
        
    }
    
    return tempArray;
}

/*请求下来的数据封装成食物营养元素模块数据*/
- (NSMutableArray *)formatDictToFoodTypeData:(NSArray *)dictArray
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < [dictArray count]; i ++) {
        FoodTypeModule *data = [[FoodTypeModule alloc]init];
        
        NSDictionary *dict = [dictArray objectAtIndex:i];
        
        data.ncid= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"ncid"]];
        data.name= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"name"]];
        data.imgurl= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"imgurl"]];
        
        [tempArray addObject:data];
        
    }
    
    return tempArray;
}


- (NSMutableArray *)formatDictToRecommendPackageData:(NSArray *)dictArray{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < [dictArray count]; i ++) {
        FoodRecommendPackageModule *data = [[FoodRecommendPackageModule alloc]init];
        
        NSDictionary *dict = [dictArray objectAtIndex:i];
        
        data.doctor_imgurl=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"doctor_imgurl"]];
        data.doctor_name=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"doctor_name"]];
        data.doctor_title=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"doctor_title"]];
        data.symptomlist=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"symptomlist"]];
        
        data.pkgid= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"pkgid"]];
        data.name= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"name"]];
        data.imgurl= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"imgurl"]];
        data.desc= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"desc"]];
        data.lookcount= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"count"]];
        data.type= [[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"type"]];
        data.marks = [dict objectForKey:@"tag"];
        [tempArray addObject:data];
        
    }
    
    return tempArray;

    
}
//营养套餐评论数据封装
-(NSMutableArray *)formatDictToRecommendPackageCommentData:(NSArray *)dictArray{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < [dictArray count]; i ++) {
        FoodRecommendPackageCommentModule *data = [[FoodRecommendPackageCommentModule alloc]init];
        
        NSDictionary *dict = [dictArray objectAtIndex:i];
        data.comment_id=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"comment_id"]];
        data.publish_id=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"publish_id"]];
        data.content=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"content"]];
        data.create_time=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"create_time"]];
        data.user_ico=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"user_ico"]];
        data.user_name=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"user_name"]];
        data.user_status=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"user_status"]];
        data.user_city=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"user_city"]];
        data.is_like=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"is_like"]];
        data.like_count=[[CommonFunc shareInstance] checkNullString:[dict objectForKey:@"like_count"]];
        [tempArray addObject:data];
        
    }
    
    return tempArray;
    
}



@end

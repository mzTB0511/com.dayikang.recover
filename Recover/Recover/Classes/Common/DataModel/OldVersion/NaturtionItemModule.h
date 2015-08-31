//
//  NaturtionItemModule.h
//  Project_App
//
//  Created by 刘轩 on 15/1/27.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NaturtionItem_id      @"neid"
#define NaturtionItem_name    @"name"
#define NaturtionItem_img     @"imgurl"
#define NaturtionItem_value   @"value"
#define NaturtionItem_unit    @"unit"


@interface NaturtionItemModule : NSObject

// 项目ID
@property(nonatomic,strong) NSString *neid;

// 项目名称
@property(nonatomic,strong) NSString *name;

// 缩略图
@property(nonatomic,strong) NSString *imgurl;

// 营养含量
@property(nonatomic,strong) NSString *value;

// 营养单位
@property(nonatomic,strong) NSString *unit;



@end

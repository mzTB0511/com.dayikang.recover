//
//  SegmentItem.h
//  BabysanteSegment
//
//  Created by 刘轩 on 15/9/9.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SegmentItem : NSObject


/**
 *  菜单唯一标示
 */
@property(nonatomic,copy) NSString *menuID;
/**
 *  菜单名称
 */
@property(nonatomic,copy) NSString *name;

/**
 *  是否有二级子项目
 */
@property(nonatomic,assign) BOOL hasSubItem;
/**
 *  二级子项目列表
 */
@property(nonatomic,copy) NSArray *arrSubMenuList;



@end

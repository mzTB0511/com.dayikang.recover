//
//  YXDFirstRemindView.h
//
//  Created by YangXudong .
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXDFirstRemindView : UIView

/**
 *  根据指定的key和图片数组 判断进入某个页面的时候是否需要展示引导介绍页面
 *
 *  @param imageNames 图片名称数组
 *  @param key        key
 */
+ (void) showRemindViewWithImageNames:(NSArray *)imageNames key:(NSString *)key;

@end

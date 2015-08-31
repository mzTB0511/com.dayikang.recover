//
//  BaseViewController.h
//
//  Created by dd .
//  Copyright (c) 2014年 YangXudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"

@interface BaseViewController : UIViewController

/**
 *  设置没有记录时现实默认图片
 */
-(void)setEmptyRemindImageWithRes:(NSString *)res;

/**
 *  清楚默认图片默认图片
 */
-(void)removeEmptyRemindImage;



@end

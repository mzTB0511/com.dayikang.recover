//
//  CommonHUD.h
//  BabySante
//
//  Created by dd on 15/3/26.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <Foundation/Foundation.h>

static float CommonHudShowDuration = 1.0;

@interface CommonHUD : NSObject

/**
 *  显示hud
 */
+ (void) showHud;

/**
 *  隐藏hud
 */
+ (void) hideHud;

/**
 *  展示hud
 *
 *  @param message    展示消息
 *  @param delay      展示时间
 *  @param completion 消失后执行代码
 */
+ (void) showHudWithMessage:(NSString *)message delay:(float)delay completion:(void (^)())completion;

@end

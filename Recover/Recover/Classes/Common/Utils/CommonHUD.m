//
//  CommonHUD.m
//  BabySante
//
//  Created by dd on 15/3/26.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "CommonHUD.h"
#import <MBProgressHUD.h>

#define Common_HUD_Instance_Hud             [CommonHUD sharedInstance].hud

@interface CommonHUD ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation CommonHUD

/**
 *  显示hud
 */
+ (void) showHud {
    [self showHudWithCompletion:nil];
}

/**
 *  隐藏hud
 */
+ (void) hideHud {
    [Common_HUD_Instance_Hud hide:NO];
}

/**
 *  展示hud
 *
 *  @param message    展示消息
 *  @param delay      展示时间
 *  @param completion 消失后执行代码
 */
+ (void) showHudWithMessage:(NSString *)message delay:(float)delay completion:(void (^)())completion {
    [self showHudWithCompletion:completion];
    Common_HUD_Instance_Hud.labelText = message;
    [Common_HUD_Instance_Hud hide:YES afterDelay:delay];
}


+ (void) showHudWithCompletion:(void (^)())completion
{
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:Common_HUD_Instance_Hud];
    Common_HUD_Instance_Hud.completionBlock = completion;
    Common_HUD_Instance_Hud.labelText = nil;
    [Common_HUD_Instance_Hud layoutSubviews];
    [Common_HUD_Instance_Hud show:YES];
}

#pragma mark - 

+ (instancetype) sharedInstance {
    
    static CommonHUD *commonHud = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commonHud = [[CommonHUD new] hudInit];
    });
    
    return commonHud;
}

- (instancetype) hudInit
{
    self.hud = [[MBProgressHUD alloc] initWithWindow:[[[UIApplication sharedApplication] windows] firstObject]];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.removeFromSuperViewOnHide = YES;
    return self;
}

@end

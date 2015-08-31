//
//  YXDFirstRemindView.m
//
//  Created by YangXudong .
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "YXDFirstRemindView.h"

@interface YXDFirstRemindView ()

@property (nonatomic, assign) int currentIndex;

@property (nonatomic, strong) NSArray *arr_imageNames;

@property (nonatomic, strong) UIImageView *imv_remindView;

@end

@implementation YXDFirstRemindView

+(void)showRemindViewWithImageNames:(NSArray *)imageNames key:(NSString *)key {
    
    if (!imageNames.count) {
        return;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults boolForKey:key]) {
        return;
    } else {
        [userDefaults setBool:YES forKey:key];
        [userDefaults synchronize];
    }
    
    YXDFirstRemindView *bgView = [[YXDFirstRemindView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.currentIndex = 0;
    bgView.arr_imageNames = imageNames;
    
    bgView.imv_remindView = [[UIImageView alloc] initWithFrame:bgView.bounds];
    bgView.imv_remindView.userInteractionEnabled = YES;
    bgView.imv_remindView.image = [UIImage imageNamed:imageNames[0]];
    [bgView addSubview:bgView.imv_remindView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:bgView action:@selector(action_tap)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [bgView.imv_remindView addGestureRecognizer:tap];
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    [window addSubview:bgView];
}

- (void) action_tap {
    if (++self.currentIndex >= self.arr_imageNames.count) {
        [self removeFromSuperview];
    } else {
        self.imv_remindView.image = [UIImage imageNamed:self.arr_imageNames[self.currentIndex]];
    }
}

@end

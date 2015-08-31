//
//  UINavigationBar+BackgroundColor.h
//
//  Created by YangXudong on 15/5/19.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackgroundColor)

- (void) action_setBackgroundColor:(UIColor *)backgroundColor;

- (void) action_setSystemBarBackgroundAlpha:(CGFloat)alpha;

- (void) action_reset;

@end

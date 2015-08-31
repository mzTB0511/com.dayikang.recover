//
//  UIViewController+NavigationBarColor.m
//  NavigationBarBgColorTest
//
//  Created by YangXudong on 15/5/26.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "UIViewController+NavigationBarColor.h"
#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (nonatomic, weak) UINavigationBar *navBar;

@property (nonatomic, weak) UIPanGestureRecognizer *pan;

@end


static const void *NavigationBarKey = &NavigationBarKey;

static const void *NavigationControllerPanKey = &NavigationControllerPanKey;

@implementation UIViewController (NavigationBarColor)

-(void)action_addNavigationPanTarget {
    self.pan = (UIPanGestureRecognizer *)self.navigationController.interactivePopGestureRecognizer;
    [self.pan addTarget:self action:@selector(action_pan:)];
    self.navBar = self.navigationController.navigationBar;
}

-(void)action_removeNavigationPanTarget {
    [self.pan removeTarget:self action:@selector(action_pan:)];
    self.pan = nil;
}

- (void) action_pan:(UIPanGestureRecognizer *)pan {
    
    CGFloat pointX = [pan translationInView:self.view].x;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat alpha = pointX/screenWidth;
    
    [self.navBar action_setSystemBarBackgroundAlpha:alpha];
}

#pragma mark - 

-(void)setNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, NavigationBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UINavigationBar *)navBar {
    return objc_getAssociatedObject(self, NavigationBarKey);
}

-(void)setPan:(UIPanGestureRecognizer *)pan {
    objc_setAssociatedObject(self, NavigationControllerPanKey, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIPanGestureRecognizer *)pan {
    return objc_getAssociatedObject(self, NavigationControllerPanKey);
}

@end

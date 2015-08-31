//
//  RootViewController.h
//  
//
//  Created by on 14-6-18.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "ViewController.h"

@interface RootViewController : ViewController


/* 自定义 视图背景图*/
- (void)customerViewControllBgWithImage:(NSString *)imageRes;

/* 自定义UINavigationBar 左键*/
-(void)customerLeftNavigationBarItemWithTitle:(NSString *)title andImageRes:(NSString *)resName;

/* 自定义UINavigationBar 右键*/
-(void)customerRightNavigationBarItemWithTitle:(NSString *)title andImageRes:(NSString *)resName;

/* UINavigationRightBar event*/
-(void)navigationRightItemEvent;

-(void)backToView;

@end

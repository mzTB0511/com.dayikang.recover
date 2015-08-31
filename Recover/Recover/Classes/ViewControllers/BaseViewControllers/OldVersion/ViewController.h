//
//  ViewController.h
//  
//
//  Created by  on 14-6-26.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAlertView+Blocks.h"
#import <AFNetworking.h>
#import "CommonFunc.h"
#import "FormatData.h"
#import "UserInfo.h"
#import "BaseViewController.h"

@interface ViewController : BaseViewController


// 设置Navigation bar title
-(void) setViewTitle:(NSString *)title;

//** 搜索默认显示结果
-(void)setEmptyHintMessage:(NSString *)message;

-(void)removeEmptyHint;





@end

//
//  MoudleUserLoginViewController.h
//  BabySante
//
//  Created by dd on 15/4/14.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "BaseViewController.h"

@interface MoudleUserLoginViewController : BaseViewController

/**
 *  登录完成后会执行此block
 */
@property (nonatomic, copy) CommonBlock completionBlock;

/**
 *  展示取消按钮
 */
- (void) action_showDismissButton;

@end

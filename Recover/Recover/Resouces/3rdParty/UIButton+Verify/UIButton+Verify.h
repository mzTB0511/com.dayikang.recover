//
//  UIButton+Verify.h
//
//  Created by dd.
//  Copyright (c) 2014年. All rights reserved.
//

#import <UIKit/UIKit.h>

//默认倒计时时间
#define Verify_Button_Time                  60

//可用时的标题
#define Verify_Button_Title_Available       @"获取验证码"

//倒计时的标题
#define Verify_Button_Title_Unavailable     @"秒后重新获取"

@interface UIButton (Verify)

/**
 *  接收到按钮事件后 调用此方法
 */
- (void) unavailable;

@end

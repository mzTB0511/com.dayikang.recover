//
//  UIButton+Verify.m
//
//  Created by dd.
//  Copyright (c) 2014年. All rights reserved.
//

#import "UIButton+Verify.h"

@implementation UIButton (Verify)

/**
 *  接收到按钮事件后 调用此方法
 */
- (void) unavailable
{
    if (!self.userInteractionEnabled)return;
    
    __block int timeout = Verify_Button_Time;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^
    {
        if(timeout<=0)
        {
            //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               [self setTitle:Verify_Button_Title_Available
                                     forState:UIControlStateNormal];
                               self.userInteractionEnabled = YES;
                           });
        }
        else
        {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds==0?60:seconds];
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,Verify_Button_Title_Unavailable]
                                     forState:UIControlStateNormal];
                               self.userInteractionEnabled = NO;
                           });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}

@end

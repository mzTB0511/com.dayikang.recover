//
//  BabysanteAlertView.m
//  BabySante
//
//  Created by 刘轩 on 15/8/14.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "BabysanteAlertView.h"

#define BabysanteAlertView_Weight  300
//#define BabysanteAlertViewBtn_Weight  300
#define BabysanteAlertViewBtn_Height  44
#define BabysanteAlertViewItem_Space  20
#define BabySanteDatePickerAnimationDuration        0.25

@interface BabysanteAlertView()

@property (nonatomic, strong) UIControl *backgroundView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *containerView;

@property(nonatomic,copy) BabysanteAlertViewBlock AlertViewBlock;

@end


@implementation BabysanteAlertView

+ (void)BabysanteAlertViewShow:(UIView *)contentView Block:(BabysanteAlertViewBlock)block{
    
    BabysanteAlertView *alertView = [[BabysanteAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.backgroundColor = [UIColor clearColor];
    
    //创建背景view
    alertView.backgroundView = [[UIControl alloc] initWithFrame:alertView.bounds];
    alertView.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [alertView addSubview:alertView.backgroundView];
    
    alertView.alertView = [alertView alertViewWith:contentView Block:block];
    alertView.alertView.center  = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    [alertView addSubview:alertView.alertView];
    
    alertView.AlertViewBlock = block;
    
    [mWindow addSubview:alertView];
    
    [alertView showBackgroundView];
    
}



-(UIView *)alertViewWith:(UIView *)containerView Block:(BabysanteAlertViewBlock)block{
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BabysanteAlertView_Weight, containerView.frame.size.height + BabysanteAlertViewBtn_Height + BabysanteAlertViewItem_Space *2)];
    alertView.layer.cornerRadius = 8.0f;
    alertView.layer.masksToBounds = YES;
    alertView.backgroundColor = [UIColor whiteColor];
    
    [alertView addSubview:containerView];
    containerView.center = CGPointMake(alertView.frame.size.width / 2, (alertView.frame.size.height - BabysanteAlertViewBtn_Height - BabysanteAlertViewItem_Space *2) / 2);
    
    
    //**Buttom 按钮
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(0, 0, BabysanteAlertView_Weight - BabysanteAlertViewItem_Space*2, BabysanteAlertViewBtn_Height)];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setBackgroundColor:Color_System_Tint_Color];
    btn.layer.cornerRadius = 2.0f;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"我知道了" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action_ClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [alertView addSubview:btn];
    
    btn.center = CGPointMake(alertView.frame.size.width / 2, (alertView.frame.size.height - BabysanteAlertViewBtn_Height / 2 - BabysanteAlertViewItem_Space));
    
    
    return alertView;
}


-(void)action_ClickEvent:(UIButton *)btn{

    WEAKSELF
    [weakSelf hideBackgroundView];
    
    if (weakSelf.AlertViewBlock) {
        weakSelf.AlertViewBlock();
    }
    
}



- (void) showBackgroundView {
    WEAKSELF
    [UIView animateWithDuration:BabySanteDatePickerAnimationDuration
                     animations:^{
                         weakSelf.backgroundView.alpha = 1;
                     }
                     completion:nil];
}

- (void) hideBackgroundView {
    WEAKSELF
    [UIView animateWithDuration:BabySanteDatePickerAnimationDuration
                     animations:^{
                         weakSelf.backgroundView.alpha = 0;
                         weakSelf.alertView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [weakSelf removeFromSuperview];
                     }];
}



@end

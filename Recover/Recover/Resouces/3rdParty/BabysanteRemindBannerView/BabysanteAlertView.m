//
//  BabysanteAlertView.m
//  BabySante
//
//  Created by 刘轩 on 15/8/14.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "BabysanteAlertView.h"

#define BabysanteAlertView_Weight  getScreenWidth-20
//#define BabysanteAlertViewBtn_Weight  300
#define BabysanteAlertViewBtn_Height  44
#define BabysanteAlertViewItem_Space  20
#define BabySanteDatePickerAnimationDuration        0.25

@interface BabysanteAlertView()

@property (nonatomic, strong) UIControl *backgroundView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *containerView;

@property(nonatomic,copy) BabysanteAlertViewBlock AlertViewBlock;
@property(nonatomic,copy) BabysanteAlertViewCancelBlock cancelBlock;
@property(nonatomic,copy) BabysanteAlertViewOthersBlock othersBlock;



@end


@implementation BabysanteAlertView

+ (void)BabysanteAlertViewShow:(UIView *)contentView Block:(BabysanteAlertViewBlock)block{
    
    BabysanteAlertView *alertView = [[BabysanteAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.backgroundColor = [UIColor clearColor];
    
    //创建背景view
    alertView.backgroundView = [[UIControl alloc] initWithFrame:alertView.bounds];
    alertView.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [alertView addSubview:alertView.backgroundView];
    
    alertView.alertView = [alertView alertViewWithCustomView:contentView];
    [alertView CustomAlterViewBtnObj:alertView.alertView];
    alertView.alertView.center  = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    [alertView addSubview:alertView.alertView];
    
    alertView.AlertViewBlock = block;
    [alertView setTag:AlertViewTag];
    [mWindow addSubview:alertView];
    
    [alertView showBackgroundView];
    
}




+ (void)BabysanteAlertViewShow:(UIView *)contentView CancelBtn:(NSString *)cancel OtherBtns:(NSArray *)others CalelBlock:(BabysanteAlertViewCancelBlock)cancelBlock OthersBlock:(BabysanteAlertViewOthersBlock)othersBlock{
    
    BabysanteAlertView *alertView = [[BabysanteAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertView.backgroundColor = [UIColor clearColor];
    
    //创建背景view
    alertView.backgroundView = [[UIControl alloc] initWithFrame:alertView.bounds];
    alertView.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [alertView addSubview:alertView.backgroundView];
    
    alertView.alertView = [alertView alertViewWithCustomView:contentView];
    
    [alertView CustomAlterViewBtnObj:alertView.alertView WithCancel:cancel Others:others];
    alertView.alertView.center  = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    [alertView addSubview:alertView.alertView];
    
    alertView.cancelBlock = cancelBlock;
    alertView.othersBlock = othersBlock;
    
    [mWindow addSubview:alertView];
    
    [alertView showBackgroundView];
}



/**
 *  绘制基础View对象 blackView
 *
 *  @param containerView 自定义View视图
 *
 *  @return AlertView
 */
-(UIView *)alertViewWithCustomView:(UIView *)containerView{
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BabysanteAlertView_Weight, containerView.frame.size.height + BabysanteAlertViewBtn_Height + BabysanteAlertViewItem_Space *2)];
    alertView.layer.cornerRadius = 8.0f;
    alertView.layer.masksToBounds = YES;
    alertView.backgroundColor = [UIColor whiteColor];
    
    [alertView addSubview:containerView];
    containerView.center = CGPointMake(alertView.frame.size.width / 2, (alertView.frame.size.height - BabysanteAlertViewBtn_Height - BabysanteAlertViewItem_Space) / 2);
    
    return alertView;

}


/**
 *  自定义 AlertView中 button对象
 *
 *  @param alertView AlertView
 */
-(void) CustomAlterViewBtnObj:(UIView *)alertView{
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

}


/**
 *  自定义AlertView 多个button 对象
 *
 *  @param alertView alertView 对象
 *  @param cancelBtn 取消按钮
 *  @param okBtn     确定按钮
 */
-(void) CustomAlterViewBtnObj:(UIView *)alertView WithCancel:(NSString *)cancelBtn Others:(NSArray *)othersBtn{
    
    //没有其他按钮选项
    if (cancelBtn && !othersBtn) {
        //*绘制取消按钮
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setFrame:CGRectMake(0, alertView.frame.size.height - BabysanteAlertViewBtn_Height, alertView.frame.size.width,BabysanteAlertViewBtn_Height)];
        [btn setTintColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:cancelBtn forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action_CancelEvent:) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:btn];
    }else{
        NSMutableArray *muArrBtnList = [NSMutableArray arrayWithArray:othersBtn];
        [muArrBtnList insertObject:cancelBtn atIndex:0];
        
        //遍历绘制所有按钮
        CGFloat item_W = (alertView.frame.size.width - muArrBtnList.count)/ muArrBtnList.count;
        for (int i = 0; i<muArrBtnList.count; i++) {
            NSString *segItem = muArrBtnList[i];
            UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeSystem];
            [btnMenu setFrame:CGRectMake(1*i + item_W*i, alertView.frame.size.height - BabysanteAlertViewBtn_Height - 1, item_W,BabysanteAlertViewBtn_Height)];
            [btnMenu setTitle:segItem forState:UIControlStateNormal];
            [btnMenu setTag:i+1];
            [btnMenu setBackgroundColor:[UIColor whiteColor]];
            [btnMenu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnMenu setTintColor:[UIColor clearColor]];
            i==0 ? ([btnMenu addTarget:self action:@selector(action_CancelEvent:) forControlEvents:UIControlEventTouchUpInside]):(
            [btnMenu addTarget:self action:@selector(action_OkEvent:) forControlEvents:UIControlEventTouchUpInside]);
            [alertView addSubview:btnMenu];
            
            if (i == muArrBtnList.count - 1) {
                //** 绘制分割线
                UILabel *vLine = [UILabel new];
                [vLine setFrame:CGRectMake(1*i + item_W*i + 1, alertView.frame.size.height - BabysanteAlertViewBtn_Height -1, 1, BabysanteAlertViewBtn_Height)];
                [vLine setBackgroundColor:[UIColor lightGrayColor]];
                [vLine setAlpha:0.5];
                [alertView addSubview:vLine];
            }
 
        }
        
    }
    
    //** 绘制分割线
    UILabel *hLine = [UILabel new];
    [hLine setFrame:CGRectMake(0, alertView.frame.size.height - BabysanteAlertViewBtn_Height -1, alertView.frame.size.width, 1)];
    [hLine setBackgroundColor:[UIColor lightGrayColor]];
    [hLine setAlpha:0.5];
    [alertView addSubview:hLine];

    
}




-(void)action_ClickEvent:(UIButton *)btn{

    WEAKSELF
    [weakSelf hideBackgroundView];
    
    if (weakSelf.AlertViewBlock) {
        weakSelf.AlertViewBlock();
    }
    
}


-(void)action_CancelEvent:(UIButton *)btn{
    
    WEAKSELF
    [weakSelf hideBackgroundView];
    
    if (weakSelf.cancelBlock) {
        weakSelf.cancelBlock();
    }
    
}



-(void)action_OkEvent:(UIButton *)btn{
    
    WEAKSELF
    [weakSelf hideBackgroundView];
    
    if (weakSelf.othersBlock) {
        weakSelf.othersBlock(btn.tag);
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

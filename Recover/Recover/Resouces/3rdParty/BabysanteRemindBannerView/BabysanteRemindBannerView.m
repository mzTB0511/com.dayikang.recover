//
//  BabysanteRemindBannerView.m
//  BabySante
//
//  Created by 刘轩 on 15/8/4.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "BabysanteRemindBannerView.h"

@interface BabysanteRemindBannerView()
//视图提醒文字
@property(strong, nonatomic) UILabel *remindText;


@end

@implementation BabysanteRemindBannerView


/**
 *  用户信息不完整时显示提醒 banner 信息
 *
 *  @param frame   弹出视图大小
 *  @param img     包含的图片
 *  @param content 显示提醒内容
 *  @param name    按钮名称
 *  @param block   跳转事件回调
 *
 *  @return 弹出Banner 视图
 */
+ (BabysanteRemindBannerView*) initWithFrame:(CGRect)frame Bgcolor:(UIColor *)bgColor AndUserIco:(UIImage *)img AndContent:(NSString *)content AnResponEventItem:(NSString *)name WithEventBlock:(BabysanteRemindBannerCompleateBlock)block{
    
    BabysanteRemindBannerView *view = [[BabysanteRemindBannerView alloc] initWithFrame:frame];
    
    [view initWithBannerView:view Bgcolor:bgColor AndUserIco:img AndContent:content AnResponEventItem:name];
    
    view.compleateBlock = block;
    
    return view;
}



/**
 *  用户信息提醒显示 banner 信息
 *
 *  @param frame   弹出视图大小
 *  @param content 显示提醒内容
 *  @param name    按钮名称
 *  @param block   跳转事件回调
 *
 *  @return 弹出Banner 视图
 */
+ (BabysanteRemindBannerView*) initWithFrame:(CGRect)frame Bgcolor:(UIColor *)bgColor AndContent:(NSString *)content AnResponEventItem:(NSString *)name WithEventBlock:(BabysanteRemindBannerCompleateBlock)block{
    
    BabysanteRemindBannerView *view = [[BabysanteRemindBannerView alloc] initWithFrame:frame];
    
    [view initWithBannerView:view Bgcolor:bgColor AndContent:content AnResponEventItem:name];
    
    view.compleateBlock = block;
    
    return view;
}




/**
 *  弹出视图
 *
 *  @param view    view
 *  @param bgColor 背景颜色
 *  @param content 内容
 *  @param name    交互按钮标题
 */
-(void)initWithBannerView:(BabysanteRemindBannerView *)view Bgcolor:(UIColor *)bgColor AndContent:(NSString *)content AnResponEventItem:(NSString *)name {
    
    [view setBackgroundColor:bgColor];
    
    _remindText = [UILabel new];
    _remindText.frame = CGRectMake(0, 0, getScreenWidth - 50, view.frame.size.width / 2);
    _remindText.backgroundColor = [UIColor clearColor];
    _remindText.center = CGPointMake(getScreenWidth / 2 - 15, view.frame.size.height / 2);
    _remindText.text = content;
    _remindText.font = [UIFont systemFontOfSize:14];
    [view addSubview:_remindText];
    _remindText.alpha = 0.6;
     _remindText.font = [UIFont systemFontOfSize:14];
    
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(0, 0, 55, view.frame.size.height / 2)];
    [btn setTitle:name forState:UIControlStateNormal];
    btn.center = CGPointMake(getScreenWidth - btn.frame.size.width / 2, view.frame.size.height / 2);
    [btn setTitleColor:Color_System_Tint_Color forState:UIControlStateNormal];
    btn.alpha = 0.6;
    btn.tintColor = [UIColor blackColor];
    btn.titleLabel.tintColor = Color_System_Tint_Color;
    [btn addTarget:self action:@selector(action_ClickEnent:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
}




/**
 *  加载视图内容
 *
 *  @param view    banner弹出视图
 *  @param img     包含的图片
 *  @param content 显示提醒内容
 *  @param name    按钮名称

 */
-(void)initWithBannerView:(BabysanteRemindBannerView *)view Bgcolor:(UIColor *)bgColor AndUserIco:(UIImage *)img AndContent:(NSString *)content AnResponEventItem:(NSString *)name {
    //getColorWithRGB(254, 243, 208)
    [view setBackgroundColor:bgColor];
    UIImageView *imgIco = [[UIImageView new] initWithImage:img];
    [imgIco setFrame:CGRectMake(10, 0, view.frame.size.height - 10, view.frame.size.height - 10)];
    imgIco.contentMode = UIViewContentModeScaleAspectFill;
    imgIco.center = CGPointMake(imgIco.frame.size.width / 2 + imgIco.frame.origin.x, view.frame.size.height / 2);
    [view addSubview:imgIco];

    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(getScreenWidth - 75,0, 60, view.frame.size.height)];
    [btn setTitle:name forState:UIControlStateNormal];
  //  btn.titleLabel.textColor = [UIColor blackColor];
    btn.alpha = 0.6;
    btn.tintColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(action_ClickEnent:) forControlEvents:UIControlEventTouchUpInside];
    
    _remindText = [UILabel new];
    _remindText.frame = CGRectMake(imgIco.frame.origin.x + imgIco.frame.size.width + 10, 0, getScreenWidth - btn.frame.size.width, view.frame.size.height);
    _remindText.backgroundColor = [UIColor clearColor];
    _remindText.text = content;
    _remindText.font = [UIFont systemFontOfSize:14];
    [view addSubview:_remindText];
    _remindText.alpha = 0.6;
    
    
    [view addSubview:btn];
    
}



-(void)action_ClickEnent:(UIButton *)sender{
   
    if (self.compleateBlock) {
        self.compleateBlock(_remindText,sender);
    }
    
}



@end

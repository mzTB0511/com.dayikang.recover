//
//  BabysanteRemindBannerView.h
//  BabySante
//
//  Created by 刘轩 on 15/8/4.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BabysanteRemindBannerView;

typedef void(^BabysanteRemindBannerCompleateBlock)(UILabel *remindLabel,UIButton *btn);

@interface BabysanteRemindBannerView : UIView
@property(nonatomic,strong)BabysanteRemindBannerCompleateBlock compleateBlock;


//*初始化BannerView
/**
 *  用户信息不完整时显示提醒 banner 信息
 *
 *  @param frame   弹出视图大小
 *  @param bgColor 背景颜色
 *  @param img     包含的图片
 *  @param content 显示提醒内容
 *  @param name    按钮名称
 *  @param block   跳转事件回调
 *
 *  @return 弹出Banner 视图
 */
+ (BabysanteRemindBannerView*) initWithFrame:(CGRect)frame Bgcolor:(UIColor *)bgColor AndUserIco:(UIImage *)img AndContent:(NSString *)content AnResponEventItem:(NSString *)name WithEventBlock:(BabysanteRemindBannerCompleateBlock)block;



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
+ (BabysanteRemindBannerView*) initWithFrame:(CGRect)frame Bgcolor:(UIColor *)bgColor AndContent:(NSString *)content AnResponEventItem:(NSString *)name WithEventBlock:(BabysanteRemindBannerCompleateBlock)block;


@end

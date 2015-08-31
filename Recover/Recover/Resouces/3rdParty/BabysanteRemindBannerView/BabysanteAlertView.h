//
//  BabysanteAlertView.h
//  BabySante
//
//  Created by 刘轩 on 15/8/14.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BabysanteAlertViewBlock)(void);

@class BabysanteAlertView;

@interface BabysanteAlertView : UIView

/**
 *  弹出自定义AlertView视图
 *
 *  @param contentView customersContenrView;
 *  @param block       回调事件;
 *
 *  @return babysanteAlertView;
 */
+ (void)BabysanteAlertViewShow:(UIView *)contentView Block:(BabysanteAlertViewBlock)block;


@end

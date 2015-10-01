//
//  BabysanteAlertView.h
//  BabySante
//
//  Created by 刘轩 on 15/8/14.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BabysanteAlertViewBlock)(void);
typedef void (^BabysanteAlertViewCancelBlock)(void);
typedef void (^BabysanteAlertViewOthersBlock)(NSInteger btnIndex);


@class BabysanteAlertView;

@interface BabysanteAlertView : UIView

/**
 *  弹出自定义AlertView视图(自定义View)
 *
 *  @param contentView customersContenrView;
 *  @param block       回调事件;
 *
 *  @return babysanteAlertView;
 */
+ (void)BabysanteAlertViewShow:(UIView *)contentView Block:(BabysanteAlertViewBlock)block;



/**
 *  弹出自定义AlertView视图 (自定义View + Btn)
 *
 *  @param contentView 自定义View
 *  @param cancel      取消按钮
 *  @param others      其他按钮
 *  @param cancelBlock 取消回调
 *  @param othersBlock 其他按钮回调
 */
+ (void)BabysanteAlertViewShow:(UIView *)contentView CancelBtn:(NSString *)cancel OtherBtns:(NSArray *)others CalelBlock:(BabysanteAlertViewCancelBlock)cancelBlock OthersBlock:(BabysanteAlertViewOthersBlock)othersBlock;




@end

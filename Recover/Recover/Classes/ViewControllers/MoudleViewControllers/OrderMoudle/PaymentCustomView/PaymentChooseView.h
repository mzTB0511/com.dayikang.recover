//
//  PaymentChooseView.h
//  Recover
//
//  Created by 刘轩 on 15/10/1.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PaymentMoudle : NSObject

/**
 *  支付初始化数据
 */

/**
*  支付费用
*/
@property(nonatomic,assign) CGFloat payAmont;
// 账户金额
@property(nonatomic,assign) CGFloat totalAmount;

@property(nonatomic,strong) NSString *userPhone;


@end



@interface PaymentChooseView : UIView


-(void)actionSetViewWith:(PaymentMoudle *)payMoudule ChooseBlock:(CommonReturnDataBlock)block;

@end

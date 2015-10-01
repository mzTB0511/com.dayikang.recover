//
//  PaymentChooseHeaderView.m
//  Recover
//
//  Created by 刘轩 on 15/10/2.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "PaymentChooseHeaderView.h"
@interface PaymentChooseHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *lbPhone;



@end
@implementation PaymentChooseHeaderView

-(void)setPhone:(NSString *)phone{
    [_lbPhone setText:getValueIfNilReturnStr(phone)];
}

@end

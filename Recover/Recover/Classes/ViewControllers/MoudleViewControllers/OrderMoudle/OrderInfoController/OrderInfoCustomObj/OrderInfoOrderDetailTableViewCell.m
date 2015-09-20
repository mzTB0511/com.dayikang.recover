//
//  OrderInfoOrderDetailTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "OrderInfoOrderDetailTableViewCell.h"
@interface OrderInfoOrderDetailTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lbUserName;

@property (weak, nonatomic) IBOutlet UILabel *lbPhone;

@property (weak, nonatomic) IBOutlet UILabel *lbAddress;

@property (weak, nonatomic) IBOutlet UILabel *lbDesc;


@end


@implementation OrderInfoOrderDetailTableViewCell

-(void)setCellData:(NSDictionary *)cellData{
    [super setCellData:cellData];
    [_lbUserName setText:cellData[@"name"]];
    [_lbPhone setText:cellData[@"phone"]];
    [_lbAddress setText:cellData[@"address"]];
    [_lbDesc setText:cellData[@"desc"]];
    
}

@end

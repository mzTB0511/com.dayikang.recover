//
//  OrderInfoServiceTimeTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "OrderInfoServiceTimeTableViewCell.h"
@interface OrderInfoServiceTimeTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lbOrderNo;

@property (weak, nonatomic) IBOutlet UILabel *lbCreateTime;

@property (weak, nonatomic) IBOutlet UILabel *lbOrderedTime;

@end

@implementation OrderInfoServiceTimeTableViewCell

-(void)setCellData:(NSDictionary *)cellData{
    [super setCellData:cellData];
    
    [_lbOrderNo setText:cellData[@"orders_bh"]];
    [_lbCreateTime setText:cellData[@"order_time"]];
    [_lbOrderedTime setText:cellData[@"service_start_time"]];
}

@end

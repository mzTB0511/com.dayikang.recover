//
//  OrderInfoProgramTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "OrderInfoProgramTableViewCell.h"
@interface OrderInfoProgramTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *lbProgramName;

@property (weak, nonatomic) IBOutlet UILabel *lbDoctorName;

@property (weak, nonatomic) IBOutlet UILabel *lbPrice;


@end

@implementation OrderInfoProgramTableViewCell


-(void)setCellData:(NSDictionary *)cellData{
    [super setCellData:cellData];
    [_lbProgramName setText:cellData[@"programs"]];
    [_lbDoctorName setText:cellData[@"name"]];
    [_lbPrice setText:cellData[@"amount"]];
}

@end

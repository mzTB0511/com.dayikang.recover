//
//  MakeOrderAddressTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MakeOrderAddressTableViewCell.h"
@interface MakeOrderAddressTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *lbPhone;

@property (weak, nonatomic) IBOutlet UILabel *lbAddress;


@end


@implementation MakeOrderAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellData:(NSDictionary *)cellData{
    [_lbName setText:getValueIfNilReturnStr(cellData[@"name"])];
    [_lbPhone setText:getValueIfNilReturnStr(cellData[@"phone"])];
    [_lbAddress setText:getValueIfNilReturnStr(cellData[@"address"])];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

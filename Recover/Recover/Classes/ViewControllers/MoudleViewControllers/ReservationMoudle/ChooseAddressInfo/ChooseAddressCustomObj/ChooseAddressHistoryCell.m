//
//  ChooseAddressHistoryCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/15.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "ChooseAddressHistoryCell.h"

@interface ChooseAddressHistoryCell()


@end

@implementation ChooseAddressHistoryCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellData:(NSDictionary *)cellData{
    if(_cellData == cellData) return;
    NSString *strP  = getValueIfNilReturnStr(cellData[@"province_name"]);
    NSString *strC  = getValueIfNilReturnStr(cellData[@"city_name"]);
    NSString *strA  = getValueIfNilReturnStr(cellData[@"area_name"]);
    NSString *strAddress  = getValueIfNilReturnStr(cellData[@"address"]);
    
    [_lbItemName setText:getStringAppendingStr(strP, (@[@" ",strC,@" ",strA,@" ",strAddress]))];
    [_btnUsed setTag:[cellData[@"contact_id"] intValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ChooseAddressHistoryCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/15.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "ChooseAddressHistoryCell.h"

@interface ChooseAddressHistoryCell()

@property (weak, nonatomic) IBOutlet UILabel *lbItemName;

@end

@implementation ChooseAddressHistoryCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellData:(NSDictionary *)cellData{
    if(_cellData == cellData) return;

    [_lbItemName setText:cellData[@""]];
    [_btnUsed setTag:[cellData[@""] intValue]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

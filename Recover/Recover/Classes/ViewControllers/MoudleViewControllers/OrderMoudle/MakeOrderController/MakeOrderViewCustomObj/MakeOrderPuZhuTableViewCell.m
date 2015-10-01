//
//  MakeOrderPuZhuTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MakeOrderPuZhuTableViewCell.h"
@interface MakeOrderPuZhuTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lbPuZhuItem;

@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbDesc;


@end



@implementation MakeOrderPuZhuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellData:(NSDictionary *)cellData{
    [_lbPuZhuItem setText:getValueIfNilReturnStr(cellData[@"sub_name"])];
    [_lbPrice setText:getValueIfNilReturnStr(cellData[@"sub_price"])];
    [_lbDesc setText:getStringAppendingStr(getValueIfNilReturnStr(cellData[@"sub_disount"]), (@[@" ",getValueIfNilReturnStr(cellData[@"sub_duration"])])) ];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

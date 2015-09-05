//
//  LXBaseTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/5.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "LXBaseTableViewCell.h"

@implementation LXBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellData:(NSDictionary *)cellData{
    if (_cellData == cellData) return;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

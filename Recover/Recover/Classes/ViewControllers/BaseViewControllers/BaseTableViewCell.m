//
//  BaseTableViewCell.m
//  BabySante
//
//  Created by dd on 15/4/9.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

-(void)action_setData:(NSDictionary *)data {
    self.data = data;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

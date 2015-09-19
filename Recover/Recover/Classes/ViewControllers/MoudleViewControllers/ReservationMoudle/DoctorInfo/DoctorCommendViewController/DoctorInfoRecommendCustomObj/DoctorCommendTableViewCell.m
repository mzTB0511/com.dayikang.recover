//
//  DoctorCommendTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/19.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "DoctorCommendTableViewCell.h"
@interface DoctorCommendTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lbContent;

@property (weak, nonatomic) IBOutlet UILabel *lbCommender;

@property (weak, nonatomic) IBOutlet UILabel *lbCommendTime;



@end

@implementation DoctorCommendTableViewCell


- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellData:(NSDictionary *)cellData{
    if (_cellData == cellData) return;
    
    [_lbContent setText:cellData[@"content"]];
    [_lbCommender setText:cellData[@"creater"]];
    [_lbCommendTime setText:cellData[@"time"]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

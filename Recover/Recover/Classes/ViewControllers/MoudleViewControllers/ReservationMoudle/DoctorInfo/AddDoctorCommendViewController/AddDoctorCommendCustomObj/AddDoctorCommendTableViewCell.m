//
//  AddDoctorCommendTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "AddDoctorCommendTableViewCell.h"
#import "LXCommendStartView.h"

@interface AddDoctorCommendTableViewCell()




@property (weak, nonatomic) IBOutlet UIView *vServiceTd;

@property (weak, nonatomic) IBOutlet UIView *vServiceXl;

@property (weak, nonatomic) IBOutlet UIView *vServiceXg;


@end

@implementation AddDoctorCommendTableViewCell

- (void)awakeFromNib {
   WEAKSELF
    [_vServiceTd addSubview:[[LXCommendStartView alloc] initWithCommendStartFrame:CGRectMake(0, 0, _vServiceTd.frame.size.width,  _vServiceTd.frame.size.height) StartNum:5 ChooseBlock:^(NSInteger nums) {
        if (weakSelf.startBlock) {
            weakSelf.startBlock(1,nums);
        }
       
    }]];
    
    
    [_vServiceXl addSubview:[[LXCommendStartView alloc] initWithCommendStartFrame:CGRectMake(0, 0, _vServiceXl.frame.size.width,  _vServiceXl.frame.size.height) StartNum:5 ChooseBlock:^(NSInteger nums) {
        if (weakSelf.startBlock) {
            weakSelf.startBlock(2,nums);
        }
        
    }]];
    
    
    [_vServiceXg addSubview:[[LXCommendStartView alloc] initWithCommendStartFrame:CGRectMake(0, 0, _vServiceXg.frame.size.width,  _vServiceXg.frame.size.height) StartNum:5 ChooseBlock:^(NSInteger nums) {
        if (weakSelf.startBlock) {
            weakSelf.startBlock(3,nums);
        }
    }]];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

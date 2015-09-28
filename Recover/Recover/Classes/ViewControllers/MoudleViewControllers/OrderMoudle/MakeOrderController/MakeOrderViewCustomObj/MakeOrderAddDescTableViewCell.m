//
//  MakeOrderAddDescTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MakeOrderAddDescTableViewCell.h"
@interface MakeOrderAddDescTableViewCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfDesc;


@end


@implementation MakeOrderAddDescTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)actionSetCellData:(NSString *)data CompateBlock:(MakeoOderAddDescComplateBlock)block{
    if (data) {
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

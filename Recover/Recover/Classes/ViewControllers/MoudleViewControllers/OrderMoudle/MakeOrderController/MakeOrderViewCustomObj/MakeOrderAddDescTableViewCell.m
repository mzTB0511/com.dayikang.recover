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

@property(nonatomic,copy)MakeoOderAddDescComplateBlock block;

@end


@implementation MakeOrderAddDescTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_tfDesc setDelegate:self];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (self.block) {
        self.block(textField.text);
    }
}


-(void)actionSetCellData:(NSString *)data CompateBlock:(MakeoOderAddDescComplateBlock)block{
    self.block = block;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

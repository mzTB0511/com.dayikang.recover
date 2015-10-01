//
//  MyCouponsTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/8.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyCouponsTableViewCell.h"
@interface MyCouponsTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *vCellBgView;

@property (weak, nonatomic) IBOutlet UIView *vLeftView;

@property (weak, nonatomic) IBOutlet UIView *vReightView;

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *lbDesc;

@property (weak, nonatomic) IBOutlet UILabel *lbValidTime;

@property (weak, nonatomic) IBOutlet UIImageView *imgInValid;

@property (weak, nonatomic) IBOutlet UILabel *lbMoney;

@property (weak, nonatomic) IBOutlet UILabel *lbUp;

@property (weak, nonatomic) IBOutlet UILabel *lbDown;


@end


@implementation MyCouponsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_imgInValid setHidden:YES];
    
    _lbUp.layer.cornerRadius = 4.0f;
    _lbUp.layer.masksToBounds = YES;
    
    _lbDown.layer.cornerRadius = 4.0f;
    _lbDown.layer.masksToBounds = YES;
    
}

-(void)setCellData:(NSDictionary *)cellData{
    if (_cellData == cellData) return;
    [_lbName setText:cellData[@"name"]];
    [_lbDesc setText:cellData[@"desc"]];
    [_lbValidTime setText:getStringAppendingStr(@"有效期至:", cellData[@"validity_end"]) ];
    [_lbMoney setText:cellData[@"moeny"]];
    
    int status = [cellData[@"status"] intValue];
    switch (status) {
        case 0:
        case 1:{
            [_vLeftView setBackgroundColor:[UIColor whiteColor]];
            [_vReightView setBackgroundColor:getColorWithRGB(47, 154, 161)];
            [_imgInValid setHidden:YES];
        }
            break;
        case 2:{
            [_vLeftView setBackgroundColor:[UIColor grayColor]];
            [_vReightView setBackgroundColor:[UIColor whiteColor]];
            [_imgInValid setHidden:NO];
        }
            break;
        default:
            break;
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

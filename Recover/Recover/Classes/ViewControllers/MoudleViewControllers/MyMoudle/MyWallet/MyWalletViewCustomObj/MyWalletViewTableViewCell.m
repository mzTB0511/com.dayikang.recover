//
//  MyWalletViewTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyWalletViewTableViewCell.h"
@interface MyWalletViewTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *vBgView;

@property (weak, nonatomic) IBOutlet UILabel *lbAmount;

@property (weak, nonatomic) IBOutlet UILabel *lbSaleDesc;

@property (weak, nonatomic) IBOutlet UILabel *lbValidTime;

@property (weak, nonatomic) IBOutlet UILabel *lbUPCicle;

@property (weak, nonatomic) IBOutlet UILabel *lbDownCicle;



@end


@implementation MyWalletViewTableViewCell


- (void)awakeFromNib {
    // Initialization code
    _lbUPCicle.layer.cornerRadius = _lbUPCicle.frame.size.width/ 2;
    _lbUPCicle.layer.masksToBounds = YES;
    
    _lbDownCicle.layer.cornerRadius = _lbDownCicle.frame.size.width/ 2;
    _lbDownCicle.layer.masksToBounds = YES;
    
    _vBgView.layer.cornerRadius = 5;
    _vBgView.layer.masksToBounds = YES;
    
}


-(void)setCellData:(NSDictionary *)cellData{
    if (_cellData == cellData) return;
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

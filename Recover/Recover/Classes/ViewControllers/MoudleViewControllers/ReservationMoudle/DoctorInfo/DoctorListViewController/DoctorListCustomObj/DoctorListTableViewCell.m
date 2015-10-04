//
//  DoctorListTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/17.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "DoctorListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DoctorListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgDoctIco;

@property (weak, nonatomic) IBOutlet UILabel *lbDocName;

@property (weak, nonatomic) IBOutlet UILabel *lbSex;

@property (weak, nonatomic) IBOutlet UILabel *lbJobTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbWorkExperience;

@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbTime;

@property (weak, nonatomic) IBOutlet UILabel *lbOrderCount;

@property (weak, nonatomic) IBOutlet UILabel *lbLikeCount;

@property (weak, nonatomic) IBOutlet UIButton *btnReservation;

@end


@implementation DoctorListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imgDoctIco.layer.cornerRadius = _imgDoctIco.frame.size.width / 2;
    _imgDoctIco.layer.masksToBounds = YES;
    
}


-(void)setCellData:(NSDictionary *)cellData{
    if(_cellData == cellData) return;
    
    [_lbDocName setText:cellData[@"name"]];
    [_lbSex setText:[cellData[@"sex"] intValue] == 0 ? @"男" : @"女"];
    [_lbJobTitle setText:getStringAppendingStr(@"| ", cellData[@"levelname"])];
    [_lbWorkExperience setText:getStringAppendingStr(@"| ", (@[cellData[@"work_year"],@"年工作经验"]))];
    [_lbPrice setText:cellData[@"price"]];
    [_lbTime setText:getStringAppendingStr(cellData[@"service_time"],@"分钟")];
    [_lbOrderCount setText:getStringAppendingStr(cellData[@"nums"],@"单")];
    [_lbLikeCount setText:cellData[@"comment_count"]];
    
    UIImage *image = [cellData[@"sex"] isEqualToString:@"男"] ? getImageWithRes(@"img_DoctorMoudle_DoctorIco_Boy") : getImageWithRes(@"img_DoctorMoudle_DoctorIco_Girl");
   
    if ([cellData[@"ico"] hasPrefix:@"http://"]) {
        [_imgDoctIco sd_setImageWithURL:[NSURL URLWithString:cellData[@"ico"]] placeholderImage:image];
    }
    else
    {
        [_imgDoctIco setImage:image];
    }
    
    
    [_btnReservation addTarget:self action:@selector(actionSetParentViewBolock) forControlEvents:UIControlEventTouchUpInside];

    
}


-(void)actionSetParentViewBolock{
    if (self.doctorListCellBlock) {
        self.doctorListCellBlock();
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

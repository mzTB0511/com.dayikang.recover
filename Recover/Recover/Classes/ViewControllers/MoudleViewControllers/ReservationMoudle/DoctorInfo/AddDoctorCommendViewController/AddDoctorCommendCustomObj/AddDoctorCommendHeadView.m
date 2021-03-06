//
//  AddDoctorCommendHeadView.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "AddDoctorCommendHeadView.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface AddDoctorCommendHeadView()


@property (weak, nonatomic) IBOutlet UIImageView *img_DocIco;

@property (weak, nonatomic) IBOutlet UILabel *lb_ServiceItem;

@property (weak, nonatomic) IBOutlet UILabel *lb_DocName;

@property (weak, nonatomic) IBOutlet UILabel *lb_ServiceTime;


@end



@implementation AddDoctorCommendHeadView


-(void)setCellData:(NSDictionary *)cellData{
    if (_cellData == cellData) return;
    
    NSString *baoIco =getValueIfNilReturnStr([cellData objectForKey:@"doctor_ico"]);
    
    [_img_DocIco sd_setImageWithURL:[NSURL URLWithString:baoIco] placeholderImage:getImageWithRes(@"img_Default_UserIco_Boys")];

    [_lb_ServiceItem setText:[cellData objectForKey:@"service_name"]];
    [_lb_DocName setText:[cellData objectForKey:@"doctor_name"]];
    [_lb_ServiceTime setText:[cellData objectForKey:@"orders_status_name"]];
    

    
}


@end

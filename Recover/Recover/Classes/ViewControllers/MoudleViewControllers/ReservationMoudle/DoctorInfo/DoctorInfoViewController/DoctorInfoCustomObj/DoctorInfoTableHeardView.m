//
//  DoctorInfoTableHeardView.m
//  Recover
//
//  Created by 刘轩 on 15/9/19.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "DoctorInfoTableHeardView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface DoctorInfoTableHeardView()

@property (weak, nonatomic) IBOutlet UIImageView *imgDoctIco;

@property (weak, nonatomic) IBOutlet UILabel *lbDocName;

@property (weak, nonatomic) IBOutlet UILabel *lbSex;

@property (weak, nonatomic) IBOutlet UILabel *lbJobTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbAge;

@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbOrderCount;

@end


@implementation DoctorInfoTableHeardView


-(void)setViewData:(NSDictionary *)viewData{
    if(_viewData == viewData) return;
    
    [_lbDocName setText:viewData[@"name"]];
    [_lbSex setText:viewData[@"sex"]];
    [_lbJobTitle setText:viewData[@"levelname"]];
    [_lbAge setText:viewData[@"age"]];
    [_lbPrice setText:viewData[@"price"]];
    [_lbOrderCount setText:viewData[@"nums"]];
  
    
    UIImage *image = [viewData[@"sex"] isEqualToString:@"男"] ? getImageWithRes(@"img_DoctorMoudle_DoctorIco_Boy") : getImageWithRes(@"img_DoctorMoudle_DoctorIco_Girl");
   
    if ([viewData[@"ico"] hasPrefix:@"http://"]) {
        [_imgDoctIco sd_setImageWithURL:[NSURL URLWithString:viewData[@"ico"]] placeholderImage:image];
    }
    else
    {
        [_imgDoctIco setImage:image];
    }
    
}


@end

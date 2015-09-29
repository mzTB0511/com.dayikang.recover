//
//  ServiceItemCollectionViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/5.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "ServiceItemCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ServiceItemCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *img_ItemIco;

@property (weak, nonatomic) IBOutlet UILabel *lb_ItemName;



@end

@implementation ServiceItemCollectionViewCell



- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellData:(NSDictionary *)cellData{
    if (_cellData == cellData) {
        return;
    }
    
    [_img_ItemIco sd_setImageWithURL:getUrlWithStrValue(cellData[@"img_url"]) placeholderImage :getImageWithRes(@"img_url")];
    [_lb_ItemName setText:getValueFromDictionary(cellData, @"name")];
    
}

@end

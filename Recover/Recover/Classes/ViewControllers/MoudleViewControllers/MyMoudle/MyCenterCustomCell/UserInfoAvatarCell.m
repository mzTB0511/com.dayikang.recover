//
//  MoudleFourthUserInfoAvatarCell.m
//  BabySante
//
//  Created by dd on 15/4/28.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "MoudleFourthUserInfoAvatarCell.h"
#import <UIImageView+WebCache.h>

@interface MoudleFourthUserInfoAvatarCell ()

@property (weak, nonatomic) IBOutlet UILabel *lbl_title;

@property (weak, nonatomic) IBOutlet UIImageView *imv_image;

@end

@implementation MoudleFourthUserInfoAvatarCell

-(void)action_setupCellWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl {
    
    _imv_image.hidden = NO;
    
    _lbl_title.text = title;
    
   // if (imageUrl.length) {
        [_imv_image sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:default_Image_UserIco];
   // }
}

-(void)action_setImage:(UIImage *)image {
    _imv_image.hidden = NO;
    _imv_image.image = image;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

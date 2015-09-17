//
//  MoudleFourthUserInfoCell.m
//  BabySante
//
//  Created by dd on 15/4/22.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "ChooseAddressCustomCell.h"
//#import <UIImageView+WebCache.h>

@interface ChooseAddressCustomCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbl_title;

@property (weak, nonatomic) IBOutlet UILabel *lbl_detail;

@property (weak, nonatomic) IBOutlet UIImageView *imv_image;

@property (weak, nonatomic) IBOutlet UITextField *txf_input;

@end

@implementation ChooseAddressCustomCell

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]) {
        [self endEditing:YES];
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.EditCompletion) {
        self.EditCompletion(textField.text);
    }
}

-(void)action_setupCellWithTitle:(NSString *)title detail:(NSString *)detail canEdit:(BOOL)canEdit {
    
    if (canEdit) {
        _txf_input.hidden = NO;
        _txf_input.placeholder = @"未填写";
        _txf_input.text = detail;
    } else {
        _lbl_detail.hidden = NO;
        
        if (detail.length) {
            _lbl_detail.text = detail;
            _lbl_detail.textColor = mRGBColor(85, 85, 85);
        } else {
            _lbl_detail.text = @"未设置";
            _lbl_detail.textColor = mRGBColor(200, 200, 200);
        }
        
        //如果是状态切换cell 特殊处理
        if (self.isStatusCell) {
            _lbl_detail.textColor = Color_System_Tint_Color;
            _lbl_detail.text = detail;
        }
    }
    
    _lbl_title.text = title;
}

//-(void)action_setupCellWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl {
//    
//    _imv_image.hidden = NO;
//    
//    _lbl_title.text = title;
//    
//    if (imageUrl.length) {
//        [_imv_image sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"img_moudle_fourth_avatar"]];
//    }
//}
//
//-(void)action_setImage:(UIImage *)image {
//    _imv_image.hidden = NO;
//    _imv_image.image = image;
//}

-(void)prepareForReuse {
    _lbl_detail.hidden = YES;
    _imv_image.hidden = YES;
    _txf_input.hidden = YES;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

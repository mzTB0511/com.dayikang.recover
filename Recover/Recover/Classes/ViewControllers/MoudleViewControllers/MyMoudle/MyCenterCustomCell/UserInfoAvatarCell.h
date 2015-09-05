//
//  MoudleFourthUserInfoAvatarCell.h
//  BabySante
//
//  Created by dd on 15/4/28.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoudleFourthUserInfoAvatarCell : UITableViewCell

/**
 *  配置cell 两种方法任选其一
 *
 *  @param title     左边标题
 *  @param imageUrl  右边图片
 */
- (void) action_setupCellWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl;

/**
 *  给头像放入图片
 */
- (void) action_setImage:(UIImage *)image;

@end

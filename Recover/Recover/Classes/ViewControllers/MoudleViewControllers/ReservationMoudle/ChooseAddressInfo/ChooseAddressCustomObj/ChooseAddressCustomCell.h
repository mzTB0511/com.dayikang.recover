//
//  MoudleFourthUserInfoCell.h
//  BabySante
//
//  Created by dd on 15/4/22.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseAddressCustomCell : UITableViewCell

@property (nonatomic, copy) void(^EditCompletion)(NSString *string);

/**
 *  如果是状态cell 则文字是顶部红色
 */
@property (nonatomic, assign) BOOL isStatusCell;

/**
 *  配置cell 两种方法任选其一
 *
 *  @param title       左边标题
 *  @param detail      右边内容
 *  @param canEdit     能否编辑
 */
- (void) action_setupCellWithTitle:(NSString *)title detail:(NSString *)detail canEdit:(BOOL)canEdit;

/**
 *  配置cell 两种方法任选其一
 *
 *  @param title     左边标题
 *  @param imageUrl  右边图片
 */
//- (void) action_setupCellWithTitle:(NSString *)title imageUrl:(NSString *)imageUrl;

/**
 *  给头像放入图片
 */
//- (void) action_setImage:(UIImage *)image;

@end

//
//  DoctorInfoZhengShuCell.h
//  Recover
//
//  Created by 刘轩 on 15/9/19.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DoctorInfoZhzengShuBlock)(NSInteger selIndex);

@interface DoctorInfoZhengShuCell : UITableViewCell

/**
 *  初始化证书View
 *
 *  @param list  图片列表数据
 *  @param block 点击图片后的回调
 */
-(void)actionSetCellData:(NSArray *)list CollectionViewBlock:(DoctorInfoZhzengShuBlock)block;

@end

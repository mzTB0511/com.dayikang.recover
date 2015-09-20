//
//  AddDoctorCommendTableViewCell.h
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddDcotorCommendStartViewBlock) (NSInteger type, NSInteger starNums);

@interface AddDoctorCommendTableViewCell : UITableViewCell

@property(nonatomic,copy)AddDcotorCommendStartViewBlock startBlock;


@end

//
//  DoctorListTableViewCell.h
//  Recover
//
//  Created by 刘轩 on 15/9/17.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorListTableViewCell : UITableViewCell



@property(nonatomic ,strong) NSDictionary *cellData;

@property(nonatomic,copy)CommonBlock doctorListCellBlock;

@end

//
//  DoctorListTableViewCell.h
//  Recover
//
//  Created by 刘轩 on 15/9/17.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnReservation;

@property(nonatomic ,strong) NSDictionary *cellData;

@end
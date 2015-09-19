//
//  DoctorListViewController.h
//  Recover
//
//  Created by 刘轩 on 15/9/17.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^DoctorListViewReturnDoctorInfoBlock)(NSDictionary *dicInfo);

@interface DoctorListViewController : BaseViewController


@property(copy,nonatomic) DoctorListViewReturnDoctorInfoBlock doctorViewBlock;


@end

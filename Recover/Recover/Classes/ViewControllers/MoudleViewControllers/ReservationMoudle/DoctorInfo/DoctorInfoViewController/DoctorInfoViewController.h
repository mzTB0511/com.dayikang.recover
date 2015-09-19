//
//  DoctorInfoViewController.h
//  Recover
//
//  Created by 刘轩 on 15/9/19.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "RootViewController.h"
typedef void(^DoctorInfoViewReturnBlock)(NSDictionary *dicInfo);

@interface DoctorInfoViewController : RootViewController

@property(copy,nonatomic) DoctorInfoViewReturnBlock doctorInfoBlock;


@end

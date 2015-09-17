//
//  ChoooseAddressViewController.h
//  Recover
//
//  Created by 刘轩 on 15/9/14.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ChooseAddressViewReturnContactBlock)(NSString *contactID,NSString *addressDesc);

@interface ChoooseAddressViewController : BaseViewController

@property(nonatomic, copy)ChooseAddressViewReturnContactBlock returnContactBlock;

@end

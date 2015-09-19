//
//  LXColorBoundButton.m
//  Recover
//
//  Created by 刘轩 on 15/9/19.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "LXColorBoundButton.h"

@implementation LXColorBoundButton

-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = Color_System_Main_Color.CGColor;
    self.layer.cornerRadius = 3.0f;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
}

@end

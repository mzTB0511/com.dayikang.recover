//
//  LXCircleImageView.m
//  Recover
//
//  Created by 刘轩 on 15/9/5.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "LXCircleImageView.h"

@implementation LXCircleImageView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = self.frame.size.width /2;
    self.layer.masksToBounds = YES;
}


@end

//
//  OrderInfoKFLogTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "OrderInfoKFLogTableViewCell.h"
@interface OrderInfoKFLogTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *lbItemlogName;

@property (weak, nonatomic) IBOutlet UILabel *lbContent;


@end


@implementation OrderInfoKFLogTableViewCell

-(void)setCellData:(NSDictionary *)cellData{
    [super setCellData:cellData];
    
    [_lbItemlogName setText:cellData[@"title"]];
    [_lbContent setText:cellData[@"content"]];
}

@end

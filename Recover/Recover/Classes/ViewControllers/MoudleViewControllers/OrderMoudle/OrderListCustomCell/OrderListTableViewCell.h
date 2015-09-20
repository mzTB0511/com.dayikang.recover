//
//  OrderListTableViewCell.h
//  Recover
//
//  Created by 刘轩 on 15/9/5.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "LXBaseTableViewCell.h"

@interface OrderListTableViewCell : LXBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn_ReservationStatus;

@property (weak, nonatomic) IBOutlet UIButton *btnCommend;


-(void)actionSetCellData:(NSDictionary *)cellData WithType:(NSInteger)type;


@end

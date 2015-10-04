//
//  OrderListTableViewCell.h
//  Recover
//
//  Created by 刘轩 on 15/9/5.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "LXBaseTableViewCell.h"

@interface OrderListTableViewCell : LXBaseTableViewCell



-(void)actionSetCellData:(NSDictionary *)cellData WithType:(NSInteger)type CompleateBlock:(CommonBlock)compleateBlock AndCommendBlock:(CommonBlock)commendBlock;


@end

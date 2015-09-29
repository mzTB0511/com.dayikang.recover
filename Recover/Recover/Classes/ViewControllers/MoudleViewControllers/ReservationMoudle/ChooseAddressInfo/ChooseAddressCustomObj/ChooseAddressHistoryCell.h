//
//  ChooseAddressHistoryCell.h
//  Recover
//
//  Created by 刘轩 on 15/9/15.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseAddressHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnUsed;

@property (weak, nonatomic) IBOutlet UILabel *lbItemName;

@property(nonatomic,strong)NSDictionary *cellData;

@end

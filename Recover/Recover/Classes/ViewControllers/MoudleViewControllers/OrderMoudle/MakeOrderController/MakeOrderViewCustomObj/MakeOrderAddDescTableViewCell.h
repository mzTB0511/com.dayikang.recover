//
//  MakeOrderAddDescTableViewCell.h
//  Recover
//
//  Created by 刘轩 on 15/9/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MakeoOderAddDescComplateBlock)(NSString *content);

@interface MakeOrderAddDescTableViewCell : UITableViewCell

-(void)actionSetCellData:(NSString *)data CompateBlock:(MakeoOderAddDescComplateBlock)block;


@end

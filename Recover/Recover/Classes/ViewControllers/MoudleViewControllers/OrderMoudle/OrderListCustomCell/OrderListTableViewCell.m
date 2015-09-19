//
//  OrderListTableViewCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/5.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "OrderListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface OrderListTableViewCell()


@property (weak, nonatomic) IBOutlet UILabel *lb_OrderTime;

@property (weak, nonatomic) IBOutlet UILabel *lb_OrderStatus;

@property (weak, nonatomic) IBOutlet UIImageView *img_DocIco;

@property (weak, nonatomic) IBOutlet UILabel *lb_ServiceItem;

@property (weak, nonatomic) IBOutlet UILabel *lb_DocName;

@property (weak, nonatomic) IBOutlet UILabel *lb_ServiceTime;

@property (weak, nonatomic) IBOutlet UILabel *lb_Price;




@end


@implementation OrderListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellData:(NSDictionary *)cellData{
    [super setCellData:cellData];

    NSString *baoIco =getValueIfNilReturnStr([cellData objectForKey:@"ico"]);
    
    [_img_DocIco sd_setImageWithURL:[NSURL URLWithString:baoIco] placeholderImage:nil];

    [_lb_OrderTime setText:[cellData objectForKey:@"date"]];
    [_lb_ServiceItem setText:[cellData objectForKey:@"item_name"]];
    [_lb_DocName setText:[cellData objectForKey:@""]];
    [_lb_ServiceTime setText:[cellData objectForKey:@"time"]];
    [_lb_Price setText:[cellData objectForKey:@"amount"]];

    
    int orderStatus = [cellData[@"status"] intValue];
  
    WEAKSELF
    //** 设置订单状态
    void(^setOrderStatus)(int) = ^(int orderStatus){
        NSString *statusDesc = @"";
        switch (orderStatus) {
            case 1:
               statusDesc = @"正在服务";
                break;
            case 2:
                statusDesc = @"待评价";
                break;
            case 3:
                statusDesc = @"已评价";
                break;
            default:
                break;
        }
        
        [weakSelf.lb_OrderStatus setText:statusDesc];
    };
    
    
    //** 设置订单服务状态
    void(^setOrderServiceStatus)(int) = ^(int serviceStatus){
        NSString *statusDesc = @"";
        switch (serviceStatus) {
            case 1:
                statusDesc = @"确认服务";
                break;
            case 2:
                statusDesc = @"去评价";
                break;
            case 3:
                statusDesc = @"再次预约";
                break;
            default:
                break;
        }
        
         [weakSelf.btn_ReservationStatus setTitle:statusDesc forState:UIControlStateNormal];
    };
    
    setOrderStatus(orderStatus);
    
    setOrderServiceStatus(orderStatus);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

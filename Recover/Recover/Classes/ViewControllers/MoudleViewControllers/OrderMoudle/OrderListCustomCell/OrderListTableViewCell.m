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

@property (weak, nonatomic) IBOutlet UIButton *btn_ReservationStatus;



@end


@implementation OrderListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellData:(NSDictionary *)cellData{
    [super setCellData:cellData];

    NSString *baoIco =getValueIfNilReturnStr([cellData objectForKey:@""]);
    
    [_img_DocIco sd_setImageWithURL:[NSURL URLWithString:baoIco] placeholderImage:nil];

    [_lb_OrderTime setText:[cellData objectForKey:@""]];
    [_lb_ServiceItem setText:[cellData objectForKey:@""]];
    [_lb_DocName setText:[cellData objectForKey:@""]];
    [_lb_ServiceTime setText:[cellData objectForKey:@""]];
    [_lb_Price setText:[cellData objectForKey:@""]];

    
    int orderStatus = [cellData[@""] intValue];
    int serviceStatus = [cellData[@""] intValue];
    
    //** 设置订单状态
    void(^setOrderStatus)(int) = ^(int orderStatus){
        NSString *statusDesc = @"";
        switch (orderStatus) {
            case 1:
               statusDesc = @"等待服务";
                break;
            case 2:
                statusDesc = @"正在服务";
                break;
            case 3:
                statusDesc = @"服务结束";
                break;
            default:
                break;
        }
    };
    
    
    //** 设置订单服务状态
    void(^setOrderServiceStatus)(int) = ^(int serviceStatus){
        NSString *statusDesc = @"";
        switch (serviceStatus) {
            case 1:
                statusDesc = @"正在处理";
                break;
            case 2:
                statusDesc = @"预约成功";
                break;
            case 3:
                statusDesc = @"完成服务";
                break;
            default:
                break;
        }
    };
    
    
    setOrderStatus(orderStatus);
    
    setOrderServiceStatus(serviceStatus);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

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


@property (weak, nonatomic) IBOutlet UILabel *lbKFSLog;

@property (weak, nonatomic) IBOutlet UILabel *lbKFSLogContent;

@property (weak, nonatomic) IBOutlet UIButton *btn_ReservationStatus;

@property (weak, nonatomic) IBOutlet UIButton *btnCommend;


@property(nonatomic,copy)CommonBlock compleateBlock;
@property(nonatomic,copy)CommonBlock commendBlock;


@end


@implementation OrderListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



-(void)actionSetCellData:(NSDictionary *)cellData WithType:(NSInteger)type CompleateBlock:(CommonBlock)compleateBlock AndCommendBlock:(CommonBlock)commendBlock{

    NSString *baoIco =getValueIfNilReturnStr([cellData objectForKey:@"doctor_ico"]);
    
    [_img_DocIco sd_setImageWithURL:[NSURL URLWithString:baoIco] placeholderImage:nil];

    [_lb_OrderTime setText:[cellData objectForKey:@"date"]];
    [_lb_ServiceItem setText:[cellData objectForKey:@"r_date"]];
    [_lb_DocName setText:[cellData objectForKey:@"doctor_name"]];
    [_lb_ServiceTime setText:[cellData objectForKey:@"service_start_time"]];
    [_lb_Price setText:getStringAppendingStr([cellData objectForKey:@"amount"], @"元") ];
    [_lb_OrderStatus setText:[cellData objectForKey:@"orders_status_name"]];
   
   
    int orderStatus = [cellData[@"orders_status"] intValue];
    WEAKSELF
    /*
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
    
    */
    
    
    //** 设置订单服务状态
    void(^setOrderServiceStatus)(int) = ^(int serviceStatus){
        NSString *statusDesc = @"";
        switch (serviceStatus) {
            case 1:
                statusDesc = @"去支付";
                break;
            case 2:
                statusDesc = @"待服务";
                break;
            case 3:
                statusDesc = @"确认服务";
                break;
            case 4:
                statusDesc = @"去评价";
                break;
            case 6:
                statusDesc = @"再次预约";
                break;
            default:
                break;
        }
        
         [weakSelf.btn_ReservationStatus setTitle:statusDesc forState:UIControlStateNormal];
    };
    
  //  setOrderStatus(orderStatus);
    
    setOrderServiceStatus(orderStatus);
    
    // ** 进行中， 已经完成项目分开处理
    switch (type) {
        case 1:{
            [_lbKFSLog setHidden:YES];
            [_lbKFSLogContent setHidden:YES];
            [_btnCommend setHidden:YES];
        }
            
            break;
        case 2:{
            [_lbKFSLog setHidden:NO];
            [_lbKFSLogContent setHidden:NO];
            [_btnCommend setHidden:NO];
        }
            
            break;
    }
    
    [_lbKFSLogContent setText:[cellData objectForKey:@"content_desc"]];
    self.compleateBlock = compleateBlock;
    self.commendBlock = commendBlock;
    
    [_btn_ReservationStatus addTarget:self action:@selector(actionCompleateOrder) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnCommend addTarget:self action:@selector(actionCommended) forControlEvents:UIControlEventTouchUpInside];
    
}



-(void)actionCompleateOrder{
    if (self.compleateBlock) {
        self.compleateBlock();
    }
}


-(void)actionCommended{
    if (self.commendBlock) {
        self.commendBlock();
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  OrderInfoViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "OrderInfoProgramTableViewCell.h"
#import "OrderInfoOrderDetailTableViewCell.h"
#import "OrderInfoServiceTimeTableViewCell.h"
#import "OrderInfoKFLogTableViewCell.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"
#import "ChooseAddressCustomView.h"
#import <BlocksKit/UIControl+BlocksKit.h>

@interface OrderInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(weak,nonatomic) IBOutlet UITableView *tbvOrderInfo;

@property(strong,nonatomic) NSMutableArray *muArrDataSource;


@end

@implementation OrderInfoViewController


#pragma mark --UITabelVeiwDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 150;
            break;
        case 1:
            return 150;
            break;
        case 2:
            return 105;
            break;
        case 3:
        case 4:{
            OrderInfoKFLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoKFLogTableViewCell"];
           [cell setCellData:_muArrDataSource[indexPath.section][indexPath.row]];
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
           
            if ( size.height + 1 <= 85) {
                return 85;
            }
            return size.height + 1;
        }
            break;
    }
    return 0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _muArrDataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_muArrDataSource[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LXBaseTableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:{
            cell = getDequeueReusableCellWithClass(OrderInfoProgramTableViewCell);

        }
            break;
        case 1:{
            cell = getDequeueReusableCellWithClass(OrderInfoOrderDetailTableViewCell);
        }
            break;
        case 2:{
            cell = getDequeueReusableCellWithClass(OrderInfoServiceTimeTableViewCell);
        }
            break;
        case 3:{
            cell = getDequeueReusableCellWithClass(OrderInfoKFLogTableViewCell);
        }
            break;
        case 4:{
            cell = getDequeueReusableCellWithClass(OrderInfoKFLogTableViewCell);
        }
            break;

    }
    
    [cell setCellData:_muArrDataSource[indexPath.section][indexPath.row]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(void)setupMJTableView{
    WEAKSELF
    [_tbvOrderInfo addHeaderWithCallback:^{
        [weakSelf loadOrderDataFromServerWithOrderID:(NSString *)self.viewObject];
        
    }];
    
    [_tbvOrderInfo headerBeginRefreshing];
}


-(void)loadOrderDataFromServerWithOrderID:(NSString *)orderID{
 WEAKSELF
    NSMutableArray * (^makeTableViewDataSourceWith)(NSDictionary *) = ^(NSDictionary *orderData){
        NSMutableArray *retArr = [NSMutableArray array];
        if (orderData.count > 0) {
            //** 康复项目
            NSDictionary *dictPorgram = @{@"service_name":getValueIfNilReturnStr(orderData[@"service_name"]),
                                          @"doctor_name":getValueIfNilReturnStr(orderData[@"doctor_name"]),
                                          @"amount":getValueIfNilReturnStr(orderData[@"amount"])};
            
            NSDictionary *dictAddress  = orderData[@"contact_data"];
            
            NSString *address = getStringAppendingStr(getValueIfNilReturnStr(dictAddress[@"province"]), (@[@" ",getValueIfNilReturnStr(dictAddress[@"city"]),@" ",getValueIfNilReturnStr(dictAddress[@"area"]),@" ",getValueIfNilReturnStr(dictAddress[@"address"])]));
            
            NSDictionary *dictOrder = @{@"name":getValueIfNilReturnStr(dictAddress[@"name"]),
                                        @"phone":getValueIfNilReturnStr(dictAddress[@"phone"]),
                                        @"address":address,
                                        @"desc":getValueIfNilReturnStr(orderData[@"desc"])};
            
            NSDictionary *dictOrderTime = @{@"orders_bh":getValueIfNilReturnStr(orderData[@"orders_bh"]),
                                            @"order_time":getValueIfNilReturnStr(orderData[@"order_time"]), @"service_start_time":getValueIfNilReturnStr(orderData[@"service_start_time"])};
            
            NSString *doctorLog = [orderData[@"doctor_log"] isEqualToString:@""] ?  @"康复师尚未留言" :orderData[@"doctor_log"];
            
            NSDictionary *dictKfLog = @{@"title":@"康复日志",
                                            @"content":doctorLog};
            
            NSString *usrCommend = [orderData[@"comment"] isEqualToString:@""] ? @"用户尚未做出评价" : orderData[@"comment"] ;
            
            NSDictionary *dictCommend = @{@"title":@"客户评价",
                                             @"content":usrCommend};
        
            [retArr addObject:@[dictPorgram]];
            [retArr addObject:@[dictOrder]];
            [retArr addObject:@[dictOrderTime]];
            [retArr addObject:@[dictKfLog]];
            [retArr addObject:@[dictCommend]];
            
        }
        
        return retArr;
    };
    
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"orders_id":orderID}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"orders/info")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"data"]) {
                                                  NSDictionary *data = [responseDictionary objectForKey:@"data"];
                                                  
                                                  weakSelf.muArrDataSource = makeTableViewDataSourceWith(data);
                                                  [weakSelf.tbvOrderInfo reloadData];
                                                  
                                                  [weakSelf actionSetTableviewFooterViewWith:data];
                                                  
                                              }
                                              
                                              stopTableViewRefreshAnimation(_tbvOrderInfo);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbvOrderInfo);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(_tbvOrderInfo);
                                          }
                                      showLoading:YES
     ];
    
    
}


-(void)actionSetTableviewFooterViewWith:(NSDictionary *)dict{
    WEAKSELF
    ChooseAddressCustomView *view = getViewByNib(ChooseAddressCustomView, self);
    [view.btn_Ok setTitle:@"再次预约" forState:UIControlStateNormal];
    if ([dict[@"orders_status"] intValue] >= 4) {
        //** 再次预约点击事件
        [view.btn_Ok bk_addEventHandler:^(id sender) {
            
            
        } forControlEvents:UIControlEventTouchUpInside];

    }else{
        [view.btn_Ok setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    [weakSelf.tbvOrderInfo setTableFooterView:view];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"订单信息"];

    [self setupMJTableView];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

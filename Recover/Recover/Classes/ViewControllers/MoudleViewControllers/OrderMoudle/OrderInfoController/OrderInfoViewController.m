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
           OrderInfoKFLogTableViewCell *cell = getDequeueReusableCellWithClass(OrderInfoKFLogTableViewCell);
           [cell setCellData:_muArrDataSource[indexPath.section][indexPath.row]];
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            return size.height = 1;
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
        if (orderData) {
            //** 康复项目
            NSDictionary *dictPorgram = @{@"programs":getValueIfNilReturnStr(orderData[@"programs"]),
                                          @"name":getValueIfNilReturnStr(orderData[@"name"]),
                                          @"amount":getValueIfNilReturnStr(orderData[@"amount"])};
            
            NSString *address = getStringAppendingStr(getValueIfNilReturnStr(orderData[@"province"]), (@[getValueIfNilReturnStr(orderData[@"province"]),getValueIfNilReturnStr(orderData[@"city"]),getValueIfNilReturnStr(orderData[@"area"]),getValueIfNilReturnStr(orderData[@"address"])]));
            
            NSDictionary *dictOrder = @{@"name":getValueIfNilReturnStr(orderData[@"name"]),
                                        @"phone":getValueIfNilReturnStr(orderData[@"phone"]),
                                        @"address":address,
                                        @"desc":getValueIfNilReturnStr(orderData[@"desc"])};
            
            NSDictionary *dictOrderTime = @{@"bh":getValueIfNilReturnStr(orderData[@"bh"]),
                                            @"order_time":getValueIfNilReturnStr(orderData[@"order_time"]), @"start_time":getValueIfNilReturnStr(orderData[@"start_time"])};
            
            NSDictionary *dictKfLog = @{@"title":@"康复日志",
                                            @"content":getValueIfNilReturnStr(orderData[@"doctor_log"])};
            
            
            NSDictionary *dictCommend = @{@"title":@"客户评价",
                                             @"content":getValueIfNilReturnStr(orderData[@"comment"])};
        
            [retArr addObject:dictPorgram];
            [retArr addObject:dictOrder];
            [retArr addObject:dictOrderTime];
            [retArr addObject:dictKfLog];
            [retArr addObject:dictCommend];
            
        }
        
        return retArr;
    };
    
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"order_id":orderID}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"orders/info")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"data"]) {
                                                  NSDictionary *data = [responseDictionary objectForKey:@"data"];
                                                  
                                                  weakSelf.muArrDataSource = makeTableViewDataSourceWith(data);
                                                  [weakSelf.tbvOrderInfo reloadData];
                                                  
                                                  ChooseAddressCustomView *view = getViewByNib(ChooseAddressCustomView, self);
                                                  [view.btn_Ok setTitle:@"再次预约" forState:UIControlStateNormal];
                                                  
                                                  //** 再次预约点击事件
                                                  [view.btn_Ok bk_addEventHandler:^(id sender) {
                                                     
                                                      
                                                  } forControlEvents:UIControlEventTouchUpInside];
                                                  
                                                  
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

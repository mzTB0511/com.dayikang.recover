//
//  MyWalletViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/8.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MyWalletViewTableViewCell.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"
#import "PaymentChooseView.h"
#import "BabysanteAlertView.h"
#import <AlipaySDK/AlipaySDK.h>


@interface MyWalletViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(weak,nonatomic) IBOutlet UITableView *tbvTableView;

@property(nonatomic ,strong) NSMutableArray *muArrDataSource;


@end

@implementation MyWalletViewController


#pragma mark --UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _muArrDataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_muArrDataSource[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 44;
    }
    return 96;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyWalletViewCashOverCell" forIndexPath:indexPath];
            NSDictionary *dictCell = [_muArrDataSource[indexPath.section] objectAtIndex:indexPath.row];
            [cell.textLabel setText:dictCell[@"name"]];
            [cell.detailTextLabel setText:getStringAppendingStr(@"￥", dictCell[@"cash"])];
            return cell;
        }
            
            break;
    }
    
    MyWalletViewTableViewCell *cell = getDequeueReusableCellWithClass(MyWalletViewTableViewCell);
    [cell setCellData:_muArrDataSource[indexPath.section][indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        NSDictionary *dictCard = _muArrDataSource[indexPath.section][indexPath.row];
        [self actionUploadOrderInfoToServer:dictCard];
        
    }

    
}




-(void)actionUploadOrderInfoToServer:(NSDictionary *)data{
    //** 选择支付方式再提交订单
    PaymentChooseView *paymentChooseView = getViewByNib(PaymentChooseView, self);
    PaymentMoudle *payMoudle = [PaymentMoudle new];
    [payMoudle setPayAmont:1];
    [payMoudle setTotalAmount:100];
    [payMoudle setUserPhone:@"15618297762"];
    [paymentChooseView actionSetViewWith:payMoudle ChooseBlock:^(id data) {
       // NSString *payType = [data intValue] == 1 ? @"alipay" : @"chargecard";
       // [_muDictUploadData setObject:payType forKey:@"paytool"];
        
    }];
    
    [BabysanteAlertView BabysanteAlertViewShow:paymentChooseView CancelBtn:@"取消" OtherBtns:@[@"确定"] CalelBlock:^{
        
    } OthersBlock:^(NSInteger btnIndex) {
        [NetworkHandle loadDataFromServerWithParamDic:data
                                              signDic:nil
                                        interfaceName:InterfaceAddressName(@"my/recharge")
                                              success:^(NSDictionary *responseDictionary, NSString *message) {
                                                  //**支付成功确定是否跳转支付宝钱包
                                                  if ([responseDictionary[@"paytool"] isEqualToString:@"alipay"]) {
                                                      //**调用支付宝钱包付款
                                                      NSDictionary *dictSignData = [responseDictionary objectForKey:@"data"];
                                                      
                                                      [[AlipaySDK defaultService] payOrder:dictSignData[@"sign_param"] fromScheme:@"aliypay" callback:^(NSDictionary *resultDic) {
                                                          NSLog(@"reslut = %@",resultDic);
                                                          
                                                      }];
                                                      //** 钱包支付
                                                  }else if ([responseDictionary[@"chargecard"] isEqualToString:@"chargecard"]){
                                                      
                                                  }
                                                  
                                                  
                                                  
                                              }
                                              failure:^{
                                                  
                                              } networkFailure:^{
                                                  
                                              }
                                          showLoading:YES
         ];
    }];
    
    
    
    
    
}


/**
 *  初始化TableView
 *
 *  @param tabelView TableView对象
 */
-(void)setupMjRefreshViewWithTableView:(UITableView *)tabelView{
    
    WEAKSELF
    [tabelView addHeaderWithCallback:^{
        
        [weakSelf getDataSourceFromServer];
    }];
    
    [tabelView addFooterWithCallback:^{
        
        [weakSelf getDataSourceFromServer];
        
    }];
    
    [tabelView headerBeginRefreshing];
}


/**
 *  调用接口请求数据
 *
 *  @param page 当前页码
 */
-(void)getDataSourceFromServer{
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/chargecard")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              [[[_muArrDataSource objectAtIndex:0] objectAtIndex:0] setObject:responseDictionary[@"count_over"] forKey:@"cash"];
                                              
                                              [_muArrDataSource setObject:responseDictionary[@"data"]atIndexedSubscript:1];
                                              
                                              [weakSelf.tbvTableView reloadData];
                                              stopTableViewRefreshAnimation(weakSelf.tbvTableView);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(weakSelf.tbvTableView);
                                          }
                                   networkFailure:^{
                                       stopTableViewRefreshAnimation(weakSelf.tbvTableView);
                                   }
     
                                      showLoading:YES];
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationItem setTitle:@"我的钱包"];
    
    mRegisterNib_TableView(_tbvTableView, MyWalletViewTableViewCell);
    
    _muArrDataSource = [NSMutableArray array];
    NSMutableDictionary *muDish = [NSMutableDictionary dictionaryWithDictionary:@{@"name":@"我的余额",
                                                                                  @"cash":@"0.00"}];
    [_muArrDataSource addObject:@[muDish]];
    
    [self setupMjRefreshViewWithTableView:_tbvTableView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

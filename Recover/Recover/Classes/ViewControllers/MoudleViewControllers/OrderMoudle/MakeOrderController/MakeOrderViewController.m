//
//  MakeOrderViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/23.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MakeOrderViewController.h"
#import "NetworkHandle.h"
#import <BlocksKit/UIControl+BlocksKit.h>

#import "MJRefresh.h"
#import "MakeOrderPuZhuTableViewCell.h"
#import "MakeOrderAddressTableViewCell.h"
#import "MakeOrderAddDescTableViewCell.h"

#import "MyCouponsViewController.h"
#import "ChooseAddressCustomView.h"
#import "BabysanteAlertView.h"
#import "PaymentChooseView.h"
#import <AlipaySDK/AlipaySDK.h>

@interface MakeOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbvOrderInfoView;

@property (strong, nonatomic) NSMutableArray *muArrDataSource;

@property(strong,nonatomic) NSMutableDictionary *muDictUploadData;


@end

@implementation MakeOrderViewController


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        case 1:
        case 4:
        case 5:{
            return 44;
            
        }
            break;
        case 2:{
        
            return 50;
        }
            break;
        case 3:{
            switch (indexPath.row) {
                case 0:{
                   
                    return 44;
                }
                    break;
                case 1:{
                    
                    return 100;
                }
                    break;
                case 2:{
            
                    return 44;
                }
                    break;
            }
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
    WEAKSELF
    switch (indexPath.section) {
        case 0:
        case 1:
        case 4:
        case 5:{
            
            UITableViewCell *cell  = getDequeueReusableCellWithIdentifier(@"MakeOrderCommTableViewCell");
            [cell.textLabel setText:_muArrDataSource[indexPath.section][indexPath.row][@"title"]];
            [cell.detailTextLabel setText:_muArrDataSource[indexPath.section][indexPath.row][@"content"]];
            
            indexPath.section == 4 ? ([cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator]) : nil;
            return cell;
            
        }
            break;
        case 2:{
            MakeOrderPuZhuTableViewCell *cell  = getDequeueReusableCellWithClass(MakeOrderPuZhuTableViewCell);
            [cell setCellData:_muArrDataSource[indexPath.section][indexPath.row]];
            return cell;
        }
            break;
        case 3:{
            switch (indexPath.row) {
                case 0:{
                    UITableViewCell *cell  = getDequeueReusableCellWithIdentifier(@"MakeOrderCommTableViewCell");
                    [cell.textLabel setText:_muArrDataSource[indexPath.section][indexPath.row][@"title"]];
                    [cell.detailTextLabel setText:_muArrDataSource[indexPath.section][indexPath.row][@"content"]];
                    
                    return cell;
                }
                    break;
                case 1:{
                    MakeOrderAddressTableViewCell *cell = getDequeueReusableCellWithClass(MakeOrderAddressTableViewCell);
                    [cell setCellData:_muArrDataSource[indexPath.section][indexPath.row]];
                    
                    return cell;
                }
                    break;
                case 2:{
                    MakeOrderAddDescTableViewCell *cell  = getDequeueReusableCellWithClass(MakeOrderAddDescTableViewCell);
                    [cell actionSetCellData:_muArrDataSource[indexPath.section][indexPath.row][@"content"] CompateBlock:^(NSString *content) {
                    // ** 备注信息
                        [_muArrDataSource[indexPath.section][indexPath.row] setObject:content forKey:@"content"];
                        [weakSelf.tbvOrderInfoView reloadData];
                        //**这只备注内容
                        [_muDictUploadData setObject:content forKey:@"desc"];
                    }];
                    return cell;
                }
                    break;
            }
        }
            break;

    }
    
    return nil;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF
    switch (indexPath.section) {
        case 4:{ // 选择优惠券
                MyCouponsViewController *couponsInfo = getViewControllFromStoryBoard(StoryBoard_MySelf, MyCouponsViewController);
                couponsInfo.viewObject = _muDictUploadData;
            couponsInfo.dataBlock = ^(NSDictionary *data){
              //** 更新选择的优惠券信息
                if (data) {
                    // 计算优惠券抵扣金额
                    CGFloat amount = [_muArrDataSource[indexPath.section][indexPath.row][@"amount"] floatValue];
                    CGFloat sale = [data[@"money"] floatValue];
                    amount = amount - sale;
                    amount = amount > 0 ? amount : 0;
                    [_muDictUploadData setObject:data[@"coupons_id"] forKey:@"coupons_id"];
                    [_muArrDataSource[indexPath.section+1][indexPath.row] setObject:[NSString stringWithFormat:@"%.1f",amount] forKey:@"content"];
                    [_muArrDataSource[indexPath.section][indexPath.row] setObject:data[@"name"] forKey:@"content"];
                    [weakSelf.tbvOrderInfoView reloadData];
                }
              
                
            };
                [self.navigationController pushViewController:couponsInfo animated:YES];
        }
            break;
            
        default:
            break;
    }
    

    
}





-(void)loadDataFromServerWithInfo:(NSDictionary *)data{
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"reservation/prepareorder")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"data"]) {
                                                  NSDictionary *data = [responseDictionary objectForKey:@"data"];
                                                  weakSelf.muArrDataSource = [weakSelf makeTableViewDataSourceWith:data];
                                                  [weakSelf.tbvOrderInfoView reloadData];
                                                  
                                                  ChooseAddressCustomView *view = getViewByNib(ChooseAddressCustomView, self);
                                                  [view.btn_Ok setTitle:@"确认预约" forState:UIControlStateNormal];
                                                  
                                                  //** 确认预约点击事件
                                                  [view.btn_Ok bk_addEventHandler:^(id sender) {
                                                      [weakSelf actionUploadOrderInfoToServer:weakSelf.muDictUploadData];
                                                      
                                                  } forControlEvents:UIControlEventTouchUpInside];
                                                  
                                                 [weakSelf.tbvOrderInfoView setTableFooterView:view];
                                                  
                                              }
                                              
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                              
                                          }
                                      showLoading:YES
     ];
    
    
}



-(NSMutableArray *)makeTableViewDataSourceWith:(NSDictionary *)dict{
    NSMutableArray *muArrRetData = [NSMutableArray array];
    if (dict) {
        // 康复师傅
        [muArrRetData addObject:@[@{@"id":@"",@"title":@"康复治疗师",@"content":dict[@"doctor_name"],@"sel":@"0"}]];
        // 康复项目
        [muArrRetData addObject:@[@{@"id":@"",@"title":@"头颈肩理疗",@"content":dict[@"service_name"],@"sel":@"0"}]];
        // 康复辅助项目
        [muArrRetData addObject:dict[@"service_subs"]];
        
        // 1,预约时间
        NSString *resTime = getStringAppendingStr(dict[@"date"], (@[@" ",dict[@"start_time"],@"-",dict[@"end_time"]]));
        NSDictionary *dictTime = @{@"id":@"",@"title":@"预约实时间",@"content":resTime,@"sel":@"0"};
        // 2.预约地址
        NSString *address = getStringAppendingStr(dict[@"province_name"], (@[dict[@"area_name"],@"  ",dict[@"address"]]));
        NSDictionary *dictAddress = @{@"title":@"预约地址",@"name":dict[@"name"],@"phone":dict[@"phone"],@"address":address};
        // 3.备注
        NSDictionary *dictDesc = @{@"title":@"",@"content":@"",@"sel":@""};
        NSMutableDictionary *muDictDesc = [NSMutableDictionary dictionaryWithDictionary:dictDesc];
        [muArrRetData addObject:@[dictTime,dictAddress,muDictDesc]];
        
        // 优惠券
        NSDictionary *dictYouHui = @{@"title":@"优惠券",@"content":@"请选择",@"sel":@""};
        NSMutableDictionary *muDictYouHui = [NSMutableDictionary dictionaryWithDictionary:dictYouHui];
        [muArrRetData addObject:@[muDictYouHui]];
        
        // Amount
        NSDictionary *dictAmount = @{@"title":@"实际付费",@"content":dict[@"service_price"],@"sel":@""};
        
        NSMutableDictionary *muAmountHui = [NSMutableDictionary dictionaryWithDictionary:dictAmount];
        [muArrRetData addObject:@[muAmountHui]];
        
        //**记录应付费用
         [_muDictUploadData setObject:dict[@"service_price"] forKey:@"amount"];
        
        
    }
    
    return muArrRetData;
}


-(void)actionUploadOrderInfoToServer:(NSDictionary *)data{
    WEAKSELF
    //** 选择支付方式再提交订单
    PaymentChooseView *paymentChooseView = getViewByNib(PaymentChooseView, self);
    PaymentMoudle *payMoudle = [PaymentMoudle new];
    [payMoudle setPayAmont:1];
    [payMoudle setTotalAmount:100];
    [payMoudle setUserPhone:@"15618297762"];
    [paymentChooseView actionSetViewWith:payMoudle ChooseBlock:^(id data) {
       NSString *payType = [data intValue] == 1 ? @"alipay" : @"chargecard";
        [_muDictUploadData setObject:payType forKey:@"paytool"];
        
    }];

    [BabysanteAlertView BabysanteAlertViewShow:paymentChooseView CancelBtn:@"取消" OtherBtns:@[@"确定"] CalelBlock:^{
        
    } OthersBlock:^(NSInteger btnIndex) {
        [NetworkHandle loadDataFromServerWithParamDic:data
                                              signDic:nil
                                        interfaceName:InterfaceAddressName(@"reservation/makeorder")
                                              success:^(NSDictionary *responseDictionary, NSString *message) {
                                                  //**支付成功确定是否跳转支付宝钱包
                                                  if ([responseDictionary[@"paytool"] isEqualToString:@"alipay"]) {
                                                      //**调用支付宝钱包付款
                                                      NSDictionary *dictSignData = [responseDictionary objectForKey:@"data"];
                                                      
                                                      [[AlipaySDK defaultService] payOrder:dictSignData[@"sign_param"] fromScheme:@"aliypay" callback:^(NSDictionary *resultDic) {
                                                          NSLog(@"reslut = %@",resultDic);
                                                          //** 支付成功后跳转到 订单页面
                                                          if (resultDic[@"ResultStatus"]) {
                                                              if ([resultDic[@"resultDic"] intValue] == 9000) {
                                                                  [CommonHUD showHudWithMessage:@"支付成功" delay:1.0 completion:^{
                                                                      [weakSelf.navigationController popToRootViewControllerAnimated:NO];
                                                                      UITabBarController *bar = [CommonUser mainTabBarViewController];
                                                                      [bar setSelectedIndex:1];
                                                                      
                                                                  }];
                                                              }
                                                          }
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"订单确认"];
    
    mRegisterNib_TableView(_tbvOrderInfoView, MakeOrderAddDescTableViewCell);
    mRegisterNib_TableView(_tbvOrderInfoView, MakeOrderAddressTableViewCell);
    mRegisterNib_TableView(_tbvOrderInfoView, MakeOrderPuZhuTableViewCell);
    
    _muDictUploadData = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)self.viewObject];
    
    [self loadDataFromServerWithInfo:_muDictUploadData];
    
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

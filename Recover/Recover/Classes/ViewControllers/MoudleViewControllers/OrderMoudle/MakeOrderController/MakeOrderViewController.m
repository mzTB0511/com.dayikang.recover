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

@interface MakeOrderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbvOrderInfoView;

@property (strong, nonatomic) NSMutableArray *muArrDataSource;


@end

@implementation MakeOrderViewController


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _muArrDataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_muArrDataSource[section] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        case 1:
        case 4:
        case 5:{
            
            UITableViewCell *cell  = getDequeueReusableCellWithIdentifier(@"MakeOrderCommTableViewCell");
            [cell.textLabel setText:_muArrDataSource[indexPath.section][@""]];
            [cell.detailTextLabel setText:_muArrDataSource[indexPath.section][@""]];
            
            indexPath.section == 4 ? ([cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator]) : nil;
            return cell;
            
        }
            break;
        case 2:{
            MakeOrderPuZhuTableViewCell *cell  = getDequeueReusableCellWithClass(@"MakeOrderPuZhuTableViewCell");
            
            return cell;
        }
            break;
        case 3:{
            switch (indexPath.row) {
                case 0:{
                    UITableViewCell *cell  = getDequeueReusableCellWithIdentifier(@"MakeOrderCommTableViewCell");
                    [cell.textLabel setText:_muArrDataSource[indexPath.section][@""]];
                    [cell.detailTextLabel setText:_muArrDataSource[indexPath.section][@""]];
                    
                    return cell;
                }
                    break;
                case 1:{
                    MakeOrderAddressTableViewCell *cell  = getDequeueReusableCellWithClass(@"MakeOrderAddressTableViewCell");
                    
                    return cell;
                }
                    break;
                case 2:{
                    MakeOrderAddDescTableViewCell *cell  = getDequeueReusableCellWithClass(@"MakeOrderAddDescTableViewCell");
                    
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
    
    switch (indexPath.section) {
        case 4:{ // 选择优惠券
            
        }
            break;
            
        default:
            break;
    }
    
//    DoctorCommendViewController *recommendInfo = getViewControllFromStoryBoard(StoryBoard_Doctor, DoctorCommendViewController);
//    recommendInfo.viewObject = (NSString *)self.viewObject;
//    [self.navigationController pushViewController:recommendInfo animated:YES];
    
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
        [muArrRetData addObject:@[@{@"id":@"",@"title":@"头颈肩理疗",@"content":dict[@"doctor_name"],@"sel":@"0"}]];
        // 康复辅助项目
        [muArrRetData addObject:dict[@"service_subs"]];
        
        // 1,预约时间
        NSString *resTime = getStringAppendingStr(dict[@"date"], (@[dict[@"doctor_name"],@" ",dict[@"start_time"],@"-",dict[@"end_time"]]));
        NSDictionary *dictTime = @{@"id":@"",@"title":@"预约实时间",@"content":resTime,@"sel":@"0"};
        // 2.预约地址
        NSString *address = getStringAppendingStr(dict[@"province_name"], (@[dict[@"area_name"],@"  ",dict[@"address"]]));
        NSDictionary *dictAddress = @{@"title":@"预约地址",@"name":@"",@"phone":@"",@"address":address};
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
        
    }
    
    return muArrRetData;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"康复治疗师详情"];
    
    mRegisterNib_TableView(_tbvOrderInfoView, MakeOrderAddDescTableViewCell);
    mRegisterNib_TableView(_tbvOrderInfoView, MakeOrderAddressTableViewCell);
    mRegisterNib_TableView(_tbvOrderInfoView, MakeOrderPuZhuTableViewCell);
    
    [self loadDataFromServerWithInfo:(NSString *)self.viewObject];
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
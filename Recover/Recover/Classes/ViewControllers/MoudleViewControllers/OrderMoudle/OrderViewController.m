//
//  OrderViewController.m
//  Recover
//
//  Created by 刘轩 on 15/8/31.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "OrderViewController.h"
#import "MJRefresh.h"
#import "NetworkHandle.h"
#import "OrderListTableViewCell.h"


@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *tbv_OrderListView;

@property(strong,nonatomic) NSMutableArray *muArr_OrderList;


@end

@implementation OrderViewController

#pragma mark --UITabelVeiwDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _muArr_OrderList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListTableViewCell *cell = getDequeueReusableCellWithClass(OrderListTableViewCell);
    
    [cell setCellData:_muArr_OrderList[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


-(void)setupMJTableView{
   WEAKSELF
    [_tbv_OrderListView addHeaderWithCallback:^{
        pageIndex = 1;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchType:0];
    }];
    
    
    [_tbv_OrderListView addFooterWithCallback:^{
        pageIndex++;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchType:0];
    }];
    
    
    [_tbv_OrderListView headerBeginRefreshing];
}


-(void)reloadTableViewWithPage:(NSInteger)page AndSearchType:(NSInteger)searchType{
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"orders/list")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"list"]) {
                                                  NSArray *data = [responseDictionary objectForKey:@"list"];
                                                 
                                                  page == 1 ? [weakSelf.muArr_OrderList removeAllObjects]: nil;
                                                 
                                                  data.count > 0 ? [weakSelf.muArr_OrderList addObjectsFromArray:data] : nil;
                                                
                                                  weakSelf.muArr_OrderList.count == 0 ?
                                                  [self setEmptyRemindImageWithRes:@""] : [self removeEmptyRemindImage];
                                                 
                                              }
                                              
                                            stopTableViewRefreshAnimation(_tbv_OrderListView);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbv_OrderListView);
                                          } networkFailure:^{
                                             stopTableViewRefreshAnimation(_tbv_OrderListView);
                                          }
                                      showLoading:YES
     ];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单";

    mRegisterNib_TableView(_tbv_OrderListView, OrderListTableViewCell);
   
    _muArr_OrderList = [NSMutableArray array];
    
    [self setupMJTableView];
    

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

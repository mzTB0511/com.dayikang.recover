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

@interface MyWalletViewController ()

@property(weak,nonatomic) IBOutlet UITableView *tbvTableView;

@property(nonatomic ,strong) NSMutableArray *muArrDataSource;


@end

@implementation MyWalletViewController


#pragma mark --UITableViewDelegate
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
                                              
                                              [_muArrDataSource setObject:@[responseDictionary[@"data"]] atIndexedSubscript:1];
                                              
                                              [weakSelf.tbvTableView reloadData];
                                              stopTableViewRefreshAnimation(_tbvTableView);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(_tbvTableView);
                                          }
                                   networkFailure:^{
                                       stopTableViewRefreshAnimation(_tbvTableView);
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

//
//  MyCouponsViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/8.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyCouponsViewController.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"
#import "MyCouponsTableViewCell.h"

@interface MyCouponsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageIndex;
}
@property(weak,nonatomic) IBOutlet UITableView *tbvTableView;

@property(nonatomic ,strong) NSMutableArray *muArrDataSource;



@end

@implementation MyCouponsViewController


#pragma mark --UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _muArrDataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我的优惠券"];
    // Do any additional setup after loading the view.
    [self setupMjRefreshViewWithTableView:_tbvTableView];
    
    
}


/**
 *  初始化TableView
 *
 *  @param tabelView TableView对象
 */
-(void)setupMjRefreshViewWithTableView:(UITableView *)tabelView{
    
    WEAKSELF
    [tabelView addHeaderWithCallback:^{
        pageIndex = 1;
        [weakSelf getDataSourceFromServerWithPageIndex:pageIndex];
    }];
    
    [tabelView addFooterWithCallback:^{
        pageIndex ++;
        [weakSelf getDataSourceFromServerWithPageIndex:pageIndex];
        
    }];
    
    [tabelView headerBeginRefreshing];
}


/**
 *  调用接口请求数据
 *
 *  @param page 当前页码
 */
-(void)getDataSourceFromServerWithPageIndex:(NSInteger)page{
    
     [NetworkHandle loadDataFromServerWithParamDic:nil
                                           signDic:nil
                                     interfaceName:InterfaceAddressName(@"")
                                           success:^(NSDictionary *responseDictionary, NSString *message) {
                                           
                                              
                                               
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

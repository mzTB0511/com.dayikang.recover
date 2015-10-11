//
//  MyFavouriteViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/8.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyFavouriteViewController.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"
#import "DoctorListTableViewCell.h"
#import "DoctorInfoViewController.h"
#import <BlocksKit/UIControl+BlocksKit.h>
#import "ReservationInfoViewController.h"
#import "ReservationViewController.h"
#import "BaseNavigationViewController.h"


@interface MyFavouriteViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageIndex;
}
@property(weak,nonatomic) IBOutlet UITableView *tbvTableView;

@property(nonatomic ,strong) NSMutableArray *muArrDoctorList;



@end

@implementation MyFavouriteViewController



#pragma mark --UITabelVeiwDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _muArrDoctorList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DoctorListTableViewCell *cell = getDequeueReusableCellWithClass(DoctorListTableViewCell);
    
    [cell setCellData:_muArrDoctorList[indexPath.row]];
    
    WEAKSELF
    //** 添加点击回调事件
    cell.doctorListCellBlock = ^(){
      //**去预约订单 页面
        ReservationViewController *reservationInfoView = getViewControllFromStoryBoard(StoryBoard_Main, ReservationViewController);
        [reservationInfoView setViewObject:@{@"sid":@"0",@"did":_muArrDoctorList[indexPath.row][@"did"]}];
        [reservationInfoView actionShowDismissButton];
        reservationInfoView.block = ^(NSString *service){
            //** 选中后回调事件
            NSMutableDictionary *dictDoctro = [NSMutableDictionary dictionaryWithDictionary:_muArrDoctorList[indexPath.row]] ;
            [dictDoctro setObject:service forKey:@"sid"];
            pushViewControllerWith(StoryBoard_Reservation, ReservationInfoViewController, (@{ViewName:@"收藏",PassObj:dictDoctro}));
        };
        
        BaseNavigationViewController *navBase = getViewControllFromStoryBoard(StoryBoard_LoginRegsiter, BaseNavigationViewController);
        navBase.viewControllers = @[reservationInfoView];
        [weakSelf presentViewController:navBase animated:YES completion:nil];
        
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  WEAKSELF
    DoctorInfoViewController *doctorInfo = getViewControllFromStoryBoard(StoryBoard_Doctor, DoctorInfoViewController);
    doctorInfo.viewObject = @{ViewName:@"收藏",PassObj:_muArrDoctorList[indexPath.row][@"did"]} ;
    doctorInfo.doctorInfoBlock = ^(NSDictionary *docInfo){
      //**去预约订单 页面
        ReservationViewController *reservationInfoView = getViewControllFromStoryBoard(StoryBoard_Main, ReservationViewController);
        [reservationInfoView setViewObject:@{@"sid":@"0",@"did":docInfo[@"did"]}];
        [reservationInfoView actionShowDismissButton];
        reservationInfoView.block = ^(NSString *service){
            //** 选中后回调事件
            NSMutableDictionary *dictDoctro = [NSMutableDictionary dictionaryWithDictionary:_muArrDoctorList[indexPath.row]] ;
            [dictDoctro setObject:service forKey:@"sid"];
            pushViewControllerWith(StoryBoard_Reservation, ReservationInfoViewController, (@{ViewName:@"收藏",PassObj:dictDoctro}));
        };
        BaseNavigationViewController *navBase = getViewControllFromStoryBoard(StoryBoard_LoginRegsiter, BaseNavigationViewController);
        navBase.viewControllers = @[reservationInfoView];
        [weakSelf presentViewController:navBase animated:YES completion:nil];
    };
    [self.navigationController pushViewController:doctorInfo animated:YES];
    
    
}


-(void)setupMJTableView{
    WEAKSELF
    [_tbvTableView addHeaderWithCallback:^{
        pageIndex = 1;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchCondation:nil];
    }];
    
/*  屏蔽上提加载功能
    [_tbvTableView addFooterWithCallback:^{
        pageIndex++;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchCondation:nil];
    }];
*/
    
    [_tbvTableView headerBeginRefreshing];
}


-(void)reloadTableViewWithPage:(NSInteger)page AndSearchCondation:(NSDictionary *)condation{
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/favourite")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"data"]) {
                                                  NSArray *data = [responseDictionary objectForKey:@"data"];
                                                  
                                                  page == 1 ? [weakSelf.muArrDoctorList removeAllObjects]: nil;
                                                  
                                                  data.count > 0 ? [weakSelf.muArrDoctorList addObjectsFromArray:data] : nil;
                                                  
                                                  weakSelf.muArrDoctorList.count == 0 ?
                                                  [self setEmptyRemindImageWithRes:@""] : [self removeEmptyRemindImage];
                                                  
                                                  [weakSelf.tbvTableView reloadData];
                                              }
                                              
                                              stopTableViewRefreshAnimation(weakSelf.tbvTableView);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(weakSelf.tbvTableView);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(weakSelf.tbvTableView);
                                          }
                                      showLoading:YES
     ];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我的收藏"];
    // Do any additional setup after loading the view.
    
    mRegisterNib_TableView(_tbvTableView, DoctorListTableViewCell);
    setTableViewFooterView(_tbvTableView);
    _muArrDoctorList = [NSMutableArray array];
    [self setupMJTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     setTableViewCellDeselect(_tbvTableView);
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

//
//  MyDoctorsViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/8.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyDoctorsViewController.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"
#import "DoctorListTableViewCell.h"
#import "DoctorInfoViewController.h"
#import <BlocksKit/UIControl+BlocksKit.h>


@interface MyDoctorsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageIndex;
    
    NSInteger viewType;
}
@property(weak,nonatomic) IBOutlet UITableView *tbvTableView;

@property(nonatomic ,strong) NSMutableArray *muArrDoctorList;


@end

@implementation MyDoctorsViewController



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
    
    //** 添加点击回调事件
    [cell.btnReservation bk_addEventHandler:^(id sender) {
        //        if (self.doctorViewBlock) {
        //            self.doctorViewBlock(_muArrDoctorList[indexPath.row]);
        //            [self.navigationController popViewControllerAnimated:YES];
        //        }
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF
    DoctorInfoViewController *doctorInfo = getViewControllFromStoryBoard(StoryBoard_Doctor, DoctorInfoViewController);
    doctorInfo.doctorInfoBlock = ^(NSDictionary *docInfo){
        
        //        if (weakSelf.doctorViewBlock) {
        //            weakSelf.doctorViewBlock(docInfo);
        //            [self.navigationController popToRootViewControllerAnimated:YES];
        //        }
        
    };
    [self.navigationController pushViewController:doctorInfo animated:YES];
    
}


-(void)setupMJTableView{
    WEAKSELF
    [_tbvTableView addHeaderWithCallback:^{
        pageIndex = 1;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchCondation:nil];
    }];
    
    
    [_tbvTableView addFooterWithCallback:^{
        pageIndex++;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchCondation:nil];
    }];
    
    
    [_tbvTableView headerBeginRefreshing];
}


-(void)reloadTableViewWithPage:(NSInteger)page AndSearchCondation:(NSDictionary *)condation{
    NSString *interfaceName = viewType == 1 ? InterfaceAddressName(@"my/favourite") : InterfaceAddressName(@"my/doctors");
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:interfaceName
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"list"]) {
                                                  NSArray *data = [responseDictionary objectForKey:@"list"];
                                                  
                                                  page == 1 ? [weakSelf.muArrDoctorList removeAllObjects]: nil;
                                                  
                                                  data.count > 0 ? [weakSelf.muArrDoctorList addObjectsFromArray:data] : nil;
                                                  
                                                  weakSelf.muArrDoctorList.count == 0 ?
                                                  [self setEmptyRemindImageWithRes:@""] : [self removeEmptyRemindImage];
                                                  
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
    
    viewType = [(NSString *)self.viewObject intValue];
    NSString *viewTitle =  viewType == 1 ? @"我的收藏" : @"我的康复师";
    [self.navigationItem setTitle:viewTitle];
    
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

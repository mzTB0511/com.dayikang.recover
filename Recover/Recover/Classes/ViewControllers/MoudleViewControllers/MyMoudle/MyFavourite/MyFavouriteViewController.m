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
    
    //** 添加点击回调事件

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
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/favourite")
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
    [self.navigationItem setTitle:@"我的收藏"];
    // Do any additional setup after loading the view.
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

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
#import "BabysanteSegmentView.h"
#import <BlocksKit/UIControl+BlocksKit.h>
#import "AddDoctorCommendViewController.h"
#import "OrderInfoViewController.h"
#import "ReservationViewController.h"
#import "ReservationInfoViewController.h"
#import "BaseNavigationViewController.h"

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageIndex;
    NSInteger chooseType;
}

@property (weak, nonatomic) IBOutlet UITableView *tbv_OrderListView;

@property(strong,nonatomic) NSMutableArray *muArr_OrderList;

@property (weak, nonatomic) IBOutlet UIView *vSegmentView;

/**
 *  SegmentView
 */
@property(nonatomic,strong)BabysanteSegment *babysanteView;

@property(nonatomic,strong)UIView *vHideView;

@end

@implementation OrderViewController

#pragma mark --UITabelVeiwDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 174;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _muArr_OrderList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF
    OrderListTableViewCell *cell = getDequeueReusableCellWithClass(OrderListTableViewCell);
    
    [cell actionSetCellData:_muArr_OrderList[indexPath.row] WithType:chooseType CompleateBlock:^{
        //确认服务，去评价，再次预约
        NSInteger orderStatus = [_muArr_OrderList[indexPath.row][@"orders_status"] intValue];
        switch (orderStatus) {
            case 3:{// 确认服务
                [weakSelf actionConfirmServiceWithOrder:[_muArr_OrderList[indexPath.row] objectForKey:@"orders_id"] AndStatus:@"4"];
                [weakSelf.tbv_OrderListView headerBeginRefreshing];
            }
                break;
            case 4:{// 去评价
                pushViewControllerWith(StoryBoard_Doctor, AddDoctorCommendViewController, (_muArr_OrderList[indexPath.row]));
            }
                break;
            case 5:// 再次预约
            case 6:{// 再次预约

                    //**去预约订单 页面
                    ReservationViewController *reservationInfoView = getViewControllFromStoryBoard(StoryBoard_Main, ReservationViewController);
                    [reservationInfoView setViewObject:@{@"sid":@"0",@"did":_muArr_OrderList[indexPath.row][@"doctor_id"]}];
                    [reservationInfoView actionShowDismissButton];
                    reservationInfoView.block = ^(NSString *service){
                        //** 选中后回调事件
                        NSMutableDictionary *dictDoctro = [NSMutableDictionary dictionaryWithDictionary:@{@"did":_muArr_OrderList[indexPath.row][@"doctor_id"],
                                                                                                                  @"name":_muArr_OrderList[indexPath.row][@"doctor_name"],
                                                                                                                  @"sid":service}] ;
                        pushViewControllerWith(StoryBoard_Reservation, ReservationInfoViewController, (@{ViewName:@"订单",PassObj:dictDoctro}));
                    };
                    
                    BaseNavigationViewController *navBase = getViewControllFromStoryBoard(StoryBoard_LoginRegsiter, BaseNavigationViewController);
                    navBase.viewControllers = @[reservationInfoView];
                    [weakSelf presentViewController:navBase animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    } AndCommendBlock:^{
         pushViewControllerWith(StoryBoard_Doctor, AddDoctorCommendViewController, (_muArr_OrderList[indexPath.row]));
    }];
   
    
  /*
    
    [cell.btn_ReservationStatus bk_addEventHandler:^(id sender) {
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    // ** 去评价
    [cell.btnCommend bk_addEventHandler:^(id sender) {
       
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    */
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    pushViewControllerWith(StoryBoard_Order, OrderInfoViewController, _muArr_OrderList[indexPath.row][@"orders_id"])
}



-(void)setupMJTableView{
   WEAKSELF
    [_tbv_OrderListView addHeaderWithCallback:^{
        pageIndex = 1;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchType:0];
    }];
    
   /*  暂时屏蔽上提加载
    [_tbv_OrderListView addFooterWithCallback:^{
        pageIndex++;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchType:0];
    }];
    
    */
    [_tbv_OrderListView headerBeginRefreshing];
}


-(void)reloadTableViewWithPage:(NSInteger)page AndSearchType:(NSInteger)searchType{
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:@{@"search_type":[NSString stringWithFormat:@"%li",(long)searchType]}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"orders/list")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"data"]) {
                                                  NSArray *data = [responseDictionary objectForKey:@"data"];
                                                 
                                                  page == 1 ? [weakSelf.muArr_OrderList removeAllObjects]: nil;
                                                 
                                                  data.count > 0 ? [weakSelf.muArr_OrderList addObjectsFromArray:data] : nil;
                                                
                                                  weakSelf.muArr_OrderList.count == 0 ?
                                                  [self setEmptyRemindImageWithRes:@""] : [self removeEmptyRemindImage];
                                                 
                                                  [weakSelf.tbv_OrderListView reloadData];
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


/**
 *  更改订单状态
 *
 *  @param orderID dangdangID
 *  @param status  更改后的状态
 */
-(void)actionConfirmServiceWithOrder:(NSString *)orderID AndStatus:(NSString *)status{
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:@{@"orders_id":orderID,
                                                    @"goto_status":status}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"orders/updatestatus")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              [weakSelf.tbv_OrderListView reloadData];
                                          }
                                          failure:nil networkFailure:nil
                                      showLoading:YES
     ];
}



/**
 *  初始化SegmentBarView
 */
-(void)initBabysatneSegMentView{
    
    _vHideView = [UIView new];
    [_vHideView setBackgroundColor:[UIColor blackColor]];
    _vHideView.alpha = 1;
    
    MenuMoudle *menuMoudle = [MenuMoudle new];
    [menuMoudle setItemColor:[UIColor blackColor]];
    [menuMoudle setItemSelColor:mColorWithRGB(48,154,161)];
    [menuMoudle setSegmentBgColor:mColorWithRGB(232,232,232)];
    
    
    SegmentItem *segItem1 = [SegmentItem new];
    [segItem1 setMenuID:@"1"];
    [segItem1 setName:@"进行中"];
    [segItem1 setHasSubItem:NO];
    
    SegmentItem *segItem2 = [SegmentItem new];
    [segItem2 setMenuID:@"2"];
    [segItem2 setName:@"已完成康复师日志"];
    [segItem2 setHasSubItem:NO];
    
    /**
     *  处理二级视图下拉动画,遮罩层事件
     *
     *  @param UIView 菜单视图
     *  @param BOOL   是否要执行下拉
     *
     *  @return nil
     */
    void(^animationSubMenu)(UIView *,BOOL) = ^(UIView *subMenuView,BOOL dropDown){
        CGFloat segSubMenuH = 0;
        segSubMenuH = dropDown ? 88 : 44;
        [UIView animateWithDuration:0.5f animations:^{
            
            [subMenuView setFrame:CGRectMake(0, 0, mScreen_Width, segSubMenuH)];
            
        } completion:^(BOOL finished) {
            
            if (dropDown) {
                // 初始化遮罩层
                if (![_vHideView superview]) {
                    [_vHideView setFrame:CGRectMake(0, 44 , mScreen_Width, mScreen_Height - 44)];
                    [self.view addSubview:_vHideView];
                    [self.view bringSubviewToFront:_babysanteView];
                }
                
                [UIView animateWithDuration:0.5f animations:^{
                    [_vHideView setAlpha:0.1];
                } completion:nil];
            }else{
                [UIView animateWithDuration:0.5f animations:^{
                    [_vHideView setAlpha:0];
                } completion:^(BOOL finished) {
                    [_vHideView removeFromSuperview];
                }];
                
            }
            
        }];
    };
    
    
    _babysanteView = [[BabysanteSegment alloc] initBabysanteSegmentViewFrame:CGRectMake(0, 0, mScreen_Width, 43) MenuMoudle:menuMoudle AndMenuItems:@[segItem1,segItem2] WithBabysanteSegmentBlock:^(NSString *menuIndex, NSString *subMenuIndex) {
        
        if ([menuIndex isEqualToString:@""] && [subMenuIndex isEqualToString:@""] ) {
            // ** 有二级子项菜单 下拉二级菜单
           // animationSubMenu(_babysanteView,YES);
            
        }else if (![menuIndex isEqualToString:@""] && ![subMenuIndex isEqualToString:@""]){
            //** 当前选中子项菜单 。进行数据筛选
           // animationSubMenu(_babysanteView,NO);
        }else{
            //** 没有二级子项菜单 根据一级菜单过滤数据
            animationSubMenu(_babysanteView,NO);
            pageIndex = 1;
            chooseType = [menuIndex integerValue];
            [self reloadTableViewWithPage:pageIndex AndSearchType:[menuIndex integerValue]];
        }
        
        
    }];

    [_babysanteView setDefaultSecItem:segItem1];
    [self.view addSubview:_babysanteView];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单";

    mRegisterNib_TableView(_tbv_OrderListView, OrderListTableViewCell);
   
    _muArr_OrderList = [NSMutableArray array];

    [self initBabysatneSegMentView];
    
    [self setupMJTableView];
    
  //  _tbv_OrderListView.tableHeaderView = [UIView new];
    
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

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

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageIndex;
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


/**
 *  初始化SegmentBarView
 */
-(void)initBabysatneSegMentView{
    
    _vHideView = [UIView new];
    [_vHideView setBackgroundColor:[UIColor blackColor]];
    _vHideView.alpha = 0;
    
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
    [segItem2 setName:@"已完成"];
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
            animationSubMenu(_babysanteView,YES);
            
        }else if (![menuIndex isEqualToString:@""] && ![subMenuIndex isEqualToString:@""]){
            //** 当前选中子项菜单 。进行数据筛选
            animationSubMenu(_babysanteView,NO);
        }else{
            //** 没有二级子项菜单 根据一级菜单过滤数据
            animationSubMenu(_babysanteView,NO);
            
            [self reloadTableViewWithPage:pageIndex AndSearchType:[menuIndex integerValue]];
        }
        
        
    }];

    [self.vSegmentView addSubview:_babysanteView];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单";

    mRegisterNib_TableView(_tbv_OrderListView, OrderListTableViewCell);
   
    _muArr_OrderList = [NSMutableArray array];
    
    [self initBabysatneSegMentView];
    
    [self setupMJTableView];
    
    _tbv_OrderListView.tableHeaderView = [UIView new];
    
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

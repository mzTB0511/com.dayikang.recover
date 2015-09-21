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
#import "BabysanteSegmentView.h"


@interface MyCouponsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageIndex;
}
@property(weak,nonatomic) IBOutlet UITableView *tbvTableView;

@property(nonatomic ,strong) NSMutableArray *muArrDataSource;

@property(nonatomic ,strong) NSMutableDictionary *muDictPostData;


/**
 *  SegmentView
 */
@property(nonatomic,strong)BabysanteSegment *babysanteView;

@property(nonatomic,strong)UIView *vHideView;



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
    return 96;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCouponsTableViewCell *cell = getDequeueReusableCellWithClass(MyCouponsTableViewCell);
    [cell setCellData:_muArrDataSource[indexPath.row]];
    
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

        [weakSelf getDataSourceFromServerWithPageIndex:_muDictPostData];
    }];
    
    [tabelView addFooterWithCallback:^{
    
        [weakSelf getDataSourceFromServerWithPageIndex:_muDictPostData];
        
    }];
    
    //  [tabelView headerBeginRefreshing];
}


/**
 *  调用接口请求数据
 *
 *  @param page 当前页码
 */
-(void)getDataSourceFromServerWithPageIndex:(NSDictionary *)dict{
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:dict
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/coupons")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              _muArrDataSource = [NSMutableArray arrayWithArray:responseDictionary[@"data"]];
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
    [segItem1 setName:@"未使用"];
    [segItem1 setHasSubItem:NO];
    
    SegmentItem *segItem2 = [SegmentItem new];
    [segItem2 setMenuID:@"2"];
    [segItem2 setName:@"已失效"];
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
    
    WEAKSELF
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
            [_muDictPostData setObject:menuIndex forKey:@"type"];
            [weakSelf getDataSourceFromServerWithPageIndex:_muDictPostData];
        }
        
        
    }];
    
    [_babysanteView setDefaultSecItem:segItem1];
    [self.view addSubview:_babysanteView];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我的优惠券"];
    // Do any additional setup after loading the view.
    mRegisterNib_TableView(_tbvTableView, MyCouponsTableViewCell);
    
    _muDictPostData = [NSMutableDictionary dictionary];
    [_muDictPostData setObject:@"0" forKey:@"type"];
    NSString *serviceItem = (NSString *)self.viewObject ? (NSString *)self.viewObject : @"";
    [_muDictPostData setObject:serviceItem forKey:@"service_id"];
 
    [self initBabysatneSegMentView];
    
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

//
//  DoctorCommendViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/19.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "DoctorCommendViewController.h"
#import "DoctorCommendTableViewCell.h"
#import "MJRefresh.h"
#import "NetworkHandle.h"
#import "BabysanteSegmentView.h"


@interface DoctorCommendViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *tbvCommendView;

@property(strong,nonatomic) NSMutableArray *muArrDataSource;

@property(strong,nonatomic) NSMutableDictionary *muDictCondation;


/**
 *  SegmentView
 */
@property(nonatomic,strong)BabysanteSegment *babysanteView;

@property(nonatomic,strong)UIView *vHideView;


@end

@implementation DoctorCommendViewController


#pragma mark --UITabelVeiwDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DoctorCommendTableViewCell *cell = getDequeueReusableCellWithClass(DoctorCommendTableViewCell);
    
    [cell setCellData:_muArrDataSource[indexPath.row]];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    if (size.height < 68) {
        return 68;
    }
    return size.height + 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _muArrDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DoctorCommendTableViewCell *cell = getDequeueReusableCellWithClass(DoctorCommendTableViewCell);
    
    [cell setCellData:_muArrDataSource[indexPath.row]];
    
    return cell;
}



-(void)setupMJTableView{
    WEAKSELF
    [_tbvCommendView addHeaderWithCallback:^{
        pageIndex = 1;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchCondation:_muDictCondation];
    }];
    
    
    [_tbvCommendView addFooterWithCallback:^{
        pageIndex++;
        [weakSelf reloadTableViewWithPage:pageIndex AndSearchCondation:_muDictCondation];
    }];
    
    
    [_tbvCommendView headerBeginRefreshing];
}


-(void)reloadTableViewWithPage:(NSInteger)page AndSearchCondation:(NSDictionary *)condation{
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:condation
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"doctor/commentlist")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"list"]) {
                                                  NSArray *data = [responseDictionary objectForKey:@"list"];
                                                  
                                                  page == 1 ? [weakSelf.muArrDataSource removeAllObjects]: nil;
                                                  
                                                  data.count > 0 ? [weakSelf.muArrDataSource addObjectsFromArray:data] : nil;
                                                  
                                                  weakSelf.muArrDataSource.count == 0 ?
                                                  [self setEmptyRemindImageWithRes:@""] : [self removeEmptyRemindImage];
                                                  
                                              }
                                              
                                              stopTableViewRefreshAnimation(weakSelf.tbvCommendView);
                                          }
                                          failure:^{
                                              stopTableViewRefreshAnimation(weakSelf.tbvCommendView);
                                          } networkFailure:^{
                                              stopTableViewRefreshAnimation(weakSelf.tbvCommendView);
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
    [segItem1 setName:@"非常满意"];
    [segItem1 setHasSubItem:NO];
    
    SegmentItem *segItem2 = [SegmentItem new];
    [segItem2 setMenuID:@"2"];
    [segItem2 setName:@"满意"];

    
    
    SegmentItem *segItem3 = [SegmentItem new];
    [segItem3 setMenuID:@"3"];
    [segItem3 setName:@"比较满意"];
 
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
    
    
    _babysanteView = [[BabysanteSegment alloc] initBabysanteSegmentViewFrame:CGRectMake(0, 0, mScreen_Width, 43) MenuMoudle:menuMoudle AndMenuItems:@[segItem1,segItem2,segItem3] WithBabysanteSegmentBlock:^(NSString *menuIndex, NSString *subMenuIndex) {
        
        if ([menuIndex isEqualToString:@""] && [subMenuIndex isEqualToString:@""] ) {
            // ** 有二级子项菜单 下拉二级菜单
            animationSubMenu(_babysanteView,YES);
            return ;
        }else if (![menuIndex isEqualToString:@""] && ![subMenuIndex isEqualToString:@""]){
            //** 当前选中子项菜单 。进行数据筛选
            animationSubMenu(_babysanteView,NO);
            
        }else{
            //** 没有二级子项菜单 根据一级菜单过滤数据
            animationSubMenu(_babysanteView,NO);
            pageIndex = 1;
            [_muDictCondation setObject:menuIndex forKey:@"type"];
        }
        
        [self reloadTableViewWithPage:pageIndex AndSearchCondation:_muDictCondation];
    }];
    
    [_babysanteView setDefaultSecItem:segItem1];
    
    [self.view addSubview:_babysanteView];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"顾客评价";
    
    mRegisterNib_TableView(_tbvCommendView, DoctorCommendTableViewCell);
    
    _muArrDataSource = [NSMutableArray array];
   
    _muDictCondation = [NSMutableDictionary dictionary];
    [_muDictCondation setObject:@"1" forKey:@"type"];
    [_muDictCondation setObject:(NSString *)self.viewObject forKey:@"doctor_id"];
    [_muDictCondation setObject:@"1" forKey:@"page"];
    
    [self initBabysatneSegMentView];
    
    [self setupMJTableView];
    
    _tbvCommendView.tableHeaderView = [UIView new];
    
    
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

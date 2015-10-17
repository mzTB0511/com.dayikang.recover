//
//  IndexViewController.m
//  Recover
//
//  Created by 刘轩 on 15/8/31.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "IndexViewController.h"
#import "NetworkHandle.h"
#import "CommonWebView.h"
#import "LXCycleScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ServiceItemCollectionViewCell.h"
#import <BlocksKit/UIView+BlocksKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "ReservationInfoViewController.h"
#import "ReservationViewController.h"
#import "BaseNavigationViewController.h"
#import "AMapFunction.h"
#import "ServiceCityViewController.h"
#import "TopScrollView.h"

@interface IndexViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,EScrollerViewDelegate>{
    TopScrollView *homeTopScrollView;
}

// 记录banner 信息
@property (nonatomic, copy) NSArray *arrBanner;

//** Banner背景视图
@property (weak, nonatomic) IBOutlet UIView *v_BannerView;

//** 亚健康类型
@property (weak, nonatomic) IBOutlet UIView *v_TypeYjk;

//** 病后术后类型
@property (weak, nonatomic) IBOutlet UIView *v_TypeBHSH;

//** 亚健康类型
@property (weak, nonatomic) IBOutlet UIImageView *imgYjk;

//** 病后术后类型
@property (weak, nonatomic) IBOutlet UIImageView *imgBHSH;

//** 亚健康类型
@property (weak, nonatomic) IBOutlet UILabel *lbNameYjk;

//** 病后术后类型
@property (weak, nonatomic) IBOutlet UILabel *lbNameBHSH;


@property (weak, nonatomic) IBOutlet UICollectionView *ctv_ServiceItem;

@property(strong, nonatomic) NSArray *arrCtvDataSource;



@end

@implementation IndexViewController



#pragma mark -- CycleScrollVeiwDelegate
//- (NSInteger)numberOfPages{
//    return _arrBanner.count;
//}
//- (UIView *)pageAtIndex:(NSInteger)index{
//    
//    NSDictionary *dict = [_arrBanner objectAtIndex:index];
//    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, _v_BannerView.frame.size.height)];
//    //image.contentMode  = UIViewContentModeScaleAspectFill;
//    [image sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"img_url"]] placeholderImage:nil];
//    
//    return  image;
//    
//    
//}
//
//
//- (void)didClickPage:(LXCycleScrollView *)csView atIndex:(NSInteger)index{
//
//    NSDictionary *dict = [_arrBanner objectAtIndex:index];
//    
//    NSString *webUrl = [CommonWebView actionMakeWebUrl:getValueFromDictionary(dict, @"gotourl") AndParamDict:nil];
//    [CommonWebView actionPresentWebViewControllerWithURL:webUrl NavigationTitle:getValueFromDictionary(dict, @"title") allowShare:getValueFromDictionary(dict, @"is_share") shareImage:getValueFromDictionary(dict, @"shareimg") shareTitle:getValueFromDictionary(dict, @"sharetitle") shareContent:getValueFromDictionary(dict, @"sharecontent") LinkUrl:getValueFromDictionary(dict, @"shareurl")];//getValueFromDictionary(dict, @"shareimg")
//    
//    
//}


// 首页轮播图点击事件
- (void)EScrollerViewDidClicked:(NSString *)index{
    
    NSDictionary *dict = [_arrBanner objectAtIndex:[index intValue]];
    
    NSString *webUrl = [CommonWebView actionMakeWebUrl:getValueFromDictionary(dict, @"img_link_url") AndParamDict:nil];
    [CommonWebView actionPresentWebViewControllerWithURL:webUrl NavigationTitle:getValueFromDictionary(dict, @"title") allowShare:getValueFromDictionary(dict, @"is_share") shareImage:getValueFromDictionary(dict, @"shareimg") shareTitle:getValueFromDictionary(dict, @"sharetitle") shareContent:getValueFromDictionary(dict, @"sharecontent") LinkUrl:getValueFromDictionary(dict, @"shareurl")];//getValueFromDictionary(dict, @"shareimg")
    
    
}



/**
 *  是否需要加载广告详情页面
 */
-(void)action_GotoADDetailView{
    
    if ([CommonIO getLocalData:DeafultKey_ModuleOtherGoAdDetail]) {
        
        NSDictionary *dict = [CommonIO getLocalData:DeafultKey_ModuleOtherGoAdDetail];
        if (![dict isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        NSString *webUrl = [CommonWebView actionMakeWebUrl:[dict objectForKey:@"url"] AndParamDict:nil];
        [CommonWebView actionPresentWebViewControllerWithURL:webUrl NavigationTitle:getValueFromDictionary(dict, @"title")];
        [CommonIO setLocalData:nil key:DeafultKey_ModuleOtherGoAdDetail];
    }
}


#pragma mark --UICollectionViewDelegate
//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake(getScreenWidth / 2,110);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrCtvDataSource.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ServiceItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceItemCollectionViewCell" forIndexPath:indexPath];
    
    [cell setCellData:_arrCtvDataSource[indexPath.row]];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //** goto ReservationViewControlelr
    pushViewControllerWith(StoryBoard_Reservation, ReservationInfoViewController,(@{ViewName:@"",PassObj:_arrCtvDataSource[indexPath.row][@"id"]}));

}



-(void)actionGoAlipay{
    //** 添加支付宝Demo 验证
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:@"http://121.197.10.218/app.alipay.net/alipay.php"
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"sign_data"]) {
                                                  NSString *signData = [responseDictionary objectForKey:@"sign_data"];
                                                  
                                                  [[AlipaySDK defaultService] payOrder:signData fromScheme:@"aliypay" callback:^(NSDictionary *resultDic) {
                                                      NSLog(@"reslut = %@",resultDic);
                                                      
                                                  }];
                                              }
                                              
                                              
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                              
                                          }
                                      showLoading:YES
     ];
}




-(void)loadBannerData{
    
    NSMutableArray *(^getImgUrlList)(NSArray *) = ^(NSArray *list){
        NSMutableArray *muArrImgList = [NSMutableArray array];
        [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [muArrImgList addObject:getValueIfNilReturnStr(obj[@"img_url"])];
        }];
        return muArrImgList;
    };
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"index/banner")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              NSArray *data = [responseDictionary objectForKey:@"data"];
                                              
                                              if (data.count > 0) {
                                                  
                                                  weakSelf.arrBanner = data;
                                                  if ([data count] > 0) {
                                                      
                                                      
                                                    homeTopScrollView = [[TopScrollView alloc]initWithFrameRect:CGRectMake(0, 0, mScreenWidth, mScreenHeight * 0.216) ImageArray:getImgUrlList(data) changeTimes:3];
                                                      homeTopScrollView.delegate = self;
                                                      
//                                                      LXCycleScrollView *view = [[LXCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, _v_BannerView.frame.size.height)];
//                                                      
//                                                      //** 初始化ScrollVeiw
//                                                      view.delegate = self ;
//                                                      view.datasource = self;
//                                                      
//                                                      [data count] ==1 ? [view.scrollView setScrollEnabled:NO] : nil;
//                                                      
                                                      [_v_BannerView addSubview:homeTopScrollView];
                                                  }
                                                  
                                              }
                                              
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                              
                                          }
                                      showLoading:YES
     ];
    
}



-(void)actionGetServiceItemFromServerWithType:(int)type{
    WEAKSELF
    void(^setItemNameAndImg)(NSDictionary *) = ^(NSDictionary *dict){
        if (dict) {
            //设置病后，术后，亚健康状态图标
            [_imgBHSH sd_setImageWithURL:getUrlWithStrValue(dict[@"cate_2_ico"]) placeholderImage:getImageWithRes(@"")];
            [_lbNameBHSH setText:getValueIfNilReturnStr(dict[@"cate_2_name"])];
            
            [_imgYjk sd_setImageWithURL:getUrlWithStrValue(dict[@"cate_1_ico"]) placeholderImage:getImageWithRes(@"")];
            [_lbNameYjk setText:getValueIfNilReturnStr(dict[@"cate_1_name"])];
            
        }
    };
    
    [NetworkHandle loadDataFromServerWithParamDic:@{@"servicetype":[NSString stringWithFormat:@"%i",type]}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"index/serviceitems")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              NSArray *arrList = responseDictionary[@"data"];
                                              weakSelf.arrCtvDataSource = arrList ? arrList : @[];
                                              [weakSelf.ctv_ServiceItem reloadData];
                                              
                                              setItemNameAndImg(responseDictionary);
                                              
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                              
                                          }
                                      showLoading:YES
     ];
}



-(void)actionMainServerTapEvent{
  WEAKSELF
    void(^actionGoToChooseServiceItem)(NSString *) = ^(NSString *serverType){
        //**去预约订单 页面
        ReservationViewController *reservationInfoView = getViewControllFromStoryBoard(StoryBoard_Main, ReservationViewController);
        [reservationInfoView setViewObject:@{@"sid":serverType,@"did":@""}];
        [reservationInfoView actionShowDismissButton];
        reservationInfoView.block = ^(NSString *service){
           
            pushViewControllerWith(StoryBoard_Reservation, ReservationInfoViewController, (@{ViewName:@"",PassObj:service}));
        };
        
        BaseNavigationViewController *navBase = getViewControllFromStoryBoard(StoryBoard_LoginRegsiter, BaseNavigationViewController);
        navBase.viewControllers = @[reservationInfoView];
        [weakSelf presentViewController:navBase animated:YES completion:nil];
    };
    
    
    //** 亚健康类型服务
    [_v_TypeYjk bk_whenTapped:^{
        actionGoToChooseServiceItem(@"1");
        
    }];
    
    
    //** 病后术后类型服务
    [_v_TypeBHSH bk_whenTapped:^{
       
        actionGoToChooseServiceItem(@"2");
    }];
    
}



-(void)uploadUserPositionWith:(NSString *)posLa PosLon:(NSString *)posLon CityName:(NSString *)cityName CityID:(NSString *)cityID{
    [NetworkHandle loadDataFromServerWithParamDic:@{@"posLa":posLa,@"posLon":posLon,@"in_city_name":cityName}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/uploadposition")
                                          success:nil
                                          failure:nil
                                   networkFailure:nil
                                      showLoading:NO];
    //*记录城市位置
    [CommonUser setUserLocation:cityName];
    [self customerLeftNavigationBarItemWithTitle:getValueIfNilReturnStr(cityName) andImageRes:nil];
}



-(void)startGpsGetLocation{
   WEAKSELF
    [AMapFunction action_getUserLocationAndCityWithBlock:^(NSString *latitude, NSString *longitude, NSString *city) {
        
        [weakSelf uploadUserPositionWith:latitude PosLon:longitude CityName:city CityID:@"0"];
        
    } failure:^{
        
        [weakSelf navigationRightItemEvent];
    }];
}



-(void)navigationRightItemEvent{
    //**开启已开启城市列表选择城市
    BaseNavigationViewController *navBase  = getViewControllFromStoryBoard(StoryBoard_LoginRegsiter, BaseNavigationViewController);
    
    ServiceCityViewController *serviceView = getViewControllFromStoryBoard(StoryBoard_HomePage, ServiceCityViewController);
    serviceView.block = ^(NSDictionary *cityDict){
        [CommonUser setUserLocation:cityDict[@"name"]];
        [self customerLeftNavigationBarItemWithTitle:getValueIfNilReturnStr(cityDict[@"name"]) andImageRes:nil];
        
    };
    
    navBase.viewControllers = @[serviceView];
    
    [self presentViewController:navBase animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self loadBannerData];
    
    mRegisterNib_CollectionView(_ctv_ServiceItem, ServiceItemCollectionViewCell);
    
    //**亚健康人群，病后术后人群
    [self actionMainServerTapEvent];
    
    [self actionGetServiceItemFromServerWithType:3];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

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


@interface IndexViewController ()<LXCycleScrollViewDatasource,LXCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

// 记录banner 信息
@property (nonatomic, copy) NSArray *arrBanner;

//** Banner背景视图
@property (weak, nonatomic) IBOutlet UIView *v_BannerView;

//** 亚健康类型
@property (weak, nonatomic) IBOutlet UIView *v_TypeYjk;

//** 病后术后类型
@property (weak, nonatomic) IBOutlet UIView *v_TypeBHSH;

@property (weak, nonatomic) IBOutlet UICollectionView *ctv_ServiceItem;

@property(strong, nonatomic) NSArray *arrCtvDataSource;





@end

@implementation IndexViewController


-(void)loadBannerData{
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"app/banner")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"list"]) {
                                                  NSArray *data = [responseDictionary objectForKey:@"list"];
                                                  
                                                  if (data.count > 0) {
                                                      
                                                      weakSelf.arrBanner = data;
                                                      if ([data count] > 0) {
                                                          LXCycleScrollView *view = [[LXCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, _v_BannerView.frame.size.height)];
                                                          
                                                          //** 初始化ScrollVeiw
                                                          view.delegate = self ;
                                                          view.datasource = self;
                                                          
                                                          [data count] ==1 ? [view.scrollView setScrollEnabled:NO] : nil;
                                                          
                                                          [_v_BannerView addSubview:view];
                                                      }
                                                      
                                                  }
                                                  
                                              }
                                              
                                              
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                              
                                          }
                                      showLoading:YES
     ];
    
}




#pragma mark -- CycleScrollVeiwDelegate
- (NSInteger)numberOfPages{
    return _arrBanner.count;
}
- (UIView *)pageAtIndex:(NSInteger)index{
    
    NSDictionary *dict = [_arrBanner objectAtIndex:index];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, _v_BannerView.frame.size.height)];
    image.contentMode  = UIViewContentModeScaleAspectFill;
    [image sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"imgurl"]] placeholderImage:nil];
    
    return  image;
    
    
}


- (void)didClickPage:(LXCycleScrollView *)csView atIndex:(NSInteger)index{

    NSDictionary *dict = [_arrBanner objectAtIndex:index];
    
    NSString *webUrl = [CommonWebView actionMakeWebUrl:getValueFromDictionary(dict, @"gotourl") AndParamDict:nil];
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
    
    [CommonHUD showHudWithMessage:@"不知道哪里..." delay:1.0f completion:nil];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self loadBannerData];
    
    NSArray *arrServiceItems = @[@{@"id":@"3",@"ico":@"",@"name":@"颈痛/腰痛"},
                                 @{@"id":@"4",@"ico":@"",@"name":@"头痛/头晕/失眠"},
                                 @{@"id":@"5",@"ico":@"",@"name":@"落枕"},
                                 @{@"id":@"6",@"ico":@"",@"name":@"足跟痛"}];
    _arrCtvDataSource = [NSArray arrayWithArray:arrServiceItems];
    
    
    mRegisterNib_CollectionView(_ctv_ServiceItem, ServiceItemCollectionViewCell);
    
    //**亚健康人群，病后术后人群
    [self actionMainServerTapEvent];
    
    
    
    
}


-(void)actionMainServerTapEvent{
    
    //** 亚健康类型服务
    [_v_TypeYjk bk_whenTapped:^{
    
        [CommonHUD showHudWithMessage:@"请稍后..." delay:1.0f completion:nil];
    }];
    
    
    //** 病后术后类型服务
    [_v_TypeBHSH bk_whenTapped:^{
       [CommonHUD showHudWithMessage:@"请稍后..." delay:1.0f completion:nil];
        
    }];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  ReservationViewController.m
//  Recover
//
//  Created by 刘轩 on 15/8/31.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "ReservationViewController.h"
#import "NetworkHandle.h"
#import "ServiceItemCollectionViewCell.h"


@interface ReservationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *ctv_ReservationView;

@property (strong, nonatomic) NSMutableArray *muArr_ServiceItems;



@end

@implementation ReservationViewController

#pragma mark --UICollectionViewDelegate
//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake(getScreenWidth / 3,110);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _muArr_ServiceItems.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ServiceItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceItemCollectionViewCell" forIndexPath:indexPath];
    
    [cell setCellData:_muArr_ServiceItems[indexPath.row]];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [CommonHUD showHudWithMessage:@"不知道哪里..." delay:1.0f completion:nil];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"预约";
    
    mRegisterNib_CollectionView(_ctv_ReservationView, ServiceItemCollectionViewCell);
    
    NSArray *arrServiceItems = @[@{@"id":@"3",@"ico":@"",@"name":@"颈痛"},
                                 @{@"id":@"4",@"ico":@"",@"name":@"头痛"},
                                 @{@"id":@"5",@"ico":@"",@"name":@"落枕"},
                                 @{@"id":@"6",@"ico":@"",@"name":@"头晕"},
                                 @{@"id":@"7",@"ico":@"",@"name":@"失眠"},
                                 @{@"id":@"7",@"ico":@"",@"name":@"腰痛"},
                                 @{@"id":@"8",@"ico":@"",@"name":@"落枕"},
                                 @{@"id":@"9",@"ico":@"",@"name":@"足跟痛"}];
    _muArr_ServiceItems = [NSMutableArray arrayWithArray:arrServiceItems];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

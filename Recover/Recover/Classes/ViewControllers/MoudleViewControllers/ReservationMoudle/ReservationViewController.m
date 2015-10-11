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
#import "ReservationInfoViewController.h"

@interface ReservationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    BOOL presentModule;
}

@property (weak, nonatomic) IBOutlet UICollectionView *ctv_ReservationView;

@property (strong, nonatomic) NSArray *arrServiceItems;


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
    return _arrServiceItems.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ServiceItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceItemCollectionViewCell" forIndexPath:indexPath];
    
    [cell setCellData:_arrServiceItems[indexPath.row]];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  WEAKSELF
    if (presentModule) {
        if (self.block) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            self.block(_arrServiceItems[indexPath.row][@"id"]);
        }
        return;
    }
    
    pushViewControllerWith(StoryBoard_Reservation, ReservationInfoViewController,(@{ViewName:@"",PassObj:_arrServiceItems[indexPath.row][@"id"]}));
    
    
}



-(void)actionGetServiceItemFromServerWithType:(int)type AndDoctorID:(NSString *)docID{
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:@{@"servicetype":[NSString stringWithFormat:@"%i",type],
                                                    @"doctor_id":docID}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"index/serviceitems")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              NSArray *arrList = responseDictionary[@"data"];
                                              weakSelf.arrServiceItems = arrList ? arrList : @[];
                                              [weakSelf.ctv_ReservationView reloadData];
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                              
                                          }
                                      showLoading:YES
     ];
}


-(void)actionShowDismissButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(action_cancel)];
}

- (void) action_cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"预约";
    
    mRegisterNib_CollectionView(_ctv_ReservationView, ServiceItemCollectionViewCell);
    
    if (!self.viewObject) {
       [self actionGetServiceItemFromServerWithType:0 AndDoctorID:@""];
    }else{
        presentModule = YES;
        NSDictionary *dict = (NSDictionary *)self.viewObject;
        if (![dict[@"sid"] isEqualToString:@"0"]) {
          [self actionGetServiceItemFromServerWithType:[dict[@"sid"] intValue] AndDoctorID:@""];
        }else if (![dict[@"did"] isEqualToString:@""]){
          [self actionGetServiceItemFromServerWithType:0 AndDoctorID:dict[@"did"]];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

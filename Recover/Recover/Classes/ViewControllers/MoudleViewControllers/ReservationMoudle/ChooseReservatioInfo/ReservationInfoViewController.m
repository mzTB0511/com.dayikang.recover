//
//  ReservationInfoViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/14.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "ReservationInfoViewController.h"
#import "NetworkHandle.h"
#import "BabySanteDatePicker.h"
#import "ChoooseAddressViewController.h"
#import "LXRelevantPickView.h"
#import "DoctorListViewController.h"

@interface ReservationInfoViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tbvReservationInfo;

@property(nonatomic,strong) NSMutableArray *muArrDataList;

@property(nonatomic,strong) NSMutableDictionary *dictUploadData;

@property(nonatomic,strong) NSMutableArray *arrDateList;

@property(nonatomic,strong) NSMutableArray *arrTimeSecList;


@end

@implementation ReservationInfoViewController


#pragma mark --UITabelVeiwDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _muArrDataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = getDequeueReusableCellWithIdentifier(@"ReservationInfoCustomCell");
    [cell.textLabel setText:_muArrDataList[indexPath.row][@"title"]];
    [cell.detailTextLabel setText:_muArrDataList[indexPath.row][@"subtitle"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF
    switch (indexPath.row) {
        case 0:{// goto康复时间
           
            //省市信息选择器
             [LXRelevantPickView showPickerWithData:@[_arrDateList,_arrTimeSecList] defaultIndex:nil withPickerMoudle:DataPickerMoudleNomal block:^(NSArray *chooseObj) {
                
                if (chooseObj.count > 0) {
                    
                    PickerMoudle *areaMoudle = chooseObj[0][@"seldata"];
                    [_dictUploadData setObject:areaMoudle.name forKey:@"reservation_date"];
                    
                                                                         PickerMoudle *cMoudle = chooseObj[1][@"seldata"];
                    
                    NSArray *starEndTime = [cMoudle.name componentsSeparatedByString:@"-"];
                    
                    [_dictUploadData setObject:starEndTime[0] forKey:@"start_time"];
                    [_dictUploadData setObject:starEndTime[1] forKey:@"end_time"];
                    
                    [_muArrDataList[indexPath.row] setObject:getStringAppendingStr(areaMoudle.name, (@[starEndTime[0],starEndTime[1]])) forKey:@"subtitle"];
                    
                    [weakSelf.tbvReservationInfo reloadData];
                }
            }];
            
        }
            break;
        case 1:{// goto选择康复地址
            
            ChoooseAddressViewController *addressView = getViewControllFromStoryBoard(StoryBoard_Reservation, ChoooseAddressViewController);
            addressView.returnContactBlock = ^(NSString *contactID,NSString *addressDesc){
            
                [_dictUploadData setObject:contactID forKey:@"contact_id"];
                
                [_muArrDataList[indexPath.row] setObject:addressDesc forKey:@"subtitle"];
                [weakSelf.tbvReservationInfo reloadData];
                
            };
            
            addressView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addressView animated:YES];
        }
            break;
        case 2:{// goto康复师选择
         
            DoctorListViewController *addressView = getViewControllFromStoryBoard(StoryBoard_Doctor, DoctorListViewController);
            
            addressView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addressView animated:YES];
            
            addressView.doctorViewBlock = ^(NSDictionary *doctorInfo){
                [_dictUploadData setObject:doctorInfo[@"did"] forKey:@"doctor_id"];
                
                [_muArrDataList[indexPath.row] setObject:doctorInfo[@"name"] forKey:@"subtitle"];
                [weakSelf.tbvReservationInfo reloadData];
            };
         
        }
            break;
        default:
            break;
    }
    
}



#pragma mark --加载服务时间段信息
-(void)getServiceTimeSectionWithDocID:(NSString *)doctorID{
    
    WEAKSELF
    void(^setReservationTime)(NSArray *,NSArray *) = ^(NSArray *dateList,NSArray *timeSecList){
        if (dateList.count > 0) {
            NSMutableArray *muArrDateList = [NSMutableArray array];
            [dateList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [muArrDateList addObject:obj[@"date"]];
            }];
        
            weakSelf.arrDateList = muArrDateList;
        }
        
        if (timeSecList.count > 0) {
            NSMutableArray *muArrTimeSecList = [NSMutableArray array];
            [dateList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *timeSec = obj[@"start_time"];
                timeSec = [timeSec stringByAppendingString:getStringAppendingStr(@"-", obj[@"end_time"]) ];
                [muArrTimeSecList addObject:timeSec];
            }];
            
            weakSelf.arrTimeSecList = muArrTimeSecList;
        }
        
    };
    
    NSString *dicDoctor = doctorID ? doctorID : @"";
 
    [NetworkHandle loadDataFromServerWithParamDic:@{@"d_id":dicDoctor}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"reservation/timesection")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              if ([responseDictionary objectForKey:@"data"]) {
                                                  NSDictionary *dictTimeData = [responseDictionary objectForKey:@"data"];
                                                  if (dictTimeData) {
                                                
                                                setReservationTime(dictTimeData[@"date"],dictTimeData[@"time_sec"]);
                                                      
                                                  }
                                                  
                                              }
                                              
                                              
                                          }
                                          failure:nil
                                   networkFailure:nil
     ];
    
}



-(void)getDoctorServiceTimeFromServer{
    
    //**造数据
    PickerMoudle *data1 = [PickerMoudle new];
    data1.selfID = @"1";
    data1.name = @"09-17 周四";
    
    PickerMoudle *data2 = [PickerMoudle new];
    data2.selfID = @"2";
    data2.name = @"09-18 周四";
    
    PickerMoudle *timeSec1 = [PickerMoudle new];
    timeSec1.selfID = @"1";
    timeSec1.name = @"09-10";
    
    PickerMoudle *timeSec2 = [PickerMoudle new];
    timeSec2.selfID = @"1";
    timeSec2.name = @"10-11";
    
    PickerMoudle *timeSec3 = [PickerMoudle new];
    timeSec3.selfID = @"1";
    timeSec3.name = @"11-12";
    
    _arrDateList = [NSMutableArray arrayWithArray:@[data1,data2]];
    _arrTimeSecList = [NSMutableArray arrayWithArray:@[timeSec1,timeSec2,timeSec3]];
    
    [self getServiceTimeSectionWithDocID:nil];
    
}





#pragma mark--CustomerUINavigationBarEvent
-(void)navigationRightItemEvent{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"预约下单"];
    
    [self.tbvReservationInfo setTableFooterView:[UIView new]];
    
    [self customerRightNavigationBarItemWithTitle:@"确定" andImageRes:nil];

    
    NSArray *arrDataSource = @[[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"预约时间",@"subtitle":@"请选择康复时间"}] ,
                                [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"预约地址",@"subtitle":@"联系人,联系方式,地址"}],
                                [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"康复治疗师",@"subtitle":@"请选择康复治疗师"}]];
    
    _muArrDataList = [NSMutableArray arrayWithArray:arrDataSource];
    
    _dictUploadData = [NSMutableDictionary dictionary];
    
    // 设置服务项目ID 信息
    [_dictUploadData setObject:(NSString *)self.viewObject forKey:@"service_id"];
    
    [self getDoctorServiceTimeFromServer];
   
    
    
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

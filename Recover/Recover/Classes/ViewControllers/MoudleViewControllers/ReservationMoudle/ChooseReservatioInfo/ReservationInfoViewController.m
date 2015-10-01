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
#import "MakeOrderViewController.h"
#import "NSDate+Category.h"
#import "NSDateFormatter+Category.h"


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
           
             [LXRelevantPickView showPickerWithData:@[_arrDateList,_arrTimeSecList] defaultIndex:nil withPickerMoudle:DataPickerMoudleRelevant block:^(NSArray *chooseObj) {
                
                if (chooseObj.count > 0) {
                    
                    PickerMoudle *areaMoudle = chooseObj[0][@"seldata"];
                    [_dictUploadData setObject:areaMoudle.mark forKey:@"reservation_date"];
                    
                    PickerMoudle *cMoudle = chooseObj[1][@"seldata"];
                    
                    NSArray *starEndTime = [cMoudle.name componentsSeparatedByString:@"-"];
                    
                    [_dictUploadData setObject:starEndTime[0] forKey:@"start_time"];
                    [_dictUploadData setObject:starEndTime[1] forKey:@"end_time"];
                    [_dictUploadData setObject:cMoudle.selfID forKey:@"time_id"];
                    
                    [_muArrDataList[indexPath.row] setObject:getStringAppendingStr(areaMoudle.name, (@[@" ",starEndTime[0],@"-",starEndTime[1]])) forKey:@"subtitle"];
                    
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
                [weakSelf.navigationController popViewControllerAnimated:YES];
            };
            
            addressView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addressView animated:YES];
        }
            break;
        case 2:{// goto康复师选择
         
            DoctorListViewController *addressView = getViewControllFromStoryBoard(StoryBoard_Doctor, DoctorListViewController);
            addressView.viewObject = _dictUploadData;
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
    
    NSString *(^getWeekNameFromWeek)(NSInteger) = ^(NSInteger week){
        NSString *weekName = @"";
        switch (week) {
            case 1:
                weekName = @"日";
                break;
            case 2:
                weekName = @"一";
                break;
            case 3:
                weekName = @"二";
                break;
            case 4:
                weekName = @"三";
                break;
            case 5:
                weekName = @"四";
                break;
            case 6:
                weekName = @"五";
                break;
            case 7:
                weekName = @"六";
                break;
        }
        return getStringAppendingStr(@"星期", weekName);
    };
    
    
    //**过滤日期出来 格式（01-12 星期-）
    void(^setReservationTime)(NSArray *) = ^(NSArray *dateList){
        if (dateList.count > 0) {
            NSMutableArray *muArrDateList = [NSMutableArray array];
            NSMutableArray *muArrTimeSecList = [NSMutableArray array];
            [dateList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *dicTime = obj;
                // **组合时间格式
                NSDateFormatter *formateDate = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
                NSDate *date = [formateDate dateFromString:dicTime[@"date"]];
                NSDateFormatter *formateStrDate = [NSDateFormatter dateFormatterWithFormat:@"MM-dd"];
                NSString *strDate = [formateStrDate stringFromDate:date];
                NSString *dateWeek = getStringAppendingStr(strDate, (@[@"  ",getWeekNameFromWeek([date weekday])])) ;
                PickerMoudle *module = [PickerMoudle new];
                NSString *parentID = [NSString stringWithFormat:@"%li",(long)idx];
                [module setSelfID:parentID];
                [module setName:dateWeek];
                [module setMark:dicTime[@"date"]];
                
                [muArrDateList addObject:module];
                
                //**写入日期下对应的时间
                NSArray *arrTimeSec = obj[@"time_sec"];
                [arrTimeSec enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSString *timeStart = obj[@"start_time"];
                    NSString *timeEnd = obj[@"end_time"];
                    timeStart = getStringAppendingStr(timeStart, (@[@"-",timeEnd]));
                   
                    PickerMoudle *moduleSec = [PickerMoudle new];
                    [moduleSec setParentID:parentID];
                    [moduleSec setSelfID:obj[@"time_id"]];
                    [moduleSec setName:timeStart];
                    
                    [muArrTimeSecList addObject:moduleSec];
                }];
              
            }];
            
            weakSelf.arrDateList = muArrDateList;
            weakSelf.arrTimeSecList = muArrTimeSecList;

        }
    
        
    };
    
    NSString *dicDoctor = doctorID ? doctorID : @"";
 
    [NetworkHandle loadDataFromServerWithParamDic:@{@"d_id":dicDoctor}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"reservation/timesection")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                                NSArray *arrTimeSection = [responseDictionary objectForKey:@"data"];
                                                  if (arrTimeSection) {
                                                    setReservationTime(arrTimeSection);
                                                   }
                                          }
                                          failure:nil
                                   networkFailure:nil
     ];
    
}




#pragma mark--CustomerUINavigationBarEvent
-(void)navigationRightItemEvent{
    
    if (_dictUploadData){
      pushViewControllerWith(StoryBoard_Order, MakeOrderViewController, _dictUploadData);
        
    }
 
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
    
    [self getServiceTimeSectionWithDocID:nil];
    
    
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

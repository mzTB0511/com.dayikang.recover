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
    
    switch (indexPath.row) {
        case 0:{// goto康复时间
           
            [BabySanteDatePicker showPickerWithData:_muArrDataList defaultIndex:nil block:^(NSString *string) {
                
            }];
            
        }
            break;
        case 1:{// goto选择康复地址
            
        }
            break;
        case 2:{// goto康复师选择
            
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
                timeSec = [timeSec stringByAppendingString:obj[@"end_time"]];
                [muArrTimeSecList addObject:timeSec];
            }];
            
            weakSelf.arrTimeSecList = muArrTimeSecList;
        }
        
    };
    

    
    NSString *dicDoctor = doctorID ? doctorID : nil;
 
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


#pragma mark--CustomerUINavigationBarEvent
-(void)navigationRightItemEvent{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"预约下单"];
    
    [self.tbvReservationInfo setTableFooterView:[UIView new]];
    
    [self customerRightNavigationBarItemWithTitle:@"确定" andImageRes:nil];
    
    NSArray *arrDataSource = @[@{@"title":@"预约时间",@"subtitle":@"请选择康复时间"},
                               @{@"title":@"预约地址",@"subtitle":@"联系人,联系方式,地址"},
                               @{@"title":@"康复治疗师",@"subtitle":@"请选择康复治疗师"}];
    _muArrDataList = [NSMutableArray arrayWithArray:arrDataSource];
    
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

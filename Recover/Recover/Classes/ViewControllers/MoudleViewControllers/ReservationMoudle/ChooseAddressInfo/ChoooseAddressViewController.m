//
//  ChoooseAddressViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/14.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "ChoooseAddressViewController.h"
#import "ChooseAddressCustomCell.h"
#import "ChooseAddressCustomView.h"
#import "ChooseAddressHistoryCell.h"
#import <BlocksKit/UIControl+BlocksKit.h>
#import "LXRelevantPickView.h"
#import "NetworkHandle.h"

@interface ChoooseAddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbvAddressInfo;

@property(nonatomic,strong) NSMutableArray *muArrDataList;

@property(nonatomic,strong) NSMutableDictionary *muDictAddData;


@end

@implementation ChoooseAddressViewController


#pragma mark --UITabelVeiwDelegate
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return nil;
            break;
    }
    return @"历史地址";
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   WEAKSELF
    switch (section) {
        case 0:{
            ChooseAddressCustomView *view =  getViewByNib(ChooseAddressCustomView,self);
            [view.btn_Ok bk_addEventHandler:^(id sender) {
                // 提交新增地址的操作
                [weakSelf uploadContactDataWithUserContactInfo:_muDictAddData];
                
            } forControlEvents:UIControlEventTouchUpInside];
            return view;
            }
            break;
    }
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 22;
            break;
    }
    
    return 66;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 66;
            break;
    }
    
    return 10;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _muArrDataList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_muArrDataList[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            ChooseAddressCustomCell *cell = getDequeueReusableCellWithIdentifier(@"ChooseAddressCustomCell");
          
            NSDictionary *cellData = _muArrDataList[indexPath.section][indexPath.row];
            switch (indexPath.row) {
                case 0:{
                    cell.EditCompletion = ^(NSString *value){
                        [_muDictAddData setObject:value forKey:@"name"];
                        [_muArrDataList[indexPath.section][indexPath.row] setObject:value forKey:@"subtitle"];
                    };
                }
                    break;
                case 1:{
                    cell.EditCompletion = ^(NSString *value){
                        [_muDictAddData setObject:value forKey:@"phone"];
                        [_muArrDataList[indexPath.section][indexPath.row] setObject:value forKey:@"subtitle"];
                    };
                }
                    break;
                case 2:{
                    
                }
                    break;
                case 3:{
                    cell.EditCompletion = ^(NSString *value){
                        [_muDictAddData setObject:value forKey:@"address"];
                        [_muArrDataList[indexPath.section][indexPath.row] setObject:value forKey:@"subtitle"];
                    };
                }
                    break;
                default:
                    break;
            }

            [cell action_setupCellWithTitle:cellData[@"title"] detail:cellData[@"subtitle"] canEdit:!(indexPath.section == 0 && indexPath.row == 2)];
           
            return cell;
        }
            break;
        case 1:{
            
            ChooseAddressHistoryCell *cell = getDequeueReusableCellWithIdentifier(@"ChooseAddressHistoryCell");
            [cell setCellData:_muArrDataList[indexPath.section][indexPath.row]];
            [cell.btnUsed bk_addEventHandler:^(id sender) {
                // [使用]按钮点击事件
                
                
            } forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;

    }

    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.view endEditing:YES];
    WEAKSELF
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 2: {
                    //**造数据
                    PickerMoudle *pmProvience = [PickerMoudle new];
                    pmProvience.selfID = @"1";
                    pmProvience.name = @"上海";
                    
                    PickerMoudle *pmProvience1 = [PickerMoudle new];
                    pmProvience1.selfID = @"2";
                    pmProvience1.name = @"北京";
                    
                    PickerMoudle *pmCity = [PickerMoudle new];
                    pmCity.parentID = @"1";
                    pmCity.selfID = @"1";
                    pmCity.name = @"上海市";
                    
                    PickerMoudle *pmCity1 = [PickerMoudle new];
                    pmCity1.parentID = @"2";
                    pmCity1.selfID = @"2";
                    pmCity1.name = @"北京市";
                    
                    
                    PickerMoudle *pmArea = [PickerMoudle new];
                    pmArea.parentID = @"1";
                    pmArea.selfID = @"1";
                    pmArea.name = @"长宁区";
                    
                    PickerMoudle *pmArea2 = [PickerMoudle new];
                    pmArea2.parentID = @"1";
                    pmArea2.selfID = @"1";
                    pmArea2.name = @"普陀区";
                    
                    PickerMoudle *pmArea3 = [PickerMoudle new];
                    pmArea3.parentID = @"2";
                    pmArea3.selfID = @"1";
                    pmArea3.name = @"海淀区";
                    
                    PickerMoudle *pmArea4 = [PickerMoudle new];
                    pmArea4.parentID = @"2";
                    pmArea4.selfID = @"1";
                    pmArea4.name = @"丰台区";
                    
                    //省市信息选择器
                    [LXRelevantPickView showPickerWithData:@[@[pmProvience,pmProvience1],@[pmCity,pmCity1],
                                                             @[pmArea,pmArea2,pmArea3,pmArea4]] defaultIndex:nil withPickerMoudle:DataPickerMoudleRelevant block:^(NSArray *chooseObj) {
                        
                                                                 if (chooseObj.count > 0) {
                                                                    
                                                                     PickerMoudle *areaMoudle = chooseObj[2][@"seldata"];
                                                                     [_muDictAddData setObject:areaMoudle.selfID forKey:@"area_id"];
                                                                     
                                                                     //** 显示省，市，区信息
                                                                     PickerMoudle *pMoudle = chooseObj[0][@"seldata"];
                                                                     PickerMoudle *cMoudle = chooseObj[1][@"seldata"];
                                                                     PickerMoudle *aMoudle = chooseObj[2][@"seldata"];
                                                                     
                                                                     NSString *jg = @"";
                                                                     jg = [jg stringByAppendingString:getStringAppendingStr(pMoudle.name,@",")];
                                                                     jg = [jg stringByAppendingString:getStringAppendingStr(cMoudle.name,@",")];
                                                                     jg = [jg stringByAppendingString:aMoudle.name];
                                                                     
                                                                     [_muArrDataList[indexPath.section][indexPath.row] setObject:jg forKey:@"subtitle"];
                                                                     [weakSelf.tbvAddressInfo reloadData];
                                                                 }
                    }];
                    
                }
                    break;
            }
        }
            break;
    }
    
}



-(void)uploadContactDataWithUserContactInfo:(NSDictionary *)info{
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:info
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"reservation/addcontact")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              if ([responseDictionary objectForKey:@"return_data"]) {
                                                  NSDictionary *dictTimeData = [responseDictionary objectForKey:@"return_data"];
                                                  if (dictTimeData) {
                                                      
                                                      if (weakSelf.returnContactBlock) {
                                                          weakSelf.returnContactBlock(dictTimeData[@"contact_id"],[_muArrDataList[0][2] objectForKey:@"subtitle"]);
                                                      }
                                                  }
                                                  
                                              }
                                              
                                          }
                                          failure:nil
                                   networkFailure:nil
     ];
    
}



-(void)getUserHistoryContactInfoFromServer{
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"reservation/getcontact")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              if ([responseDictionary objectForKey:@"data"]) {
                                                  NSArray *arrHis = [responseDictionary objectForKey:@"data"];
                                                  if (arrHis) {
                        // 如果有收货历史地址  加载重载数据
                                                      [_muArrDataList setObject:arrHis atIndexedSubscript:1];
                                                      [weakSelf.tbvAddressInfo reloadData];
                                                  }
                                                  
                                              }
                                              
                                          }
                                          failure:nil
                                   networkFailure:nil
     ];
    
}




-(void)getProvienceCityAreaInfoFromServer{
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"reservation/getcitylist")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              if ([responseDictionary objectForKey:@"addresslist"]) {
                                                  NSArray *arrHis = [responseDictionary objectForKey:@"addresslist"];
                                                  if (arrHis) {
                                                      
                                                      
                                                  }
                                                  
                                              }
                                              
                                          }
                                          failure:nil
                                   networkFailure:nil
     ];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"预约康复地址"];
    
    mRegisterNib_TableView(_tbvAddressInfo, ChooseAddressCustomCell);
    mRegisterNib_TableView(_tbvAddressInfo, ChooseAddressHistoryCell);
    
    _muArrDataList = [NSMutableArray array];
    NSArray *arrAddressData = @[[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"联系人",@"subtitle":@"请输入您的姓名"}] ,
                                [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"联系方式",@"subtitle":@"请输入您的手机号"}],
                                [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"省市,区县",@"subtitle":@"请选择所在的城市"}],
                                [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"详细地址",@"subtitle":@"街道,楼道,单元,门牌号"}]];
    [_muArrDataList addObject:arrAddressData];
    [_muArrDataList addObject:@[]];
    
    [self getUserHistoryContactInfoFromServer];
    
    [self getProvienceCityAreaInfoFromServer];
    
    _muDictAddData = [NSMutableDictionary dictionary];
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
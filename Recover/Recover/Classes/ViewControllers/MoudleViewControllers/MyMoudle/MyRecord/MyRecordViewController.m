//
//  MyRecordViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/8.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyRecordViewController.h"
#import "NetworkHandle.h"
#import "MJRefresh.h"
#import "UserInfoAvatarCell.h"
#import "BabySanteDatePicker.h"
#import "UIViewController+ImagePicker.h"
#import "ChooseAddressCustomCell.h"


@interface MyRecordViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageIndex;
}
@property(weak,nonatomic) IBOutlet UITableView *tbvTableView;

@property (nonatomic, strong) NSArray *arr_dataSource;

@property (nonatomic, strong) NSMutableDictionary *data;

@property (nonatomic, strong) UIImage *avatarImage;

@property (nonatomic, assign) int user_Status;

@end

@implementation MyRecordViewController


#pragma mark - 保存

- (void) action_saveData {
    
    [self.view endEditing:YES];
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:_data
                                          signDic:nil
                            imagesDictionaryArray:_avatarImage?@[@{Define_Image_Dictionary_imageData:_avatarImage,
                                                                   Define_Image_Dictionary_imageName:@"image.png",
                                                                   Define_Image_Dictionary_paramName:@"userIco"}]:nil
                                    interfaceName:InterfaceAddressName(@"my/updaterecord")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              weakSelf.avatarImage = nil;
                                    
                                              [CommonHUD showHudWithMessage:@"保存成功" delay:CommonHudShowDuration completion:nil];
                                              
                                          } failure:nil
                                   networkFailure:nil];
}

#pragma mark - Table View Data Source & Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES];
    
    WEAKSELF
    
    switch (indexPath.section) {
        case 0:
        {
            //点击头像
            UserInfoAvatarCell *cell = (UserInfoAvatarCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            [self imageByCameraAndPhotosAlbumWithActionSheetUsingBlock:^(UIImage *image, NSString *imageName, NSString *imagePath) {
                [cell action_setImage:image];
                weakSelf.avatarImage = image;
                
                [weakSelf action_saveData];
            }];
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //姓名
                }
                    break;
                case 1:
                {
                    //性别
                    [BabySanteDatePicker showPickerWithValues:@[@"男",@"女"]
                                                 defaultIndex:[_data[@"sex"] isEqualToString:@"男"]?1:0
                                                        block:^(NSString *string) {
                                                            weakSelf.data[@"sex"] = string ;
                                                            [weakSelf.tbvTableView reloadData];
                                                            
                                                            [weakSelf action_saveData];
                                                        }];
    
                }
                    break;
                case 2:
                {
                    //生日
                    [BabySanteDatePicker showDatePickerWithMinDate:[[NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"] dateFromString:@"1900-01-01"]
                                                           maxDate:[NSDate date]
                                                       defaultDate:[[NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"] dateFromString:((NSString *)_data[@"age"]).length?_data[@"age"]:@"1980-01-01"]
                                                         showHours:NO block:^(NSString *string) {
                                                             weakSelf.data[@"age"] = string;
                                                             [weakSelf.tbvTableView reloadData];
                                                             
                                                             [weakSelf action_saveData];
                                                         }];
                }
                    break;
                case 3:
                {
                   // 手机号
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //从事行业
                    [BabySanteDatePicker showPickerWithValues:@[@"计算机/互联网/通讯",
                                                                @"会计/金融/保险",
                                                                @"贸易/制造/营运",
                                                                @"广告/媒体",
                                                                @"房地产/建筑",
                                                                @"教育/培训",
                                                                @"物流/运输",
                                                                @"能源/原材料",
                                                                @"政府/非盈利机构/其他"]
                                                 defaultIndex:1
                                                        block:^(NSString *string) {
                                                            weakSelf.data[@"trade"] = string;
                                                            [weakSelf.tbvTableView reloadData];
                                                            
                                                            [weakSelf action_saveData];
                                                        }];
                }
                    break;
                case 1:
                {
                    //公司职业
                    [BabySanteDatePicker showPickerWithValues:@[@"IT-管理",
                                                                @"程序员",
                                                                @"销售",
                                                                @"教师",
                                                                @"律师",
                                                                @"企业职工",
                                                                @"医生",
                                                                @"工程师",
                                                                @"公务员",
                                                                @"其他"]
                                                 defaultIndex:1
                                                        block:^(NSString *string) {
                                                            weakSelf.data[@"job_title"] = string;
                                                            [weakSelf.tbvTableView reloadData];
                                                            
                                                            [weakSelf action_saveData];
                                                        }];                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    // 常见症状
                  
                }
                    break;
                
            }
        }
            break;
        default:
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        UserInfoAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoAvatarCell class]) forIndexPath:indexPath];
        
        [cell action_setupCellWithTitle:_arr_dataSource[indexPath.section][indexPath.row] imageUrl:_data[@"ico"]];
        
        return cell;
    }
    
    
    WEAKSELF
    ChooseAddressCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChooseAddressCustomCell class]) forIndexPath:indexPath];
    
    NSString *detail = nil;
    
    switch (indexPath.section) {
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //姓名
                    detail = [_data[@"name"] isKindOfClass:[NSString class]]?_data[@"name"]:@"";
                    cell.EditCompletion = ^(NSString *name){
                        weakSelf.data[@"name"] = name;
                        
                        [weakSelf action_saveData];
                    };
                }
                    break;
                case 1:
                {
                    //性别
                    detail = _data[@"sex"];
                    
                }
                    break;
                case 2:
                {
                    //生日
                    detail = [_data[@"age"] isKindOfClass:[NSString class]]?_data[@"age"]:@"";
                }
                    break;
                case 3:
                {
                    //手机号
                    detail = [_data[@"phone"] isKindOfClass:[NSString class]]?_data[@"phone"]:@"";
                  
                    cell.EditCompletion = ^(NSString *phone){
                        weakSelf.data[@"phone"] = phone;
                        
                        [weakSelf action_saveData];
                    };
                }
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //从事行业
                    detail = ([_data[@"trade"] isKindOfClass:[NSString class]] && ((NSString *)_data[@"trade"]).length)?_data[@"trade"]:@"";
                }
                    break;
                case 1:
                {
                    //公司职业
                    detail = ([_data[@"job_title"] isKindOfClass:[NSString class]] && ((NSString *)_data[@"job_title"]).length)?_data[@"job_title"]:@"";
                }
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //常见症状
                    detail = ([_data[@"symptom"] isKindOfClass:[NSString class]] && ((NSString *)_data[@"symptom"]).length)?_data[@"symptom"]:@"";
                }
                    break;
            }
        }
            break;
    }
    
    [cell action_setupCellWithTitle:_arr_dataSource[indexPath.section][indexPath.row] detail:detail canEdit:((indexPath.section==1 && indexPath.row==0) || (indexPath.section==1 && indexPath.row==3))];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)_arr_dataSource[section]).count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arr_dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的档案";
    WEAKSELF
    
    self.arr_dataSource = @[@[@"头像"],
                            @[@"姓名",@"性别",@"出生年月",@"手机号"],
                            @[@"从事行业",@"公司职业"],
                            @[@"常见症状"]];
    
    
    mRegisterNib_TableView(_tbvTableView, UserInfoAvatarCell);
    mRegisterNib_TableView(_tbvTableView, ChooseAddressCustomCell);

    _tbvTableView.tableFooterView = [UIView new];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(action_saveData)];
    
    
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/record")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              weakSelf.data = [NSMutableDictionary dictionaryWithDictionary:responseDictionary[@"data"]];
                                              [weakSelf.tbvTableView reloadData];
                                          }
                                          failure:nil
                                   networkFailure:nil];
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

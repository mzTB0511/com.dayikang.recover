//
//  AddDoctorCommendViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "AddDoctorCommendViewController.h"
#import "AddDoctorCommendHeadView.h"
#import "AddDoctorCommendTableViewCell.h"
#import "AddDoctorCommendContentTableViewCell.h"
#import "NetworkHandle.h"

@interface AddDoctorCommendViewController ()


@property (weak, nonatomic) IBOutlet UITableView *tbvAddRommend;

@property(nonatomic, strong) NSMutableDictionary *dictUploadData;

@property(nonatomic, strong) UITableViewCell *cellCommendContent;


@end

@implementation AddDoctorCommendViewController


#pragma mark --UITabelVeiwDelegate
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    switch (section) {
        case 1:{
            AddDoctorCommendHeadView *view = getViewByNib(AddDoctorCommendHeadView, self);
            if (self.viewObject) {
                [view setCellData:(NSDictionary *)self.viewObject];
            }
            
            return view;
        }
            break;
    }
    
    return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            AddDoctorCommendTableViewCell *cell  = getDequeueReusableCellWithClass(AddDoctorCommendTableViewCell);
            cell.startBlock = ^(NSInteger type,NSInteger starNums){
                switch (type) {
                    case 1:
                       [_dictUploadData setObject:[NSString stringWithFormat:@"%li",(long)starNums] forKey:@"type_1"];
                        break;
                    case 2:
                        [_dictUploadData setObject:[NSString stringWithFormat:@"%li",(long)starNums] forKey:@"type_2"];
                        break;
                    case 3:
                        [_dictUploadData setObject:[NSString stringWithFormat:@"%li",(long)starNums] forKey:@"type_3"];
                        break;
                }
                
            };
            return cell;
             }
            break;
        case 1:{
            AddDoctorCommendContentTableViewCell *cell = getDequeueReusableCellWithClass(AddDoctorCommendContentTableViewCell);
            _cellCommendContent = cell;
            return cell;
        }
            break;
    }
    
    return nil;
    
}


-(void)addCommendDataToServerWithData:(NSDictionary *)data{
    
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"orders/commentadd")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                            
                                              
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                              
                                          }
                                      showLoading:YES
     ];
    
    
}


-(void)navigationRightItemEvent{
    if (![_dictUploadData objectForKey:@"type_1"] ||
        [_dictUploadData objectForKey:@"type_2"] ||
        [_dictUploadData objectForKey:@"type_3"]) {
        [CommonHUD showHudWithMessage:@"请给康复师打分" delay:1.0f completion:nil];
        return;
    }
    
    //** 获得评论内容
    AddDoctorCommendContentTableViewCell *contentCell =  (AddDoctorCommendContentTableViewCell *)_cellCommendContent;
    
    if (![contentCell.tvContent.text isEqualToString:@""]) {
        [CommonHUD showHudWithMessage:@"请输入评论内容" delay:1.0f completion:nil];
        return;
    }
    [_dictUploadData setObject:contentCell.tvContent.text forKey:@"content"];
    
    [self addCommendDataToServerWithData:_dictUploadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"评价"];
    [self customerRightNavigationBarItemWithTitle:@"发表" andImageRes:nil];
    
    mRegisterNib_TableView(_tbvAddRommend, AddDoctorCommendTableViewCell);
    mRegisterNib_TableView(_tbvAddRommend, AddDoctorCommendContentTableViewCell);
    _dictUploadData = [NSMutableDictionary dictionary];
    
    NSDictionary *dictOrder = (NSDictionary *)self.viewObject;
    [_dictUploadData setObject:dictOrder[@"orders_id"] forKey:@"order_id"];
    [_dictUploadData setObject:dictOrder[@"doctor_id"] forKey:@"doctor_id"];
    
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

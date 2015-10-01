//
//  DoctorInfoViewController.m
//  Recover
//
//  Created by 刘轩 on 15/9/19.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "DoctorInfoViewController.h"
#import "DoctorInfoZhengShuCell.h"
#import "DoctorInfoTableHeardView.h"
#import "DoctorInfoDescCell.h"
#import "ChooseAddressCustomView.h"
#import "NetworkHandle.h"
#import <BlocksKit/UIControl+BlocksKit.h>
#import "DoctorCommendViewController.h"


@interface DoctorInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbvDoctorInfo;

@property (strong, nonatomic) NSMutableDictionary *muDictDoctorInfo;


@end

@implementation DoctorInfoViewController



#pragma mark --UITabelVeiwDelegate
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
WEAKSELF
    switch (section) {
        case 1:{
            ChooseAddressCustomView *view = getViewByNib(ChooseAddressCustomView, self);
            [view.btn_Ok setTitle:@"预约" forState:UIControlStateNormal];
           
            //** 添加点击事件
            [view.btn_Ok bk_addEventHandler:^(id sender) {
                if (self.doctorInfoBlock) {
                    [_muDictDoctorInfo setObject:(NSString *)self.viewObject forKey:@"did"];
                    [weakSelf.navigationController popViewControllerAnimated:NO];
                    self.doctorInfoBlock(_muDictDoctorInfo);
                    
                }
                
            } forControlEvents:UIControlEventTouchUpInside];
            
            return view;
        }
            break;
    }
    
    return nil;

}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 20;
            break;
    }
    
    return 100;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.section) {
                case 0:{
                    DoctorInfoDescCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"DoctorInfoDescCell"];
                    [cell.lbDocDesc setText:_muDictDoctorInfo[@"desc"]];
                    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
                
                    return size.height + 1;
                 }
                    break;
                case 1:{
                    return 44;
                }
                    break;
            }
        }
            break;
        case 1:{
            return 124;
        }
            break;
    }
    
    return 0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
    }
    
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    DoctorInfoDescCell *cell  = getDequeueReusableCellWithClass(DoctorInfoDescCell);
                    [cell.lbDocDesc setText:_muDictDoctorInfo[@"desc"]];
                    return cell;
                }
                    break;
                    
                case 1:{
                    UITableViewCell *cell = getDequeueReusableCellWithIdentifier(@"DoctorInfoRecommendCell");
                    [cell.textLabel setText:getStringAppendingStr(@"顾客评价", (@[@"(",_muDictDoctorInfo[@"comment_count"],@")"]))];
                    return cell;
                }
                    break;
            }
        }
            break;
        case 1:{
            DoctorInfoZhengShuCell *cell = getDequeueReusableCellWithClass(DoctorInfoZhengShuCell);
            [cell actionSetCellData:_muDictDoctorInfo[@"imgs"] CollectionViewBlock:^(NSInteger selIndex) {
                NSLog(@"当前点击了那个图片");
                
            }];
            
            return cell;
        }
            break;
    }
    
    return nil;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    DoctorCommendViewController *recommendInfo = getViewControllFromStoryBoard(StoryBoard_Doctor, DoctorCommendViewController);
    recommendInfo.viewObject = (NSString *)self.viewObject;
    [self.navigationController pushViewController:recommendInfo animated:YES];
    
}





-(void)loadDataFromServerWithDoctInfo:(NSString *)docID{
WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:@{@"doctor_id":docID}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"doctor/info")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              
                                              if ([responseDictionary objectForKey:@"data"]) {
                                                  NSDictionary *data = [responseDictionary objectForKey:@"data"];
                                                
                                                  weakSelf.muDictDoctorInfo = [NSMutableDictionary dictionaryWithDictionary:data];
                                                  
                                                  [weakSelf actionSetTableViewHeadView:weakSelf.tbvDoctorInfo];
                                                  weakSelf.tbvDoctorInfo.dataSource = weakSelf;
                                                  weakSelf.tbvDoctorInfo.delegate = weakSelf;
                                                  [weakSelf.tbvDoctorInfo reloadData];
                                              }
                                              
                                            
                                          }
                                          failure:^{
                                              
                                          } networkFailure:^{
                                            
                                          }
                                      showLoading:YES
     ];
    
    
}



-(void)actionSetTableViewHeadView:(UITableView *)tableView{
    DoctorInfoTableHeardView *view = getViewByNib(DoctorInfoTableHeardView, self);
    [view setViewData:_muDictDoctorInfo];
    [tableView setTableHeaderView:view];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"康复治疗师详情"];
    [self customerRightNavigationBarItemWithTitle:@"收藏" andImageRes:nil];
    mRegisterNib_TableView(_tbvDoctorInfo, DoctorInfoDescCell);
    mRegisterNib_TableView(_tbvDoctorInfo, DoctorInfoZhengShuCell);
    
    [self loadDataFromServerWithDoctInfo:(NSString *)self.viewObject];
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

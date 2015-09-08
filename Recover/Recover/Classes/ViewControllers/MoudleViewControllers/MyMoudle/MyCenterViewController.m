//
//  MyCenterViewController.m
//  Recover
//
//  Created by 刘轩 on 15/8/31.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MyCenterViewController.h"
#import "UserInfoAvatarCell.h"
#import "NetworkHandle.h"
#import "UIViewController+ImagePicker.h"


@interface MyCenterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tbv_UserInfoTableView;

@property (nonatomic, strong) NSMutableArray *arr_dataSource;

@property (nonatomic, strong) NSMutableDictionary *data;

@property (nonatomic, strong) UIImage *avatarImage;
@end

@implementation MyCenterViewController


#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arr_dataSource.count;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_arr_dataSource objectAtIndex:section] count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }
    return 44;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UserInfoAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserInfoAvatarCell class]) forIndexPath:indexPath];
        
        [cell action_setupCellWithTitle:@"" imageUrl:_arr_dataSource[indexPath.section][indexPath.row][@"itemIco"]];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCenterCommonCell" forIndexPath:indexPath];
    
    NSDictionary *cellDict = [[_arr_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[cellDict objectForKey:@"itemTitle"]];
    [cell.imageView setImage:getImageWithRes([cellDict objectForKey:@"itemIco"])];
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
                
                //**更新头像操作
                
                //[weakSelf action_saveData];
            }];
        }
            break;
        case 1:{
            //** 我的档案
            
        }
            break;
        case 2:{
            //** 我的优惠券
        }
            break;
        case 3:{
            //** 我的收藏
            
        }
            break;
        case 4:{
            //** 我的钱包
        }
            break;
        case 5:{
            //** 我的康复师
            
        }
            break;
    }

    //** 取消Cell高亮效果
    [_tbv_UserInfoTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


-(void)makeTBVDataSource{
    
    //** 组合数据格式
    NSArray *listIco = @[@{@"itemIco":@"",@"itemTitle":@"",@"itemValue":@"15618297762"}];
    
    NSArray *listRecord = @[@{@"itemIco":@"",@"itemTitle":@"我的档案",@"itemValue":@""}];
    NSArray *listYhq = @[@{@"itemIco":@"",@"itemTitle":@"我的优惠券",@"itemValue":@""}];
    NSArray *listFavourite= @[@{@"itemIco":@"",@"itemTitle":@"我的收藏",@"itemValue":@""}];
    NSArray *listCash = @[@{@"itemIco":@"",@"itemTitle":@"我的钱包",@"itemValue":@""}];
    NSArray *listDoc = @[@{@"itemIco":@"",@"itemTitle":@"我的康复师",@"itemValue":@""}];
    
    [_arr_dataSource addObject:listIco];
    [_arr_dataSource addObject:listRecord];
    [_arr_dataSource addObject:listYhq];
    [_arr_dataSource addObject:listFavourite];
    [_arr_dataSource addObject:listCash];
    [_arr_dataSource addObject:listDoc];
    [_tbv_UserInfoTableView reloadData];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"我";
    
    mRegisterNib_TableView(_tbv_UserInfoTableView, UserInfoAvatarCell);
    
    
    _arr_dataSource = [NSMutableArray array];
    
    
    [self makeTBVDataSource];
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

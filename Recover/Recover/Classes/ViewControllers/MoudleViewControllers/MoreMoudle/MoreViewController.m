//
//  MoreViewController.m
//  Recover
//
//  Created by 刘轩 on 15/8/31.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "MoreViewController.h"
#import "DoctroJoinViewController.h"
#import "ServiceAreaViewController.h"
#import "CopyrightViewController.h"
#import "SVWebViewController.h"
#import "CommonWebView.h"


@interface MoreViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tbv_MoreTableView;

@property (nonatomic, strong) NSMutableArray *arr_dataSource;
@end

@implementation MoreViewController


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
    
    return 44;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreModuleIndexViewCell" forIndexPath:indexPath];
    
    NSDictionary *cellDict = [[_arr_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[cellDict objectForKey:@"itemTitle"]];
    [cell.imageView setImage:getImageWithRes([cellDict objectForKey:@"itemIco"])];
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    switch (indexPath.section) {
        case 0:
        {
            //康复师傅入住
           // pushViewControllerWith(StoryBoard_More, DoctroJoinViewController, nil);
        }
            break;
        case 1:{
            NSString *webUrl = [CommonWebView actionMakeWebUrl:InterfaceAddressName(@"service/webpage") AndParamDict:@{@"page_id":@"3"}];
            SVWebViewController *viewView =  [[SVWebViewController alloc] initWithAddress:webUrl];
            [viewView setTitle:@"服务范围"];
            viewView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewView animated:YES];
        }
            break;
        case 3:{
            //** 关于奎科
            NSString *webUrl = [CommonWebView actionMakeWebUrl:InterfaceAddressName(@"service/webpage") AndParamDict:@{@"page_id":@"4"}];
            SVWebViewController *viewView =  [[SVWebViewController alloc] initWithAddress:webUrl];
            [viewView setTitle:@"关于我们"];
            viewView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewView animated:YES];
        }
            break;
        case 2:{
            //** 当前版本
            
        }
            break;
        case 4:{
            //** 为app投票
            //itms-apps://itunes.apple.com/app/idYOUR_APP_ID
        }
            break;

    }
    
   
    //** 取消Cell高亮效果
    [_tbv_MoreTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


-(void)makeTBVDataSource{
    
    //** 组合数据格式
    NSArray *listRecord = @[@{@"itemIco":@"",@"itemTitle":@"康复师入住"}];
    NSArray *listYhq = @[@{@"itemIco":@"",@"itemTitle":@"服务范围"}];
    NSArray *listFavourite= @[@{@"itemIco":@"",@"itemTitle":@"当前版本"}];
    NSArray *listCash = @[@{@"itemIco":@"",@"itemTitle":@"关于我们"}];
    NSArray *listDoc = @[@{@"itemIco":@"",@"itemTitle":@"为App投票"}];
    
    [_arr_dataSource addObject:listRecord];
    [_arr_dataSource addObject:listYhq];
    [_arr_dataSource addObject:listFavourite];
    [_arr_dataSource addObject:listCash];
    [_arr_dataSource addObject:listDoc];
    [_tbv_MoreTableView reloadData];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"更多";
    
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

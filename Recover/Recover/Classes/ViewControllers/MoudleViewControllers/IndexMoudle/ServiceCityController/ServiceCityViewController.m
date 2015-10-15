//
//  ServiceCityViewController.m
//  
//
//  Created by 刘轩 on 15/10/15.
//
//

#import "ServiceCityViewController.h"
#import "NetworkHandle.h"


@interface ServiceCityViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tbv_OrderListView;

@property(strong,nonatomic) NSArray *muArr_OrderList;

@end

@implementation ServiceCityViewController



#pragma mark --UITabelVeiwDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _muArr_OrderList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = getDequeueReusableCellWithIdentifier(@"ServiceCityViewCell");
    
    NSDictionary *cellData = [_muArr_OrderList objectAtIndex:indexPath.row];
    [cell.textLabel setText:getValueIfNilReturnStr(cellData[@"name"])];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellData = [_muArr_OrderList objectAtIndex:indexPath.row];
    if (self.block) {
        [self navigationRightItemEvent];
        self.block(cellData);
    }
    
}



-(void)navigationRightItemEvent{
    [self dismissViewControllerAnimated:YES completion:nil];
}





-(void)loadDataFromServerWith{
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"index/opencity")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              weakSelf.muArr_OrderList = responseDictionary[Return_data];
                                              [weakSelf.tbv_OrderListView reloadData];
                                          }
                                          failure:nil networkFailure:nil
                                      showLoading:YES
     ];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"开通城市"];
    
    [self customerLeftNavigationBarItemWithTitle:@"取消" andImageRes:nil];

    [self loadDataFromServerWith];
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

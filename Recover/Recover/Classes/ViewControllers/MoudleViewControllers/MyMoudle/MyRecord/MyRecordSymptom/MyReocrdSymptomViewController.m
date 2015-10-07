//
//  MyReocrdSymptomViewController.m
//
//
//  Created by 刘轩 on 15/10/7.
//
//

#import "MyReocrdSymptomViewController.h"
#import "NetworkHandle.h"


@interface MyReocrdSymptomViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(weak,nonatomic) IBOutlet UITableView *tbvTableView;

@property (nonatomic, strong) NSMutableArray *muArrDataSource;

@property(nonatomic,strong) NSMutableArray *muArrSelSymptom;


@end

@implementation MyReocrdSymptomViewController



#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_muArrDataSource count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyRecordViewSympomCell" forIndexPath:indexPath];
    
    NSDictionary *cellDict = [_muArrDataSource objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[cellDict objectForKey:@"name"]];

    [cellDict[@"sel"] intValue] == 1 ? [cell setAccessoryType:UITableViewCellAccessoryCheckmark] : nil;
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *cellDict = [_muArrDataSource objectAtIndex:indexPath.row];
    if ([cellDict[@"sel"] intValue] == 1) {
        [[_muArrDataSource objectAtIndex:indexPath.row] setObject:@"0" forKey:@"sel"];
    }else{
        [[_muArrDataSource objectAtIndex:indexPath.row] setObject:@"1" forKey:@"sel"];
    }
    [tableView reloadData];
}





-(void)navigationRightItemEvent{
    //** 遍历结果结合 检索当前选中项目
    [_muArrSelSymptom removeAllObjects];
    for (NSDictionary *dict in _muArrDataSource) {
        [dict[@"sel"] intValue] ==1 ? [_muArrSelSymptom addObject:dict] : nil;
    }
    
    if (self.block) {
        [self.navigationController popViewControllerAnimated:YES];
        self.block(_muArrSelSymptom);
    }
}




-(void)getSymptomListFromServerWithData:(NSArray *)selSymptom{
    WEAKSELF
    NSMutableArray *(^formatToMutableArrayWithData)(NSArray *) = ^(NSArray *symptom){
        NSMutableArray *retSymptom = [NSMutableArray array];
        for (NSDictionary *dict in symptom) {
            NSMutableDictionary *muDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            [muDict setObject:@"0" forKey:@"sel"];
            if (selSymptom) {
                
                for (NSDictionary *selDict in selSymptom) {
                    if ([selDict[@"id"] isEqualToString:muDict[@"id"]]) {
                        [muDict setObject:@"1" forKey:@"sel"];
                    }
                }
                
            }
            [retSymptom addObject:muDict];
        }
        
        return retSymptom;
    };
    
    
    [NetworkHandle loadDataFromServerWithParamDic:nil
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"my/getsymptom")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              NSArray *arrSymptom = responseDictionary[@"data"];
                                              _muArrDataSource = formatToMutableArrayWithData(arrSymptom);
                                              
                                              [weakSelf.tbvTableView reloadData];
                                          }
                                          failure:nil
                                   networkFailure:nil];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"症状选择"];
    
    [self customerRightNavigationBarItemWithTitle:@"确定" andImageRes:nil];
    
    if (self.viewObject) {
        _muArrSelSymptom = (NSMutableArray *)self.viewObject;
    }
    
    [self getSymptomListFromServerWithData:_muArrSelSymptom];
    
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

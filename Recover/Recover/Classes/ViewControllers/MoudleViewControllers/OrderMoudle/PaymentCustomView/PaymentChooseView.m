//
//  PaymentChooseView.m
//  Recover
//
//  Created by 刘轩 on 15/10/1.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "PaymentChooseView.h"
#import "PaymentChooseHeaderView.h"


@implementation PaymentMoudle

@end



@interface PaymentChooseView()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbvTableView;

@property(nonatomic,strong) NSArray *arrDataSource;

@property(nonatomic,copy)CommonReturnDataBlock block;

@property(nonatomic,strong) PaymentMoudle *payMoudle;



@end




@implementation PaymentChooseView

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return getStringAppendingStr(@"应支付:",([NSString stringWithFormat:@"%.1f",_payMoudle.payAmont]));
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return _arrDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"PayMentChooseCell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([_arrDataSource[indexPath.row][@"ico"] isKindOfClass:[UIImage class]]) {
        [cell.imageView setImage:_arrDataSource[indexPath.row][@"ico"]];
    }
    
    [cell.textLabel setText:_arrDataSource[indexPath.row][@"pay"]];
    
    //* 设置默认支付项目
    if([_arrDataSource[indexPath.row][@"sel"] intValue] == 2){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        if (self.block) {
            self.block(_arrDataSource[indexPath.row][@"id"]);
        }
    }else if([_arrDataSource[indexPath.row][@"sel"] intValue] == 1){
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int status = [_arrDataSource[indexPath.row][@"sel"] intValue];
    switch (status) {
        case 1:
        case 2:{
            [_arrDataSource[1] setObject:@"1" forKey:@"sel"];
            [_arrDataSource[0] setObject:@"1" forKey:@"sel"];
            [_arrDataSource[indexPath.row] setObject:@"2" forKey:@"sel"];
        }
            break;
    }
    
    [tableView reloadData];
    
    if (self.block) {
        self.block(_arrDataSource[indexPath.row][@"id"]);
    }
    
}







-(void)actionSetViewWith:(PaymentMoudle *)payMoudle ChooseBlock:(CommonReturnDataBlock)block{
    
    _tbvTableView.delegate = self;
    _tbvTableView.dataSource = self;
    self.block = block;
    self.payMoudle = payMoudle;
    //** 初始化数据源
    NSDictionary *dictAlipay = @{@"id":@"1",@"pay":@"支付宝钱包",@"ico":getImageWithRes(@"img_payment_zhifubao"),@"sel":@"1"};
    NSDictionary *dictWollet = @{@"id":@"2",@"pay":@"账户余额",@"ico":@"",@"sel":@"1"};
    NSMutableDictionary *muDictAliPay = [NSMutableDictionary dictionaryWithDictionary:dictAlipay];
    NSMutableDictionary *muDictWollet = [NSMutableDictionary dictionaryWithDictionary:dictWollet];
    _arrDataSource =  @[muDictAliPay,muDictWollet];
    
    // **账户支付
    if (payMoudle.totalAmount >= payMoudle.payAmont) {
        [_arrDataSource[1] setObject:@"2" forKey:@"sel"];
        [_arrDataSource[0] setObject:@"1" forKey:@"sel"];
    }else if(payMoudle.totalAmount < payMoudle.payAmont){
        [_arrDataSource[0] setObject:@"2" forKey:@"sel"];
        [_arrDataSource[1] setObject:@"0" forKey:@"sel"];
    }
    
    [_tbvTableView reloadData];
    
    PaymentChooseHeaderView *vTableViewHeader = getViewByNib(PaymentChooseHeaderView, self);
    [vTableViewHeader setPhone:payMoudle.userPhone];
    
    [_tbvTableView setTableHeaderView:vTableViewHeader];
    
}


@end

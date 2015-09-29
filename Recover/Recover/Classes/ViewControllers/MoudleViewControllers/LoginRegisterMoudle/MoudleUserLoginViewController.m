//
//  MoudleUserLoginViewController.m
//  BabySante
//
//  Created by dd on 15/4/14.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "MoudleUserLoginViewController.h"
#import "NetworkHandle.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "UIAlertView+Blocks.h"
#import "UIButton+Verify.h"

@interface MoudleUserLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txf_phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *txf_verifyCode;


@property (weak, nonatomic) IBOutlet UIView *v_OtherLog;


@end

@implementation MoudleUserLoginViewController

-(void)action_showDismissButton {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(action_cancel)];
}

- (void) action_cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return YES;
    }
    
    if (textField == _txf_phoneNumber && textField.text.length >= 11 && ![string isEqualToString:@""]) {
        return NO;
    }
    
    if (textField == _txf_verifyCode && textField.text.length >= 4 && ![string isEqualToString:@""]) {
        return NO;
    }
    
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9'))//数据格式正确
        {
            return YES;
        }else{
            return NO;
        }
    }
    
    return YES;
}

/**
 *  发送验证码
 */
- (IBAction)action_sendVerify:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (![CommonIO validateMobile:_txf_phoneNumber.text]) {
        [CommonHUD showHudWithMessage:@"手机号不正确" delay:CommonHudShowDuration completion:nil];
        return;
    }
    
    [sender unavailable];
    
    //发送验证码
    [NetworkHandle loadDataFromServerWithParamDic:@{@"phone":_txf_phoneNumber.text}
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/verification")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              [CommonHUD showHudWithMessage:@"发送成功" delay:CommonHudShowDuration completion:nil];
                                          }
                                          failure:nil
                                   networkFailure:nil];
}

/**
 *  登录
 */
- (IBAction)action_login {
    
    [self.view endEditing:YES];
    
    if (![CommonIO validateMobile:_txf_phoneNumber.text]) {
        [CommonHUD showHudWithMessage:@"手机号不正确" delay:CommonHudShowDuration completion:nil];
        return;
    }
    
//    if (_txf_verifyCode.text.length != 4) {
//        [CommonHUD showHudWithMessage:@"请输入四位验证码" delay:CommonHudShowDuration completion:nil];
//        return;
//    }

    [self action_loginWithData:@{@"phone":_txf_phoneNumber.text,
                                 @"verification":_txf_verifyCode.text}];
}

- (void) action_loginWithData:(NSDictionary *)data {
    
    WEAKSELF
    [NetworkHandle loadDataFromServerWithParamDic:data
                                          signDic:nil
                                    interfaceName:InterfaceAddressName(@"user/login")
                                          success:^(NSDictionary *responseDictionary, NSString *message) {
                                              [CommonUser userLoginSuccess:responseDictionary block:weakSelf.completionBlock];
                                          }
                                          failure:nil
                                   networkFailure:nil];
}


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action_bgTouched {
    [self.view endEditing:YES];
}

@end

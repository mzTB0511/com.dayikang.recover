//
//  SVModalWebViewController.m
//
//  Created by Oliver Letterer on 13.08.11.
//  Copyright 2011 Home. All rights reserved.
//
//  https://github.com/samvermette/SVWebViewController

#import "SVModalWebViewController.h"

#import "BaseNavigationViewController.h"
#import "MoudleUserLoginViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


#define FontOthers_CH(fontSize) [UIFont fontWithName:@"FZLTHJW--GB1-0" size:fontSize]
@interface SVModalWebViewController ()


@property(nonatomic,copy) ModalWebViewShareEventBlock shareEventBlock;


@end

@interface SVWebViewController (DoneButton)

- (void)doneButtonTapped:(id)sender;

@end


@implementation SVModalWebViewController

#pragma mark - Initialization


- (instancetype)initWithAddress:(NSString*)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL *)URL {
    return [self initWithURLRequest:[NSURLRequest requestWithURL:URL]];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)request {
    self.webViewController = [[SVWebViewController alloc] initWithURLRequest:request];
    if (self = [super initWithRootViewController:self.webViewController]) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self.webViewController
                                                                      action:@selector(doneButtonTapped:)];
        [doneButton setTintColor:[UIColor blackColor]];
        self.webViewController.navigationItem.leftBarButtonItem = doneButton;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    [[UIApplication sharedApplication]  setStatusBarHidden:NO];
    
//   [self.navigationBar setBarTintColor:SlideMenu_Color ];
    
    [self.navigationBar setBackgroundImage:[CommonIO imageWithColor:[UIColor whiteColor] size:CGSizeMake(mScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    
    //     self.webViewController.title =self.title;
    self.navigationBar.tintColor = self.barsTintColor;
    
}

-(void)viewDidLoad{
    WEAKSELF
    self.webViewController.webViewBlock = ^(UIWebView *webView,NSURLRequest *request){
        
            //**临时用户跳转到登录页面
            if (![CommonUser ifUserHasLogin]) {
                //展示信息后强制跳转到登录页

                BaseNavigationViewController *nvc = mLoadViewController(sbStoryBoard_MoudleUserLoginRegister, @"MoudleUserLoginRegisterNavigationController");
                MoudleUserLoginViewController *vc_login = (MoudleUserLoginViewController *)nvc.topViewController;
                [vc_login action_showDismissButton];
                
                [weakSelf presentViewController:nvc animated:YES completion:nil];
                
                vc_login.completionBlock = ^{
                    
                    [nvc dismissViewControllerAnimated:YES completion:nil];
                   //** 加载提交Hud
                    [CommonHUD showHudWithMessage:@"" delay:1.0f completion:^{
                        //*调用 JS 函数完成web页面 提交操作。
                        NSString *result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"showMask('%@');",[CommonUser userID]]];
                        
                        if ([result integerValue] ==1) {
                            [CommonHUD showHudWithMessage:@"谢谢您的参与" delay:1.0f completion:^{
                               [weakSelf dismissViewControllerAnimated:YES completion:nil];
                            }];
                            
                        }else{
                          //  [CommonHUD showHudWithMessage:@"出错了,请重试" delay:1.0f completion:nil];
                        }
                        
                    }];
                    
                   
                };

            }else{
               
                //*调用 JS 函数完成web页面 提交操作。
                NSString *result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"showMask('%@');",[CommonUser userID]]];
                
                if ([result integerValue] ==1) {
                    [CommonHUD showHudWithMessage:@"谢谢您的参与" delay:1.0f completion:^{
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    }];
                    
                }else{
                   // [CommonHUD showHudWithMessage:@"出错了,请重试" delay:1.0f completion:nil];
                }
            }
    };
    

}


// 设置Navigation bar title
-(void) setViewTitle:(NSString *)title
{
    // self.navigationItem.title = title;
    UIView *viewTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    viewTitle.backgroundColor = [UIColor clearColor];
    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 190, 40)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = title;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = self.barsTintColor;
    lblTitle.font = [UIFont boldSystemFontOfSize:20];
    [viewTitle addSubview:lblTitle];
    lblTitle.center = CGPointMake(viewTitle.frame.size.width/2, viewTitle.frame.size.height/2);
    self.webViewController.navigationItem.titleView =viewTitle;
    
}

/**
 *  显示分享按钮
 *
 *  @param title 分享按钮标题
 *  @param block 回调事件
 */
-(void) setNavigationBarRightItem:(NSString *)title shareBtnBlock:(ModalWebViewShareEventBlock)block{
    
    if (self.webViewController) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:title
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(action_ShareEvent:)];
        self.webViewController.navigationItem.rightBarButtonItem = doneButton;
        
        self.shareEventBlock = block;
    }
}

-(void)action_ShareEvent:(id)sender{
    if (self.shareEventBlock) {
        self.shareEventBlock(sender);
    }
}




@end

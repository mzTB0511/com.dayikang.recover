//
//  MainViewController.m
//  BabySante
//
//  Created by dd on 15/3/27.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "MainViewController.h"
#import "BaseNavigationViewController.h"
#import "MoudleUserLoginViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate,UITabBarDelegate>{
    NSInteger previewIndex;
}

@end

@implementation MainViewController

-(void)awakeFromNib {
    self.tabBar.tintColor = Color_System_Main_Color;
    [self setDelegate:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    previewIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    WEAKSELF
    if (viewController.tabBarItem.tag == 1 || viewController.tabBarItem.tag == 3 ) {
        // **已经登录，直接返回
        if ([CommonUser ifUserHasLogin]) {
            return YES;
        }
        BaseNavigationViewController *navBase  = getViewControllFromStoryBoard(StoryBoard_LoginRegsiter, BaseNavigationViewController);
        
        MoudleUserLoginViewController *loginView = getViewControllFromStoryBoard(StoryBoard_LoginRegsiter, MoudleUserLoginViewController);
        loginView.completionBlock = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            [self setSelectedIndex:previewIndex];
        };
        
        [loginView action_showDismissButton];
        navBase.viewControllers = @[loginView];
        
        [self presentViewController:navBase animated:YES completion:nil];
        
        previewIndex = viewController.tabBarItem.tag;
        return NO;
    }
    
    return YES;
    
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

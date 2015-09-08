//
//  BaseViewController.m
//
//  Created by dd .
//  Copyright (c) 2014年 YangXudong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Back Action

- (void) backToPrivousViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Life Cycle

- (NSString *) action_getSelfTitle {
    
    NSString *title = nil;
    
    if (self.title.length) {
        title = self.title;
    } else if (self.navigationItem.title.length) {
        title = self.navigationItem.title;
    } else {
        title = NSStringFromClass([self class]);
    }
    
    return title;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[self action_getSelfTitle]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[self action_getSelfTitle]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    //** 自定义View背景视图
    [self.view setBackgroundColor:Color_System_View_bgColor];
    
    /**
     *  自定义返回按钮
     */
    if (self.navigationController && [self.navigationController.viewControllers firstObject] != self)
    {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(backToPrivousViewController)];
        
        [self.navigationItem setLeftBarButtonItem:backButton];
    }
}


-(void)setEmptyRemindImageWithRes:(NSString *)res{

    UIImageView *imgView = (UIImageView *)[self.view viewWithTag:10000];
    if(!imgView.superview){
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:res]];
        [imageView setFrame:CGRectMake(0, 0, 224, 102)];
    
        [imageView setTag:10000];
        [imageView setCenter:CGPointMake(mScreenWidth/2, mScreenHeight/2 - 50)];//CGPointMake(self.view.center.x, self.view.center.y - 64)
        [self.view addSubview:imageView];
    }else{
        [imgView setCenter:CGPointMake(mScreenWidth/2, mScreenHeight/2 - 50)];
        [imgView setImage:[UIImage imageNamed:res]];
        [self.view bringSubviewToFront:imgView];
    }
    
    
}


-(void)removeEmptyRemindImage{
 
    UIImageView *imgView = (UIImageView *)[self.view viewWithTag:10000];
    
    if (imgView) {
        
        [imgView removeFromSuperview];
        
    }
    
}




@end

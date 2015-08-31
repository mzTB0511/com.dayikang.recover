//
//  RootViewController.m
//  
//
//  Created by  on 14-6-18.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
    
  //  [self customerNavigationBarItem];
}


/* 自定义 视图背景图*/
- (void)customerViewControllBgWithImage:(NSString *)imageRes{
    
    // 设置背景图片
    UIImage *image = [UIImage imageNamed:imageRes];
    self.view.layer.contents = (id) image.CGImage;
}

/* 自定义UINavigationBar 左键*/
-(void)customerLeftNavigationBarItemWithTitle:(NSString *)title andImageRes:(NSString *)resName{
    
   // UIView *ok_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 40)];
   // [ok_View setBackgroundColor:[UIColor greenColor]];
    UIButton *btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_back setTag:2];
    
    [btn_back setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    
    [btn_back setFrame:CGRectMake(0, 0, 50, 40)];
    
    if (title){
        btn_back.titleLabel.font = FontOthers_CH(15);
       [btn_back setTitle:title forState:UIControlStateNormal];
       [btn_back setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0,17)];
    }
    
    if (resName){
        
       [btn_back setImage:[UIImage imageNamed:resName] forState:UIControlStateNormal];
       [btn_back setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",resName]] forState:UIControlStateHighlighted];
       [btn_back setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0,20)];
    }
    

    [btn_back addTarget:self action:@selector(backToView) forControlEvents:UIControlEventTouchUpInside];
   // [ok_View addSubview:btn_back];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn_back];
    self.navigationItem.leftBarButtonItem = barItem;
    
}

/* 自定义UINavigationBar 右键*/
-(void)customerRightNavigationBarItemWithTitle:(NSString *)title andImageRes:(NSString *)resName{
    
    //UIView *right_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 40)];
    UIButton *btn_Right = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_Right setTag:2];
    
    [btn_Right setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    
    [btn_Right setFrame:CGRectMake(0, 0, 50, 40)];
   // [btn_Right setBackgroundColor:[UIColor redColor]];
    
    if (title){
        btn_Right.titleLabel.font = FontOthers_CH(15);
        [btn_Right setTitle:title forState:UIControlStateNormal];
        [btn_Right setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0,-15)];
    }
    
    if (resName){
        
        [btn_Right setImage:[UIImage imageNamed:resName] forState:UIControlStateNormal];
        [btn_Right setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",resName]] forState:UIControlStateHighlighted];
        [btn_Right setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0,-15)];
    }
    
    
    [btn_Right addTarget:self action:@selector(navigationRightItemEvent) forControlEvents:UIControlEventTouchUpInside];
   // [right_View addSubview:btn_Right];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn_Right];
    self.navigationItem.rightBarButtonItem = barItem;
    
}

-(void)backToView{
 

    [self.navigationController popViewControllerAnimated:YES];
}


-(void)navigationRightItemEvent{
    
    NSLog(@"RigthItem ClientEvent");
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

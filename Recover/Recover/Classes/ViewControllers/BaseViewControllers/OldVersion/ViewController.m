//
//  ViewController.m
//  
//
//  Created by  on 14-6-26.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

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
    [self.view setBackgroundColor:getColorWithRGBA(242, 242, 242, 1)];

//       [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置Navigation bar title
-(void) setViewTitle:(NSString *)title
{
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,
                                [UIFont boldSystemFontOfSize:19],
                                NSFontAttributeName,
                                nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationItem.title = title;
    
}


-(void)setEmptyHintMessage:(NSString *)message{
    
    NSString *msg =@"";
    
    if (!message) {
        msg = @"空空如也";
    }else{
        msg = message;
    }
    
    UILabel *label = (UILabel *)[self.view viewWithTag:10000];
    if(!label.superview){
        UILabel *label_Hint = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 30)];
        [label_Hint setBackgroundColor:[UIColor clearColor]];
        [label_Hint setText:msg];
        [label_Hint setFont:FontOthers_CH(20)];
        [label_Hint setCenter:CGPointMake(mScreenWidth/2, mScreenHeight/2 - 50)];
        [label_Hint setTextColor:[UIColor colorWithRed:222.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
        [label_Hint setTextAlignment:NSTextAlignmentCenter];
        [label_Hint setTag:10000];
        [self.view addSubview:label_Hint];
    }else{
        [label setText:msg];
        [label setFont:FontOthers_CH(20)];
    }
    
    
}

-(void)removeEmptyHint{
    
    UILabel *label = (UILabel *)[self.view viewWithTag:10000];
    [label removeFromSuperview];
}


@end

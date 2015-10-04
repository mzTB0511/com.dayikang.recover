//
//  LXCommendStartView.m
//  Recover
//
//  Created by 刘轩 on 15/9/20.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "LXCommendStartView.h"
@interface LXCommendStartView()

@property(nonatomic,copy) LXCommendStartViewBlock block;

@property(nonatomic,strong)NSMutableArray *muArrStar;

@end


@implementation LXCommendStartView



-(id)initWithCommendStartFrame:(CGRect)frame StartNum:(NSInteger)nums ChooseBlock:(LXCommendStartViewBlock)block{
   
    if (self = [self initWithFrame:frame]) {
        _block = block;
        _muArrStar = [NSMutableArray array];
        [self initWithCommendStartViewFrame:frame StartNums:nums];
    }
    
    return self;
    
}



- (void)initWithCommendStartViewFrame:(CGRect)frame StartNums:(NSInteger)nums{
    
    int starW = frame.size.height * 0.75;
    int starH = starW;
    int starSec = 10;
    for (int i = 0; i<nums; i++) {
        UIButton *btnStr = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnStr setImage:getImageWithRes(@"img_Commend_Moudle_Star") forState:UIControlStateNormal];
        [btnStr setImage:getImageWithRes(@"img_Commend_Moudle_Star_Sel") forState:UIControlStateSelected];
        [btnStr setTag:i+1];
        [btnStr setFrame:CGRectMake(i*starSec + i*starW, (frame.size.height - starH) / 2, starW, starH)];
        [btnStr addTarget:self action:@selector(actionStarTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_muArrStar addObject:btnStr];
        [self addSubview:btnStr];
    }
    
}


-(void)actionStarTouchEvent:(UIButton *)btn{
    /**
     *  1.初始化星星状态值
        2.重置高亮状态 
        3.设置回调时间
     */
    [_muArrStar enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btnStar = (UIButton *)obj;
        if (btnStar.tag <= btn.tag) {
            [btnStar setSelected:YES];
        }else{
           [btnStar setSelected:NO];
        }
        
    }];
    
    if (self.block) {
        self.block(btn.tag);
    }
    
}



@end

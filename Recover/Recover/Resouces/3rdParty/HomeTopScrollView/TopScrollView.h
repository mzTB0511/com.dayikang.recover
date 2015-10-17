//
//  TopScrollView.h
//  笨笨
//
//  Created by Appying on 14/11/19.
//  Copyright (c) 2014年 上海笨笨网络 by:chenzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EScrollerViewDelegate <NSObject>
@optional
-(void)EScrollerViewDidClicked:(NSString *)index;
@end
@interface TopScrollView : UIView<UIScrollViewDelegate>
{
    CGRect viewSize;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    id<EScrollerViewDelegate> delegate;
    int currentPageIndex;
    NSTimer *myTimer;
    BOOL _isTimeUp;
    UIImageView *backgroundImage1;
    UIImageView *backgroundImage2;
    NSInteger _times;
    NSArray * imageArray;
}
@property (nonatomic,strong)NSMutableArray *dicDataArray;
@property(nonatomic,strong)id<EScrollerViewDelegate> delegate;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSMutableArray *)dataArray changeTimes : (NSInteger)times;
@end

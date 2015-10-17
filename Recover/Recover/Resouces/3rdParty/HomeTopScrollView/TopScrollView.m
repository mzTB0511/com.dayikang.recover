//
//  TopScrollView.m
//  笨笨
//
//  Created by Appying on 14/11/19.
//  Copyright (c) 2014年 上海笨笨网络 by:chenzhen. All rights reserved.
//

#import "TopScrollView.h"
#import "UIImageView+WebCache.h"

@implementation TopScrollView
@synthesize delegate;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSMutableArray *)dataArray changeTimes : (NSInteger)times
{
    if ((self=[super initWithFrame:rect])) {
       
        _dicDataArray = dataArray;
        _times = times;
        
          viewSize=rect;
        
        NSMutableArray *tempArray=[NSMutableArray arrayWithArray:_dicDataArray];
          scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height+64)];
        if (_dicDataArray.count > 1) {
            [tempArray insertObject:[_dicDataArray objectAtIndex:([_dicDataArray count]-1)] atIndex:0];
            [tempArray addObject:[_dicDataArray objectAtIndex:0]];
        }
        imageArray =[NSArray arrayWithArray:tempArray];
      
        NSUInteger pageCount=[imageArray count];
        
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, 1);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        
        for (int i=0; i<pageCount; i++) {
            NSString *imgURL=[imageArray objectAtIndex:i];
            UIImageView *imgView=[[UIImageView alloc] init];
            
           
            
            if ([imgURL hasPrefix:@"http://"]) {


                [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"pic_banner_01"]];
                
            }
            else
            {
                
                UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
              
                [imgView setImage:img];
            }
            [imgView setFrame:CGRectMake(viewSize.size.width*i, 0,mScreenWidth, viewSize.size.height)];
            [imgView setContentMode:UIViewContentModeScaleAspectFill
             ];
            
            

            UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
            [Tap setNumberOfTapsRequired:1];
            [Tap setNumberOfTouchesRequired:1];
            imgView.userInteractionEnabled=YES;
            
            if (pageCount >1) {
                        imgView.tag = i - 1;
            }else{
                imgView.tag = i;
            }

            [imgView addGestureRecognizer:Tap];
            [scrollView addSubview:imgView];
        }
       
        [self addSubview:scrollView];
        
         //自动滚动
        if (pageCount > 1) {
            UIView *noteView=[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-15,self.bounds.size.width,15)];
            //        [noteView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5]];
            
            float pageControlWidth=(pageCount-2)*10.0f+40.f;
            float pagecontrolHeight=20.0f;
            pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(mScreenWidth/2-pageControlWidth/2,-2, pageControlWidth, pagecontrolHeight)];
            pageControl.currentPage=0;
            pageControl.selected = NO;
            pageControl.opaque = YES;
            pageControl.numberOfPages=(pageCount-2);
            pageControl.currentPageIndicatorTintColor = Color_System_Tint_Color;
            pageControl.pageIndicatorTintColor = [UIColor whiteColor];
            [noteView addSubview:pageControl];
            [self addSubview:noteView];
            

            scrollView.frame  = CGRectMake(0, -64, mScreenWidth, viewSize.size.height+64);
            [scrollView setContentOffset:CGPointMake(viewSize.size.width, -64)];
             myTimer = [NSTimer scheduledTimerWithTimeInterval:times target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        }
      
    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{

    [sender setContentOffset:CGPointMake(sender.contentOffset.x, -64)];
    CGFloat pageWidth = scrollView.frame.size.width;
    
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    
    pageControl.currentPage=(page-1);

  
}



//-(void)updateScrollView : (NSInteger)times{
//    
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        myTimer = [NSTimer scheduledTimerWithTimeInterval:times target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop]run];
//    });
//    
//}


-(void)animalMoveImage{
    CGPoint pt = scrollView.contentOffset;
    NSInteger count = [imageArray count];
  
    if(pt.x == mScreenWidth * (count - 2)){

        [scrollView setContentOffset:CGPointMake(0, -64)];
        [scrollView scrollRectToVisible:CGRectMake(mScreenWidth,0,mScreenWidth,viewSize.size.height) animated:YES];
    }else{
        [scrollView scrollRectToVisible:CGRectMake(pt.x+mScreenWidth,0,mScreenWidth,viewSize.size.height) animated:YES];
    }
    

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    if (currentPageIndex==0) {
        
        [_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, -64)];
    }
    if (currentPageIndex==([imageArray count]-1)) {
        
        [_scrollView setContentOffset:CGPointMake(viewSize.size.width, -64)];
        
    }
    
    [myTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_times]];

}

- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    
    if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
        
        [delegate EScrollerViewDidClicked:[NSString stringWithFormat:@"%zi",sender.view.tag]];
    }
}

@end

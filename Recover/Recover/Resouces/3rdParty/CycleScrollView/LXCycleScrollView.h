//
//  XLCycleScrollView.h
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXCycleScrollViewDelegate;
@protocol LXCycleScrollViewDatasource;

@interface LXCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<LXCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<LXCycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end

@protocol LXCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(LXCycleScrollView *)csView atIndex:(NSInteger)index;

@end

@protocol LXCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end

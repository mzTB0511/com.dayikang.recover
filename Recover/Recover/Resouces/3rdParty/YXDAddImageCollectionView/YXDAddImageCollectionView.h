//
//  YXDAddImageCollectionView.h
//  BabySante
//
//  Created by YangXudong on 15/6/10.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXDAddImageCollectionView : UIView

+ (YXDAddImageCollectionView *) viewWithFrame:(CGRect)frame
                      containerViewController:(UIViewController *)container;

- (NSArray *) images;

@end

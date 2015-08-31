//
//  YXDAddImageCollectionViewCell.h
//  BabySante
//
//  Created by YangXudong on 15/6/10.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXDAddImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIImage *image;

- (void) action_setupCellWithImage:(UIImage *)image index:(NSInteger)index;

@end

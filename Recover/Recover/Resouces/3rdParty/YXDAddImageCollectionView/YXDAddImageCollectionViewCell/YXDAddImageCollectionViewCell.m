//
//  YXDAddImageCollectionViewCell.m
//  BabySante
//
//  Created by YangXudong on 15/6/10.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "YXDAddImageCollectionViewCell.h"

@interface YXDAddImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imv_imageView;

@end

@implementation YXDAddImageCollectionViewCell

-(UIImage *)image{
    return self.imv_imageView.image;
}

-(void)action_setupCellWithImage:(UIImage *)image index:(NSInteger)index {
    self.imv_imageView.image = image;
    self.index = index;
}

- (void)awakeFromNib {
    // Initialization code
}

@end

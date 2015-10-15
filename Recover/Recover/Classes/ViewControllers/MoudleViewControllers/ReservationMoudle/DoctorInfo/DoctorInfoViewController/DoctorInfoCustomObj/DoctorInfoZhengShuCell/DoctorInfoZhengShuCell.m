//
//  DoctorInfoZhengShuCell.m
//  Recover
//
//  Created by 刘轩 on 15/9/19.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "DoctorInfoZhengShuCell.h"
#import "DoctorInfoZhengShuCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface DoctorInfoZhengShuCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(copy,nonatomic) DoctorInfoZhzengShuBlock doctorZSBlock;

@property (weak, nonatomic) IBOutlet UICollectionView *collectZiZhiView;

@property(nonatomic,strong) NSArray *arrDataSource;

@end


@implementation DoctorInfoZhengShuCell

- (void)awakeFromNib {
    mRegisterNib_CollectionView(_collectZiZhiView, DoctorInfoZhengShuCollectionViewCell);

  }


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrDataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DoctorInfoZhengShuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DoctorInfoZhengShuCollectionViewCell" forIndexPath:indexPath];
    [cell.imgDocZhengShu sd_setImageWithURL:getUrlWithStrValue(_arrDataSource[indexPath.row][@"img_url"]) placeholderImage:getImageWithRes(@"img_Default_UserIco_Boys")];
 
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DoctorInfoZhengShuCollectionViewCell *cell = (DoctorInfoZhengShuCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (self.doctorZSBlock && cell.imgDocZhengShu) {
        self.doctorZSBlock(cell.imgDocZhengShu);
    }
    
}


-(void)actionSetCellData:(NSArray *)list CollectionViewBlock:(DoctorInfoZhzengShuBlock)block{
 
    self.doctorZSBlock = block;
    self.arrDataSource = list;
    self.collectZiZhiView.dataSource = self;
    self.collectZiZhiView.delegate = self;
    [self.collectZiZhiView reloadData];
    
}



@end

//
//  YXDAddImageCollectionView.m
//  BabySante
//
//  Created by YangXudong on 15/6/10.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#define YXDAddImageCollectionView_Max_Images_Count          3

#import "YXDAddImageCollectionView.h"
#import "YXDAddImageCollectionViewCell.h"
#import "UIActionSheet+Blocks.h"
#import "UIViewController+ImagePicker.h"

@interface YXDAddImageCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UIViewController *container;

@property (nonatomic, strong) UICollectionView *clv_collectionView;

@property (nonatomic, strong) NSMutableArray *arr_images;

@end

@implementation YXDAddImageCollectionView

+ (YXDAddImageCollectionView *)viewWithFrame:(CGRect)frame containerViewController:(UIViewController *)container {
    
    YXDAddImageCollectionView *view = [[YXDAddImageCollectionView alloc] initWithFrame:frame];
    
    view.container = container;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(78, 78);
    layout.minimumInteritemSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    view.clv_collectionView = [[UICollectionView alloc] initWithFrame:view.bounds collectionViewLayout:layout];
    view.clv_collectionView.dataSource = view;
    view.clv_collectionView.delegate = view;
    view.clv_collectionView.bounces = NO;
    view.clv_collectionView.backgroundColor = Color_System_View_bgColor;
    
    [view addSubview:view.clv_collectionView];
    
    mRegisterNib_CollectionView(view.clv_collectionView, @"YXDAddImageCollectionViewCell");
    
    return view;
}

- (NSArray *)images {
    if (_arr_images.count) {
        return _arr_images;
    }
    return nil;
}

#pragma mark - Long Press Gesture

- (void) action_longPressAction:(UILongPressGestureRecognizer *)longPressGesture {
    
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        
        NSInteger cellIndex = ((YXDAddImageCollectionViewCell *)(longPressGesture.view)).index;
        
        if (cellIndex < _arr_images.count) {
            WEAKSELF
            [UIActionSheet presentOnView:_container.view
                               withTitle:nil
                            cancelButton:@"取消"
                       destructiveButton:nil
                            otherButtons:@[@"删除"]
                                onCancel:nil
                           onDestructive:nil
                         onClickedButton:^(UIActionSheet *sheet, NSUInteger index) {
                             if (index == 0) {
                                 [weakSelf.arr_images removeObjectAtIndex:cellIndex];
                                 [weakSelf.clv_collectionView reloadData];
                             }
                         }];
        }
    }
}

#pragma mark - Data Source & Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == _arr_images.count) {//点击的是加号➕
        //弹出让用户选择图片
        
        WEAKSELF
        [_container imageByCameraAndPhotosAlbumWithActionSheetUsingBlock:^(UIImage *image, NSString *imageName, NSString *imagePath) {
            
            if (!weakSelf.arr_images) {
                weakSelf.arr_images = [NSMutableArray array];
            }
            
            [weakSelf.arr_images addObject:image];
            [weakSelf.clv_collectionView reloadData];
        }];
        
    } else { //点击的是图片
        //全屏显示
        YXDAddImageCollectionViewCell *cell = (YXDAddImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        [CommonIO showImage:cell.image bgColor:[UIColor blackColor]];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXDAddImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YXDAddImageCollectionViewCell" forIndexPath:indexPath];
    
    UIImage *image = nil;
    
    if (indexPath.row == _arr_images.count) {
        image = [UIImage imageNamed:@"img_moudle_fourth_add_picture"];
    } else {
        image = _arr_images[indexPath.row];
    }
    
    [cell action_setupCellWithImage:image index:indexPath.row];
    
    if (!cell.gestureRecognizers.count) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(action_longPressAction:)];
        [cell addGestureRecognizer:longPress];
    }
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (_arr_images.count == YXDAddImageCollectionView_Max_Images_Count)?YXDAddImageCollectionView_Max_Images_Count:(_arr_images.count+1);
}

@end

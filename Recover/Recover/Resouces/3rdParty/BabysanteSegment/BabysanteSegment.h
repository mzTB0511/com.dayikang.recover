//
//  BabysanteSegmentView.h
//  BabysanteSegment
//
//  Created by 刘轩 on 15/9/9.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>

#define mColorWithRGB(r, g, b)          [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
//屏幕尺寸
#define mScreen_Width          ([UIScreen mainScreen].bounds.size.width)
#define mScreen_Height         ([UIScreen mainScreen].bounds.size.height)


/**
 *  初始化Segment Moudle
 */
@interface MenuMoudle : NSObject

/**
 *  菜单文字颜色
 */
@property(nonatomic,strong) UIColor *itemColor;
/**
 *  菜单选中颜色
 */
@property(nonatomic,strong) UIColor *itemSelColor;
/**
 *  背景颜色
 */
@property(nonatomic,strong) UIColor *segmentBgColor;

@end

typedef void(^BabysanteSegMentViewBlock)(NSString *menuIndex,NSString *subMenuIndex);
@interface BabysanteSegment : UIView

-(id)initBabysanteSegmentViewFrame:(CGRect)frame MenuMoudle:(MenuMoudle *)menuMoudle AndMenuItems:(NSArray *)menus WithBabysanteSegmentBlock:(BabysanteSegMentViewBlock)block;


@end

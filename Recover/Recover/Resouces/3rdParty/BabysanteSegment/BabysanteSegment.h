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


/**
 *  初始化Segrement 控件
 *
 *  @param frame      frame 视图
 *  @param menuMoudle 初始化数据
 *  @param menus      包含的才当项目
 *  @param block      选中项目后的回调事件
 *
 *  @return 自定义Segrement 控件
 */
-(id)initBabysanteSegmentViewFrame:(CGRect)frame MenuMoudle:(MenuMoudle *)menuMoudle AndMenuItems:(NSArray *)menus WithBabysanteSegmentBlock:(BabysanteSegMentViewBlock)block;



/**
 *  设置Segrement 默认选中项目
 *
 *  @param obj 默认项目数据
 */
-(void)setDefaultSecItem:(NSObject *)obj;


@end

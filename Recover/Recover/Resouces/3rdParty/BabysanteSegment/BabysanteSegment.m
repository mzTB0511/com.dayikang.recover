//
//  BabysanteSegmentView.m
//  BabysanteSegment
//
//  Created by 刘轩 on 15/9/9.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "BabysanteSegment.h"
#import "SegmentItem.h"
#import "UIButton+block.h"


@implementation MenuMoudle

@end


@interface BabysanteSegment()

@property(nonatomic, copy) BabysanteSegMentViewBlock block;

@property(nonatomic, strong) NSArray *arrMenuItems;

@property(nonatomic, strong) NSArray *arrSubMenuItems;

@property(nonatomic, strong) UILabel *lbSelectionIndicator;

@property(nonatomic, strong) UIView *vSubMenuView;

@property(nonatomic, strong) UIScrollView *scrollSubMenu;


@property(nonatomic, strong) UIView *vBackgroundView;

@property(nonatomic, assign) BOOL hasDropDown;


@end

@implementation BabysanteSegment


-(id)initBabysanteSegmentViewFrame:(CGRect)frame MenuMoudle:(MenuMoudle *)menuMoudle AndMenuItems:(NSArray *)menus WithBabysanteSegmentBlock:(BabysanteSegMentViewBlock)block{
    
    if (self = [self initWithFrame:frame]) {
        _arrMenuItems = menus;
        _block = block;
        _hasDropDown = NO;
        [self initWithBabysanteSegViewWith:menuMoudle Menus:menus];
        self.clipsToBounds = YES;
    }
    
    return self;
    
}


-(void)initWithBabysanteSegViewWith:(MenuMoudle *)moudle Menus:(NSArray *)menus{
    
    MenuMoudle *menuMoudle;
    if (moudle) {
        menuMoudle = moudle;
    }else{
        menuMoudle = [MenuMoudle new];
        [menuMoudle setItemColor:[UIColor blackColor]];
        [menuMoudle setItemSelColor:mColorWithRGB(48,154,161)];
        [menuMoudle setSegmentBgColor:mColorWithRGB(232,232,232)];
    }
    
     CGFloat item_W = (mScreen_Width - menus.count*1)/ menus.count;
    _lbSelectionIndicator = [UILabel new];
    [_lbSelectionIndicator setBackgroundColor:menuMoudle.itemSelColor];
    [_lbSelectionIndicator setFrame:CGRectMake(0, 0, item_W, 2)];
    /**
     1.初始化菜单
     2.加载二级菜单视图
     */
    self.backgroundColor =menuMoudle.segmentBgColor;
    
    for (int i = 0; i<menus.count; i++) {
        SegmentItem *segItem = (SegmentItem *)menus[i];
        UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeSystem];
        [btnMenu setFrame:CGRectMake(1*i + item_W*i, 1, item_W, self.frame.size.height - 2)];
        [btnMenu setTitle:segItem.name forState:UIControlStateNormal];
        [btnMenu setTitleColor:menuMoudle.itemColor forState:UIControlStateNormal];
        [btnMenu setTitleColor:menuMoudle.itemSelColor forState:UIControlStateSelected];
        [btnMenu setTag:[segItem.menuID intValue]];
        [btnMenu setBackgroundColor:[UIColor whiteColor]];
        [btnMenu setTintColor:[UIColor clearColor]];
        [self addSubview:btnMenu];
        [btnMenu handleControlEvent:UIControlEventTouchUpInside withBlock:^(NSInteger tag) {
            //**处理菜单选中事件，IndicatorView
            [self actionSetMenuStatusAndIndicatorWith:_arrMenuItems currentMenuTag:tag];
            //** 点击按钮事件验证是否需要加载子menu
            if (segItem.arrSubMenuList) {
                
                [self fillSubMenusWith:segItem];
                if (_block) {
                    self.block(@"",@"");//[NSString stringWithFormat:@"%li",(long)tag]
                }
            }else{
                
                if (_block) {
                    self.block(segItem.menuID,@"");//[NSString stringWithFormat:@"%li",(long)tag]
                }
            }
            
            
        }];
        
    }
    
    // **绘制二级菜单视图
    _vSubMenuView = [UIView new];
    [_vSubMenuView setFrame:CGRectMake(0, self.frame.size.height , mScreen_Width, 44)];
    [self addSubview:_vSubMenuView];
    [_vSubMenuView setBackgroundColor:[UIColor whiteColor]];
    
}


-(void)actionSetMenuStatusAndIndicatorWith:(NSArray *)menuItems currentMenuTag:(NSInteger)menuTag{
    /**
     1.遍历菜单对象重置为初始状态,清理Indicator 对象
     2.高亮当前选中菜单状态
     */
    [menuItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj) {
            SegmentItem *segMent = (SegmentItem *)obj;
            UIButton *btn = (UIButton *)[self viewWithTag:[segMent.menuID intValue]];
            [btn setSelected:NO];
        }
    }];
    
    UIButton *btn = (UIButton *)[self viewWithTag:menuTag];
    [btn setSelected:YES];
    
    //**处理IndicatorView
    if ([_lbSelectionIndicator superview]) {
        [_lbSelectionIndicator removeFromSuperview];
    }
    
    [btn addSubview:_lbSelectionIndicator];
    [_lbSelectionIndicator setCenter:CGPointMake(btn.frame.size.width /2, btn.frame.size.height )];
 
}


-(void)fillSubMenusWith:(SegmentItem *)segItem{
   
    if (_vSubMenuView.subviews.count > 0) {
        for (NSObject *obj in _vSubMenuView.subviews) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *btnSubMenu = (UIButton *)obj;
                [btnSubMenu removeFromSuperview];
            }
        }
   
    }
    
    // 重新加载子菜单
    CGFloat item_W = mScreen_Width/segItem.arrSubMenuList.count * 0.5;
    for (int i = 0; i<segItem.arrSubMenuList.count; i++) {
        NSDictionary *menuItem = (NSDictionary *)segItem.arrSubMenuList[i];
        UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeSystem];
        [btnMenu setFrame:CGRectMake(0,0,item_W,38)];
        [btnMenu setTitle:menuItem[@"name"] forState:UIControlStateNormal];
        [btnMenu setTag:[menuItem[@"id"] intValue]];
        [btnMenu setBackgroundColor:[UIColor whiteColor]];
        int nums = (int)segItem.arrSubMenuList.count * 2;
        CGFloat posX = (i*2+1.0)/nums*mScreen_Width;
        [btnMenu setCenter:CGPointMake(posX, _vSubMenuView.frame.size.height / 2)];
        
        [_vSubMenuView addSubview:btnMenu];
        
        [btnMenu handleControlEvent:UIControlEventTouchUpInside withBlock:^(NSInteger tag) {
            //** 点击按钮事件验证是否需要加载子menu
            if (_block) {
               self.block(segItem.menuID,[NSString stringWithFormat:@"%li",(long)tag]);
            }
            
        }];
        
    }
    
}





@end

//
//  UIButton+block.h
//  BabysanteSegment
//
//  Created by 刘轩 on 15/9/9.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^BabysanteButtonBlock)(NSInteger tag);

@interface UIButton (block)

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(BabysanteButtonBlock)action;

@end

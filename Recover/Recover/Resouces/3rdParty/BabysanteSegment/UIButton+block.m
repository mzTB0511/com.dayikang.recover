//
//  UIButton+block.m
//  BabysanteSegment
//
//  Created by 刘轩 on 15/9/9.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import "UIButton+block.h"

@implementation UIButton (block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(BabysanteButtonBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}


- (void)callActionBlock:(id)sender {
    BabysanteButtonBlock block = (BabysanteButtonBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block){
        block(((UIButton *)sender).tag);
    }
}

@end

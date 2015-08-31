//
//  SVModalWebViewController.h
//
//  Created by Oliver Letterer on 13.08.11.
//  Copyright 2011 Home. All rights reserved.
//
//  https://github.com/samvermette/SVWebViewController

#import <UIKit/UIKit.h>
#import "SVWebViewController.h"

typedef void(^ModalWebViewShareEventBlock)(id sender);

@interface SVModalWebViewController : UINavigationController

- (instancetype)initWithAddress:(NSString*)urlString;
- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)initWithURLRequest:(NSURLRequest *)request;

@property (nonatomic, strong) UIColor *barsTintColor;
@property (nonatomic, strong) SVWebViewController *webViewController;

// 设置Navigation bar title
-(void) setViewTitle:(NSString *)title;


/**
 *  显示分享按钮
 *
 *  @param title 分享按钮标题
 *  @param block 回调事件
 */
-(void) setNavigationBarRightItem:(NSString *)title shareBtnBlock:(ModalWebViewShareEventBlock)block;


@end

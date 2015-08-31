//
//  SVWebViewController.h
//
//  Created by Sam Vermette on 08.11.10.
//  Copyright 2010 Sam Vermette. All rights reserved.
//
//  https://github.com/samvermette/SVWebViewController
/**
 *  Web页面调用用户登录回调
 *
 *  @param UIWebView    ViewView 对象
 *  @param NSURLRequest request 对象
 */
typedef void(^WebViewShouldLoadBlock)(UIWebView *,NSURLRequest *);


/**
 *  Web页面用户调用分享回调
 *
 *  @param UIWebView    ViewView 对象
 *  @param NSURLRequest request 对象
 */
typedef void(^WebViewComplateAcivityShareBlock)(UIWebView *,NSURLRequest *);



@interface SVWebViewController : UIViewController

- (instancetype)initWithAddress:(NSString*)urlString;
- (instancetype)initWithURL:(NSURL*)URL;
- (instancetype)initWithURLRequest:(NSURLRequest *)request;

@property(nonatomic,copy)WebViewShouldLoadBlock webViewBlock;
@property(nonatomic,copy)WebViewComplateAcivityShareBlock webViewShareBlock;


@end

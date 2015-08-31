//
//  CommonWebView.h
//  BabySante
//
//  Created by 刘轩 on 15/8/20.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonWebView : NSObject


/**
 *  拼接完整的Url地址
 *
 *  @param interface 接口名
 *  @param condation 其他参数
 *
 *  @return 完整的Url地址
 */
+(NSString *)actionMakeWebUrl:(NSString *)interface AndParamDict:(NSDictionary *)condation;




/**
 *  PresentViewController 页面到微信朋友圈
 *
 *  @param urlString  页面地址
 *  @param title      页面NavigationBar标题
 *  @param isShare    是否可以分享
 *  @param imgUrl     分享出去的图片
 *  @param shareTitle 分享出去内容标题
 *  @param content    分享出去内容
 */
+(void) actionPresentWebViewControllerWithURL:(NSString *)urlString NavigationTitle:(NSString *)title allowShare:(NSString *)isShare shareImage:(id)imgUrl shareTitle:(NSString *)shareTitle shareContent:(NSString *)content LinkUrl:(NSString *)linkUrl;



/**
 *  弹出WebView
 *
 *  @param urlString web页面请求地址
 *  @param title     web页面标题
 */
+(void) actionPresentWebViewControllerWithURL:(NSString *)urlString NavigationTitle:(NSString *)title;



@end

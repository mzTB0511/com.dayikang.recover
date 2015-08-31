//
//  CommonWebView.m
//  BabySante
//
//  Created by 刘轩 on 15/8/20.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "CommonWebView.h"
#import "SVModalWebViewController.h"
#import "UMSocial.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NetworkHandle.h"
#import "CommonUser.h"
#import "AppDelegate.h"


@implementation CommonWebView


/**
 *  拼接完整的Url地址
 *
 *  @param interface 接口名
 *  @param condation 其他参数
 *
 *  @return 完整的Url地址
 */
+(NSString *)actionMakeWebUrl:(NSString *)interface AndParamDict:(NSDictionary *)condation{
    
    // 参数类型
    NSDictionary *postDict = [NetworkHandle makePostParamsWithParamDic:nil AndSignDict:nil];
    NSString *signature = [postDict objectForKey:App_Sign];
    NSString *userID = [CommonUser userID];
    NSString *UDID = [CommonUser udid];
    NSString *app_Version = [CommonIO appVersion];
    
    //等待拼接的参数字符串
    NSString *strUrl =[NSString stringWithFormat:@"%@?userID=%@&platformID=%@&version=%@&signature=%@&udid=%@",interface,userID,@"1",app_Version,signature,UDID];
    
    if (condation) {
        
        //需加密字典的key值数组
        NSArray *arr_keys = [condation.allKeys copy];
        
        //按升序排列
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
        
        //排序以后的数组
        arr_keys = [arr_keys sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        //遍历数组 拼接参数字符串
        for (NSString *aKey in arr_keys)
        {
            strUrl = [strUrl stringByAppendingString:[NSString stringWithFormat:@"&%@=%@&",aKey,[condation objectForKey:aKey]]];
        }
        
        strUrl = [strUrl substringToIndex:[strUrl length] - 1];
        
    }
    
    return strUrl;
}




/**
 *  弹出WebView
 *
 *  @param urlString web页面请求地址
 *  @param title     web页面标题
 */
+(void) actionPresentWebViewControllerWithURL:(NSString *)urlString NavigationTitle:(NSString *)title{
    
    [CommonWebView actionPresentWebViewControllerWithURL:urlString NavigationTitle:title allowShare:@"0" shareImage:nil shareTitle:@"" shareContent:@"" LinkUrl:@""];
}




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
+ (void) actionPresentWebViewControllerWithURL:(NSString *)urlString NavigationTitle:(NSString *)title allowShare:(NSString *)isShare shareImage:(id)imgUrl shareTitle:(NSString *)shareTitle shareContent:(NSString *)content LinkUrl:(NSString *)linkUrl{
    
    __block SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:[NSURL URLWithString:urlString]];
    webViewController.barsTintColor=[UIColor whiteColor];
    [webViewController setViewTitle:title];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabController = (UITabBarController *)delegate.window.rootViewController;
    
    if ([isShare intValue] == 1) {
        
        UIImageView *shareImage = [UIImageView new];
       
        if (!imgUrl) {
            shareImage = nil;
        } else if ([imgUrl isKindOfClass:[UIImage class]]) {
            shareImage = imgUrl;
        }else{
            [shareImage setFrame:CGRectMake(0, 0, 100, 100)];
            shareImage.contentMode = UIViewContentModeScaleAspectFill;
            [shareImage sd_setImageWithURL:getUrlWithStrValue(imgUrl) placeholderImage:getImageWithRes(@"AppIcon")];
        }
        
        
        [webViewController setNavigationBarRightItem:@"分享" shareBtnBlock:^(id sender) {
            //**分享按钮点击回调事件
            [UMSocialData defaultData].extConfig.wechatSessionData.url = linkUrl;
            [UMSocialData defaultData].extConfig.wechatSessionData.title = shareTitle;
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = linkUrl;
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareTitle;
            
            NSArray *arr_SnsList = @[UMShareToWechatSession,UMShareToWechatTimeline];
            [UMSocialSnsService presentSnsIconSheetView:webViewController appKey:UMeng_App_Key shareText:content shareImage:shareImage.image shareToSnsNames:arr_SnsList delegate:nil];
            
        }];
        
        webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
        
        
        webViewController.webViewController.webViewShareBlock = ^(UIWebView *webView,NSURLRequest *request){
            //**分享按钮点击回调事件
            [UMSocialData defaultData].extConfig.wechatSessionData.url = linkUrl;
            [UMSocialData defaultData].extConfig.wechatSessionData.title = shareTitle;
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = linkUrl;
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = shareTitle;
            
            NSArray *arr_SnsList = @[UMShareToWechatSession,UMShareToWechatTimeline];
            [UMSocialSnsService presentSnsIconSheetView:webViewController appKey:UMeng_App_Key shareText:content shareImage:shareImage.image shareToSnsNames:arr_SnsList delegate:nil];
            
        };
        
        
        
    }
    
    kGCDMain(^{
        [tabController presentViewController:webViewController animated:YES completion:nil];
    });
}














@end

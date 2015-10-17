//
//  NetworkHandle.m
//
//  Created by dd on .
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "NetworkHandle.h"
#import <AFNetworking.h>
#import "SignTool.h"

//hud提示时间
const float Network_Handle_HUD_Duration = 1.0;

#define Network_Handle_Instance                             ((NetworkHandle *)[NetworkHandle sharedInstance])

@interface NetworkHandle ()

@property (nonatomic, strong) AFHTTPRequestOperationManager  *requsetManager;

@end


@implementation NetworkHandle

/**
 *  根据相应接口获取数据
 *
 *  @param paramDic         无需加密字典
 *  @param signDict         需加密字典
 *  @param interfaceName    接口名称
 *  @param success          成功处理方法
 *  @param failure          失败处理方法
 *  @param networkFailure   网络加载失败
 *  @param showLoding       是否显示加载信息
 */
+ (void) loadDataFromServerWithParamDic:(NSDictionary *)paramDic
                                signDic:(NSDictionary *)signDict
                          interfaceName:(NSString *)interfaceName
                                success:(void (^)(NSDictionary *responseDictionary , NSString *message))success
                                failure:(void (^)(void))failure
                         networkFailure:(void (^)(void))networkFailure
                            showLoading:(BOOL)showLoading
{
    [self loadDataFromServerWithParamDic:paramDic
                                 signDic:signDict
                   imagesDictionaryArray:nil
                           interfaceName:interfaceName
                                 success:success
                                 failure:failure
                          networkFailure:(void (^)(void))networkFailure
                             showLoading:showLoading];
}

/**
 *  根据相应接口获取数据
 *
 *  @param paramDic         无需加密字典
 *  @param signDict         需加密字典
 *  @param interfaceName    接口名称
 *  @param success          成功处理方法
 *  @param failure          失败处理方法
 *  @param networkFailure   网络加载失败
 */
+ (void) loadDataFromServerWithParamDic:(NSDictionary *)paramDic
                                signDic:(NSDictionary *)signDict
                          interfaceName:(NSString *)interfaceName
                                success:(void (^)(NSDictionary *responseDictionary , NSString *message))success
                                failure:(void (^)(void))failure
                         networkFailure:(void (^)(void))networkFailure
{
    [self loadDataFromServerWithParamDic:paramDic
                                 signDic:signDict
                           interfaceName:interfaceName
                                 success:success
                                 failure:failure
                          networkFailure:(void (^)(void))networkFailure
                             showLoading:YES];
}

/**
 *  根据相应接口获取数据
 *
 *  @param paramDic         无需加密字典
 *  @param signDict         需加密字典
 *  @param imagesDictionary 图片字典数据数组     param:参数名  image:图片  imageName:图片名  imageData:图片数据
 *  @param interfaceName    接口名称
 *  @param success          成功处理方法
 *  @param failure          失败处理方法
 *  @param networkFailure   网络加载失败
 */
+ (void) loadDataFromServerWithParamDic:(NSDictionary *)paramDic
                                signDic:(NSDictionary *)signDict
                  imagesDictionaryArray:(NSArray *)imagesDictionary
                          interfaceName:(NSString *)interfaceName
                                success:(void (^)(NSDictionary *responseDictionary , NSString *message))success
                                failure:(void (^)(void))failure
                         networkFailure:(void (^)(void))networkFailure
{
    [self loadDataFromServerWithParamDic:paramDic
                                 signDic:signDict
                   imagesDictionaryArray:imagesDictionary
                           interfaceName:interfaceName
                                 success:success
                                 failure:failure
                          networkFailure:(void (^)(void))networkFailure
                             showLoading:YES];
}

/**
 *  上传单个图片方法
 *
 *  @param imageData        文件数据
 *  @param imageName        文件名
 *  @param paramName        参数名
 *  @param interfaceName    接口地址
 *  @param success          成功方法
 *  @param failure          失败方法
 *  @param networkFailure   网络加载失败
 */
+ (void) upLoadFileWithImageData:(NSString *)imageData
                       imageName:(NSString *)imageName
                       paramName:(NSString *)paramName
                   interfaceName:(NSString *)interfaceName
                         success:(void (^)(NSDictionary *, NSString *))success
                         failure:(void (^)(void))failure
                  networkFailure:(void (^)(void))networkFailure
{
    [self loadDataFromServerWithParamDic:nil
                                 signDic:nil
                   imagesDictionaryArray:@[@{Define_Image_Dictionary_imageData: imageData,
                                             Define_Image_Dictionary_imageName: imageName,
                                             Define_Image_Dictionary_paramName: paramName}]
                           interfaceName:interfaceName
                                 success:success
                                 failure:failure
                          networkFailure:(void (^)(void))networkFailure];
}

/**
 *  根据相应接口获取数据
 *
 *  @param paramDic         无需加密字典
 *  @param signDict         需加密字典
 *  @param imagesDictionary 图片字典数据数组     paramName:参数名  imageName:图片名  imageData:图片数据
 *  @param interfaceName    接口名称
 *  @param success          成功处理方法
 *  @param failure          失败处理方法
 *  @param networkFailure   网络加载失败
 *  @param showLoding       是否显示加载信息
 */
+ (void) loadDataFromServerWithParamDic:(NSDictionary *)paramDic
                                signDic:(NSDictionary *)signDict
                  imagesDictionaryArray:(NSArray *)imagesDictionary
                          interfaceName:(NSString *)interfaceName
                                success:(void (^)(NSDictionary *responseDictionary , NSString *message))success
                                failure:(void (^)(void))failure
                         networkFailure:(void (^)(void))networkFailure
                            showLoading:(BOOL)showLoading
{
    if (showLoading)
    {
        [CommonHUD showHud];
    }
    
    NSMutableDictionary *postDictionary = [self makePostParamsWithParamDic:paramDic AndSignDict:signDict];
    NSLog(@"\n接口地址: %@ \n发送参数: %@",interfaceName,postDictionary);
    
    //发送请求
    [Network_Handle_Instance.requsetManager POST:interfaceName
                                      parameters:postDictionary
                       constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         if (imagesDictionary.count)
         {
             for (NSDictionary *imageDic in imagesDictionary)
             {
                 NSLog(@"\n图片数据: %@",imageDic);
                 
                 NSString *paramName = [imageDic objectForKey:Define_Image_Dictionary_paramName];
                 NSString *imageName = [imageDic objectForKey:Define_Image_Dictionary_imageName];
                 UIImage *image      = [imageDic objectForKey:Define_Image_Dictionary_imageData];
                 
                 if (image)
                 {
                     [formData appendPartWithFileData:[image isKindOfClass:[UIImage class]]?UIImageJPEGRepresentation(image,0.1):[NSData data]
                                                 name:paramName
                                             fileName:imageName
                                             mimeType:@"image/png"];
                 }
             }
         }
     }
                                         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         if (showLoading)
         {
             [CommonHUD hideHud];
         }
         
         NSLog(@"\n返回数据: %@",responseObject);
         
         if ([responseObject isKindOfClass:[NSNull class]] || !responseObject) {
             
             if (showLoading)
             {
                 [CommonHUD showHudWithMessage:@"服务器繁忙" delay:Network_Handle_HUD_Duration completion:nil];
             }
             
             return;
         }
         
         NSDictionary *dic_returnDic = (NSDictionary *)responseObject;
         
         NSNumber *result            = [dic_returnDic objectForKey:Return_result];
         NSString *message           = [dic_returnDic objectForKey:Return_message];
         //         id dic_data                 = [dic_returnDic objectForKey:Return_data];
         
         //如果是调用微信接口 单独处理
         if ([dic_returnDic[@"unionid"] isKindOfClass:[NSString class]] && ((NSString *)dic_returnDic[@"unionid"]).length) {
             if (success) {
                 success(dic_returnDic,message);
             }
             return;
         }
         
         if (result && [result intValue] == 0) {
             //成功
             if (success) {
                 success(dic_returnDic,message);
             }
             
         } else if ([result intValue] == 4) {
             //失败 用户在别处登录
             //展示信息后强制跳转到登录页
             [CommonHUD showHudWithMessage:message delay:Network_Handle_HUD_Duration completion:^{
                 [CommonUser action_cacheHomeData:nil];
                 [CommonUser setUserStatusInfo:nil];
                 [CommonUser setUserInfo:nil];
                 [CommonUser pushToUserLoginViewController];
             }];
             
         } else if ([result intValue] != 0) {
             //失败
             if (showLoading) {
                 [CommonHUD showHudWithMessage:message delay:Network_Handle_HUD_Duration completion:failure];
             } else {
                 if (failure) {
                     failure();
                 }
             }
         } else {
             //其他
             [CommonHUD showHudWithMessage:@"服务器繁忙" delay:Network_Handle_HUD_Duration completion:nil];
         }
     }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@",error.userInfo);
         
         if (showLoading)
         {
             if ((error.code == -1009) || (error.code == -1004)) {
                 [CommonHUD showHudWithMessage:@"当前无网络,请稍后再试" delay:Network_Handle_HUD_Duration completion:networkFailure];
             } else if (error.code == -1001) {
                 [CommonHUD showHudWithMessage:@"请求超时,请稍后再试" delay:Network_Handle_HUD_Duration completion:networkFailure];
             } else {
                 [CommonHUD showHudWithMessage:@"服务器繁忙" delay:Network_Handle_HUD_Duration completion:networkFailure];
             }
         } else {
             if (networkFailure) {
                 networkFailure();
             }
         }
     }];
}



+ (NSMutableDictionary *)makePostParamsWithParamDic:(NSDictionary *)paramDict AndSignDict:(NSDictionary *)signDict{
    
    NSMutableDictionary *postDictionary = [NSMutableDictionary dictionaryWithDictionary:paramDict];
    
    //需要加密的数据
    NSMutableDictionary *mutableSign = [NSMutableDictionary dictionaryWithDictionary:signDict];
    [mutableSign setValue:[CommonIO appVersion] forKey:@"version"];
    [mutableSign setValue:[CommonUser udid] forKey:@"udid"];
    [mutableSign setValue:[CommonUser userID] forKey:@"userID"];//
    [mutableSign setValue:@"1" forKey:@"platformID"];
    
    [postDictionary setValuesForKeysWithDictionary:[SignTool makeSignDict:mutableSign secret:App_Secrect signKey:App_Sign]];
    
    return postDictionary;
}



#pragma mark -

- (NetworkHandle *) httpRequestManagerInit {
    self.requsetManager = [AFHTTPRequestOperationManager new];
    self.requsetManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/plain",@"text/javascript",nil];
    self.requsetManager.requestSerializer.timeoutInterval = 15; //设置超时
    return self;
}

+ (NetworkHandle *) sharedInstance {
    
    static NetworkHandle *networkHandle = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkHandle = [[NetworkHandle new] httpRequestManagerInit];
    });
    
    return networkHandle;
}




@end

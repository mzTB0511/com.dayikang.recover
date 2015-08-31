//
//  NetworkHandle.h
//
//  Created by dd on .
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#pragma mark - 上传图片时图片数组参数定义

//参数名
#define Define_Image_Dictionary_paramName               @"paramName"
//图片名
#define Define_Image_Dictionary_imageName               @"imageName"
//图片数据
#define Define_Image_Dictionary_imageData               @"imageData"

#import <Foundation/Foundation.h>

@interface NetworkHandle : NSObject

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
                            showLoading:(BOOL)showLoading;

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
                         networkFailure:(void (^)(void))networkFailure;


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
 */
+ (void) loadDataFromServerWithParamDic:(NSDictionary *)paramDic
                                signDic:(NSDictionary *)signDict
                  imagesDictionaryArray:(NSArray *)imagesDictionary
                          interfaceName:(NSString *)interfaceName
                                success:(void (^)(NSDictionary *responseDictionary , NSString *message))success
                                failure:(void (^)(void))failure
                         networkFailure:(void (^)(void))networkFailure;


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
                         success:(void (^)(NSDictionary *responseDictionary , NSString *message))success
                         failure:(void (^)(void))failure
                  networkFailure:(void (^)(void))networkFailure;


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
                            showLoading:(BOOL)showLoading;


/**
 *  生成接口情况的所有参数
 *
 *  @param paramDict 不签名的参数列表
 *  @param signDict  需要签名的参数列表
 *
 *  @return 请求的所有参数列表
 */
+ (NSMutableDictionary *)makePostParamsWithParamDic:(NSDictionary *)paramDict AndSignDict:(NSDictionary *)signDict;

@end

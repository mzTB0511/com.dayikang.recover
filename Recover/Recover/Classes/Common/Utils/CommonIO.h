//
//  CommonIO.h
//
//  Created by dd .
//  Copyright (c) 2014年 YangXudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonIO : NSObject



#pragma mark -
#pragma mark - 版本号比较

+(BOOL)isShowUpdateMessageWithAppVersion:(NSString *)appVersion NewVersion:(NSString *)newVersion;

#pragma mark -
#pragma mark - 全屏展示图片

+ (void) showImage:(UIImage *)image bgColor:(UIColor *)bgColor;

#pragma mark -
#pragma mark - 获取当前版本号

+ (NSString *) appVersion;

#pragma mark -
#pragma mark - 利用颜色生成图片

+ (UIImage *) imageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark -
#pragma mark - 发送通知

+ (void) postNotificationWithName:(NSString *)notificationName object:(id)object userInfo:(NSDictionary *)userInfo;

#pragma mark -
#pragma mark 正则验证

/**
 *  邮箱正则验证
 */
+(BOOL) validateEmail:(NSString *)email;

/**
 *  手机号正则验证
 */
+(BOOL) validateMobile:(NSString *)mobile;

#pragma mark -
#pragma mark local data method

+ (void) setLocalData:(id)data key:(NSString *)key;
+ (id) getLocalData:(NSString *)key;
+ (void) setLocalValue:(id)value key:(NSString *)key;
+ (void) setLocalInt:(int)value key:(NSString *)key;
+ (void) setLocalBool:(bool)value key:(NSString *)key;
+ (id) getLocalValue:(NSString *)key;
+ (int) getLocalInt:(NSString *)key;
+ (bool) getLocalBool:(NSString *)key;
+ (id) getLocalString:(NSString *)key;

#pragma mark - 读取是否第一次打开 / 存储已经打开

/**
 *  根据key值判断是不是第一次打开
 */
+ (BOOL)isFirstOpen:(NSString *)key;

/**
 *  根据key值设置成已经打开
 */
+ (void)isOpened:(NSString *)key;

/**
 *  判断字符变量是否为nil值
 *
 *  @param inputValue 输入字符串
 *
 *  @return 返回字符串
 */
+ (NSString *)ifNilValueReturnStr:(NSString *)inputValue;

@end

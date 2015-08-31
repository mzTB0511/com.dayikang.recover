//
//  CommonFunc.h
//  
//
//  Created by lx on 14-6-19.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunc : NSObject


/*初始化CommonFunc*/
+ (id)shareInstance;

/*将NSData数据转化成UIImage对象*/
- (UIImage *)changeNSDateToImage:(NSData *)srcData;

/*判断数据是否为NSNull*/
- (NSString *)checkNullString:(NSString *)src;

/*判断数据是否为NSNull 转化为Int*/
- (NSString *)checkNullASIntToZero:(NSString *)src;

#pragma mark -
#pragma mark local data method

- (BOOL) isLocalDataExists:(NSString *)key;
- (void) setLocalData:(id)data key:(NSString *)key;
- (id) getLocalData:(NSString *)key;
- (void) setLocalValue:(id)value key:(NSString *)key;
- (void) setLocalInt:(int)value key:(NSString *)key;
- (void) setLocalBool:(bool)value key:(NSString *)key;
- (id) getLocalValue:(NSString *)key;
- (id) getLocalValueOnce:(NSString *)key;
- (int) getLocalInt:(NSString *)key;
- (bool) getLocalBool:(NSString *)key;
- (id) getLocalString:(NSString *)key;

#pragma messageHint
- (void) showHintMessage:(NSString *)messageText;

#pragma mark -
#pragma mark guid method

- (NSString *) createUUID;
- (NSString *) getGUID;

#pragma mark -
#pragma mark setting method

- (NSString *) getFormatDate:(NSString *)inputDateString;
- (NSDate *) toDate:(NSString *)strDate;
- (NSDate *) toStandardDate:(NSDate *)strDate;

#pragma mark -
#pragma mark 验证手机号
- (bool)isValidatePhone:(NSString *)mobileString;

#pragma mark -
#pragma mark 浮点性零值判断

- (bool)isZeroFloat:(float)floatValue;
- (NSString *) unicodeToUtf8:(NSString *)string;

#pragma mark 压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;


#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

#pragma mark 动态计算 UITextView 高度
- (CGFloat)getControlHWithTextView:(UITextView *)textView;


#pragma mark 日期相关函数
// 获取当前系统时间
- (NSString *)getSystemData:(int)flag WithType:(int)type;

// 时间字符串转时间类型
- (NSDate *)strintToData:(NSString *)strDate withFormat:(NSString *)formatStr;

// 时间类型转时间字符串转
- (NSString *)dateToStr:(NSDate *)Date withFormat:(NSString *)formatStr;

// 日期加减函数
- (NSDate *)getNewDataBy:(int)year WithCurrentData:(NSDate *)data;


// 版本号比较
-(BOOL)isShowUpdateMessageWithAppVersion:(NSString *)appVersion NewVersion:(NSString *)newVersion;

/**
 *  屏幕截图
 *
 *  @param view 需要保存的视图
 *
 *  @return 转换为图片保存
 */
- (UIImage *)snapshot:(UIView *)view;


/**
 *  ScrollView 内容截屏功能
 *
 *  @param scrollView 要保存的ScrollView 视图
 *
 *  @return Image
 */
- (UIImage *)captureScrollView:(UIScrollView *)scrollView;


@end

//
//  CommonIO.m
//
//  Created by dd .
//  Copyright (c) 2014年 YangXudong. All rights reserved.
//

#import "CommonIO.h"

#define Tag_Full_Screen_Image_View          734245

@implementation CommonIO


#pragma mark -
#pragma mark - 版本号比较

+(BOOL)isShowUpdateMessageWithAppVersion:(NSString *)appVersion NewVersion:(NSString *)newVersion {
    /**
     *  创建版本号分割后数据容器
     */
    NSMutableArray *appVersionList = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0"]];
    
    NSMutableArray *appNewVersionList = [NSMutableArray arrayWithArray:@[@"0",@"0",@"0"]];
    
    NSRange range = [appVersion rangeOfString:@"."];
    if (range.length > 0)
    {
        NSArray *versionList = [appVersion componentsSeparatedByString:@"."];
        
        // 重置App版本数据容器 包含的元素值
        for (int i= 0; i<versionList.count; i++) {
            
            [appVersionList setObject:[versionList objectAtIndex:i] atIndexedSubscript:i];
        }
        
    }
    
    
    NSRange rangeNew = [newVersion rangeOfString:@"."];
    if (rangeNew.length > 0)
    {
        NSArray *versionList = [newVersion componentsSeparatedByString:@"."];
        
        // 重置App版本数据容器 包含的元素值
        for (int i= 0; i<versionList.count; i++) {
            
            [appNewVersionList setObject:[versionList objectAtIndex:i] atIndexedSubscript:i];
        }
        
    }
    
    
    // 循环数据比价版本大小
    for (int i =0; i <appVersionList.count; i++) {
        
        CGFloat version = [[appVersionList objectAtIndex:i] floatValue];
        
        CGFloat newVersion = [[appNewVersionList objectAtIndex:i] floatValue];
        
        if (version < newVersion) {
            
            return YES;
        }
        
    }

    return NO;
}

#pragma mark -
#pragma mark - 全屏展示图片

+ (void) showImage:(UIImage *)image bgColor:(UIColor *)bgColor {
    
    UIControl *bgView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = bgColor?:[UIColor blackColor];
    [bgView addTarget:self action:@selector(action_tapBgView) forControlEvents:UIControlEventTouchUpInside];
    bgView.tag = Tag_Full_Screen_Image_View;
    [[[UIApplication sharedApplication] keyWindow] addSubview:bgView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:bgView.frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [bgView addSubview:imageView];
}

+ (void) action_tapBgView {
    [[[[UIApplication sharedApplication] keyWindow] viewWithTag:Tag_Full_Screen_Image_View] removeFromSuperview];
}

#pragma mark -
#pragma mark - 获取当前版本号

+ (NSString *) appVersion {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

#pragma mark -
#pragma mark - 利用颜色生成图片

+ (UIImage *) imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark -
#pragma mark - 发送通知

+ (void) postNotificationWithName:(NSString *)notificationName object:(id)object userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object userInfo:userInfo];
}

#pragma mark -
#pragma mark 正则验证

/**
 *  邮箱正则验证
 */
+(BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  手机号正则验证
 */
+(BOOL) validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^(0|86|17951)?(13|14|15|17|18)[0-9]{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark -
#pragma mark local data method

+ (void) setLocalData:(id)data key:(NSString *)key{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (data == nil) {
        [ud removeObjectForKey:key];
    }
    else {
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:data];
        [ud setObject:userData forKey:key];
    }
    [ud synchronize];
}

+ (id) getLocalData:(NSString *)key{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud objectForKey:key] != NULL) {
        NSData *userData = [ud objectForKey:key];
        return [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    }
    else {
        return nil;
    }
}

+ (void) setLocalValue:(id)value key:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (value == nil) {
        [ud removeObjectForKey:key];
    }
    else {
        [ud setObject:value forKey:key];
    }
    [ud synchronize];
}

+ (void) setLocalInt:(int)value key:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:value forKey:key];
    [ud synchronize];
}

+ (void) setLocalBool:(bool)value key:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:value forKey:key];
    [ud synchronize];
}

+ (id) getLocalValue:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}

+ (int) getLocalInt:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return (int)[ud integerForKey:key];
}

+ (bool) getLocalBool:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:key];
}

+ (id) getLocalString:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud stringForKey:key];
}

#pragma mark - 读取是否第一次打开 / 存储已经打开

+ (BOOL)isFirstOpen:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return ![ud boolForKey:key];
}

+ (void)isOpened:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:key];
    [ud synchronize];
}

+ (NSString *)ifNilValueReturnStr:(NSString *)inputValue{
    
    if (!inputValue || [inputValue isKindOfClass:[NSNull class]]) {
       return @"";
    }
    
    return inputValue;
}



@end
//
//  CommonFunc.m
//  
//
//  Created by lx on 14-6-19.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "CommonFunc.h"

@implementation CommonFunc

+ (CommonFunc *)shareInstance{
    static dispatch_once_t pred;
    static CommonFunc *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] initCommFunc];
    });
    return instance;
}

- (id)initCommFunc{
    self  = [super init];
    if (self == [super init]){
        
    }
    return self;
}




- (UIImage *)changeNSDateToImage:(NSData *)srcData
{
    UIImage *image = [[UIImage alloc]init];
    image = [UIImage imageWithData:srcData];
    
    return image;
}


/*判断数据是否为NSNull*/
- (NSString *)checkNullString:(NSString *)src
{
    NSString *endStr = src;
    if ([endStr isEqual:[NSNull null]] || !endStr) {
        endStr = @"";
    }
    
    return endStr;
    
}


/*判断数据是否为NSNull 转化为Int*/
- (NSString *)checkNullASIntToZero:(NSString *)src
{
    NSString *endStr = src;
    if ([src isEqual:[NSNull null]]) {
        endStr = @"0";
    }
    
    return endStr;
    
}



#pragma mark -
#pragma mark local data method


- (BOOL) isLocalDataExists:(NSString *)key{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud objectForKey:key] != NULL;
}

- (void) setLocalData:(id)data key:(NSString *)key{
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

- (id) getLocalData:(NSString *)key{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	if ([ud objectForKey:key] != NULL) {
		NSData *userData = [ud objectForKey:key];
		return [NSKeyedUnarchiver unarchiveObjectWithData:userData];
	}
	else {
		return nil;
	}
    
}

- (void) setLocalValue:(id)value key:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	if (value == nil) {
		[ud removeObjectForKey:key];
	}
	else {
		[ud setObject:value forKey:key];
	}
	[ud synchronize];
}

- (void) setLocalInt:(int)value key:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[ud setInteger:value forKey:key];
	[ud synchronize];
}

- (void) setLocalBool:(bool)value key:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[ud setBool:value forKey:key];
	[ud synchronize];
}


- (id) getLocalValue:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud objectForKey:key];
}

- (int) getLocalInt:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud integerForKey:key];
}

- (bool) getLocalBool:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud boolForKey:key];
}

- (id) getLocalString:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	return [ud stringForKey:key];
}


- (id) getLocalValueOnce:(NSString *)key {
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	id returnValue = [ud objectForKey:key];
	[ud removeObjectForKey:key];
	[ud synchronize];
	return returnValue;
}

- (void) showHintMessage:(NSString *)messageText{
    
    if (messageText == nil) {
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:messageText
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
    [alertView show];
}



#pragma mark -
#pragma mark guid method

- (NSString *) createUUID {
	// Create universally unique identifier (object)
	CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
	
	// Get the string representation of CFUUID object.
	NSString *uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    
	CFRelease(uuidObject);
	
	return uuidStr;
}


-(NSString *) getGUID
{
    NSString * UUID = [[NSProcessInfo processInfo] globallyUniqueString];
    
    return UUID;
}



#pragma mark -
#pragma mark setting method

- (NSString *) getFormatDate:(NSString *)inputDateString {
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
	[inputDateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
	NSDate *inputDate = [inputDateFormatter dateFromString:inputDateString];
	
	NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
	NSString *outputDateFormatterStr = @"yyyy/MM/dd HH:mm:ss";
	[outputDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
	[outputDateFormatter setDateFormat:outputDateFormatterStr];
	return [outputDateFormatter stringFromDate:inputDate];
}

- (NSDate *) toDate:(NSString *)strDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +0000"];
    NSDate *date = [formatter dateFromString:strDate];
    return date;
}

- (NSDate *) toStandardDate:(NSDate *)fullDate {
    NSString *strDate = [NSString stringWithFormat:@"%@", fullDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    return [dateFormatter dateFromString:strDate];
}


// 判断手机号是否有效
- (bool)isValidatePhone:(NSString *)mobileString {
    
    if (mobileString == nil) {
        
        return NO;
    }
    
    NSMutableString *testString=[NSMutableString stringWithString:mobileString];
    
    //一个判断是否是有效的手机号码正则表达式
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                               initWithPattern:@"^(13[0-9]|15[0-3]|15[5-9]|145|147|18[0-9])[0-9]{8}$"
                                               options:NSRegularExpressionCaseInsensitive
                                               error:nil];
    
    //无符号整型数据接受匹配的数据的数目
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:testString
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, testString.length)];
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    //用户名： @"^[a-zA-Z0-9]{4,16}$"
    //密码：  @"^[a-zA-Z0-9]{6,16}$"
}


// 判断手机号是否有效
- (bool)isZeroFloat:(float)floatValue
{
    if ((floatValue > -0.001) && (floatValue < 0.001)) {
        return YES;
    }
    return NO;
}

- (NSString *) unicodeToUtf8:(NSString *)string
{
    NSString *tempStr1 = [string stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"" withString:@"\\"];
    NSString *tempStr3 = [[@"" stringByAppendingString:tempStr2] stringByAppendingString:@""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    //NSLog(@"Output = %@", returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}


//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark 保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
}

/* ios7 动态计算UITextView 内容的高度*/
-(CGFloat)getControlHWithTextView:(UITextView *)textView{
    
    CGFloat textViewH;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        CGRect txtFrame = textView.frame;
        textViewH = txtFrame.size.height =[[NSString stringWithFormat:@"%@\n ",textView.text] boundingRectWithSize:CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                                                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                                                        attributes:[NSDictionary dictionaryWithObjectsAndKeys:textView.font,NSFontAttributeName, nil] context:nil].size.height;
    }else{
        textViewH = textView.contentSize.height;
    }
    
    return textViewH;
}




// 获取当前系统时间
-(NSString *)getSystemData:(int)flag WithType:(int)type;
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    // [dateFormatter setDateFormat:@"hh:mm t"];
    if (flag ==1)
    {
        [dateFormatter setDateStyle:type];
    } else
    {
        [dateFormatter setTimeStyle:type];
    }
    
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：09:20PM
    // NSLog(@"%@",currentDateStr);
    
    return currentDateStr;
}

-(NSDate *)strintToData:(NSString *)strDate withFormat:(NSString *)formatStr
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatStr];
    //用[NSDate date]可以获取系统当前时间
    NSDate *currentDate = [dateFormatter dateFromString:strDate];
    //输出格式为：2010-10-27 10:22:13
    //alloc后对不使用的对象别忘了releas
    
    return currentDate;
}



-(NSString *)dateToStr:(NSDate *)Date withFormat:(NSString *)formatStr
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:Date];
    //输出格式为：09:20PM
    // NSLog(@"%@",currentDateStr);
    
    return currentDateStr;
}


// 日期加减函数
-(NSDate *)getNewDataBy:(int)year WithCurrentData:(NSDate *)data
{
    NSDate *valentinesDay = [NSDate date];
    NSLog(@"Valentine's Day = %@", valentinesDay);
    NSDateComponents *weekBeforeDateComponents = [[NSDateComponents
                                                   alloc] init];
    weekBeforeDateComponents.year = year;
    NSDate *vDayShoppingDay = [[NSCalendar currentCalendar]
                               dateByAddingComponents:weekBeforeDateComponents
                               toDate:valentinesDay
                               options:0];
    
    return vDayShoppingDay;
}



/**
 *  屏幕截图
 *
 *  @param view 需要保存的视图
 *
 *  @return 转换为图片保存
 */
- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


/**
 *  ScrollView 内容截屏功能
 *
 *  @param scrollView 要保存的ScrollView 视图
 *
 *  @return Image
 */
- (UIImage *)captureScrollView:(UIScrollView *)scrollView{
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize,NO,0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        
        CGContextRef buffer = UIGraphicsGetCurrentContext();
        [scrollView.layer renderInContext:buffer];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}




// App版本号比较 版本号最长定义为 三位数字，点隔开如: 1.6.2
-(BOOL)isShowUpdateMessageWithAppVersion:(NSString *)appVersion NewVersion:(NSString *)newVersion{
  
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



@end

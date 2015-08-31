//
//  BabySanteDatePicker.h
//  BabySante
//
//  Created by dd on 15/4/15.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Category.h"
#import "NSDateFormatter+Category.h"

typedef void(^BabySanteDatePickerBlock)(NSString *string);
typedef void(^BabySanteDatePickerPickingResultBlock)(NSInteger type,NSString *string);
typedef void(^BabySanteDatePickerPickingBlock)(UIControl *controls, NSInteger index);

@interface BabySanteDatePicker : UIView

/**
 *  展示选取时间控件
 *
 *  @param minDate     最早日期
 *  @param maxDate     最晚日期
 *  @param defaultDate 默认日期
 *  @param showHours   是否显示小时分钟
 *  @param block       选取后执行方法
 */
+ (void) showDatePickerWithMinDate:(NSDate *)minDate
                           maxDate:(NSDate *)maxDate
                       defaultDate:(NSDate *)defaultDate
                         showHours:(BOOL)showHours
                             block:(BabySanteDatePickerBlock)block;

/**
 *  展示经期和周期控件
 *
 *  @param block        选取后执行方法
 */
+ (void) showValuePickerWithBlock:(BabySanteDatePickerBlock)block;


/**
 *  展示picker
 *
 *  @param dataArray 数据源
 *  @param index     默认选中值
 *  @param block     选取后执行方法
 */
+ (void) showPickerWithValues:(NSArray *)dataArray
                 defaultIndex:(int)index
                        block:(BabySanteDatePickerBlock)block;



/**
 *  展示picker
 *
 *  @param dataArray 数据源
 *  @param indexArray     默认选中项目值
 *  @param block     选取后执行方法
 */
+ (void) showPickerWithData:(NSArray *)dataArray
               defaultIndex:(NSArray *)indexArray
                      block:(BabySanteDatePickerBlock)block;



@end

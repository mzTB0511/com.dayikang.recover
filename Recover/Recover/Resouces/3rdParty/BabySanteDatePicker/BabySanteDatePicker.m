//
//  BabySanteDatePicker.m
//  BabySante
//
//  Created by dd on 15/4/15.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "BabySanteDatePicker.h"
#import "NSDateFormatter+Category.h"


#define BabySanteDatePickerAnimationDuration        0.25

#define BabySanteDatePickerPickerHeight             180

#define BabySanteDatePickerToolBarHeight            40

//普通picker
#define BabySanteDatePickerTag_Custom               10086

//经期picker
#define BabySanteDatePickerTag_jq                   10010


//经期picker
#define BabySanteDatePickerTag_PickingView                   1001011



@interface BabySanteDatePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy) BabySanteDatePickerBlock block;

@property (nonatomic, copy) BabySanteDatePickerPickingResultBlock resultBlock;


@property (nonatomic, copy) BabySanteDatePickerPickingBlock pickingBlock;

@property (nonatomic, strong) UIControl *backgroundView;
@property (nonatomic, strong) UIView *pickerContainerView;

@property (nonatomic, strong) id pickerView;

@property (nonatomic, strong) NSArray *dataSource;

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) UILabel *unitLabel;



@end

@implementation BabySanteDatePicker

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
                             block:(BabySanteDatePickerBlock)block {
    
    BabySanteDatePicker *babySanteDatePicker = [BabySanteDatePicker babySanteDatePickerViewWithPickerView:[BabySanteDatePicker
                                                                                                           datePickerWithMinDate:minDate
                                                                                                           maxDate:maxDate
                                                                                                           defaultDate:defaultDate
                                                                                                           showHours:showHours]];
    babySanteDatePicker.block = block;
    
    [mWindow addSubview:babySanteDatePicker];
    
    [babySanteDatePicker showBackgroundView];
    [babySanteDatePicker showPickerView];
}

/**
 *  展示经期和周期控件
 *
 *  @param block        选取后执行方法
 */
+ (void) showValuePickerWithBlock:(BabySanteDatePickerBlock)block {
    
    UIPickerView *pickerView = [BabySanteDatePicker pickerView];
    
    BabySanteDatePicker *babySanteDatePicker = [BabySanteDatePicker babySanteDatePickerViewWithPickerView:pickerView];
    
    babySanteDatePicker.block = block;
    pickerView.tag = BabySanteDatePickerTag_jq;
    pickerView.dataSource = babySanteDatePicker;
    pickerView.delegate = babySanteDatePicker;
    
    [pickerView reloadAllComponents];
    [pickerView selectRow:4 inComponent:0 animated:NO];
    [pickerView selectRow:3 inComponent:1 animated:NO];
    
    [mWindow addSubview:babySanteDatePicker];
    
    [babySanteDatePicker showBackgroundView];
    [babySanteDatePicker showPickerView];
}

/**
 *  展示picker
 *
 *  @param dataArray 数据源
 *  @param index     默认选中值
 *  @param block     选取后执行方法
 */
+ (void) showPickerWithValues:(NSArray *)dataArray
                 defaultIndex:(int)index
                        block:(BabySanteDatePickerBlock)block {
    
    UIPickerView *pickerView = [BabySanteDatePicker pickerView];
    
    BabySanteDatePicker *babySanteDatePicker = [BabySanteDatePicker babySanteDatePickerViewWithPickerView:pickerView];
    babySanteDatePicker.dataSource = dataArray;
    babySanteDatePicker.block = block;
    pickerView.tag = BabySanteDatePickerTag_Custom;
    pickerView.dataSource = babySanteDatePicker;
    pickerView.delegate = babySanteDatePicker;
    
    [pickerView reloadAllComponents];
    [pickerView selectRow:index inComponent:0 animated:NO];
    
    [mWindow addSubview:babySanteDatePicker];
    
    [babySanteDatePicker showBackgroundView];
    [babySanteDatePicker showPickerView];
}


/**
 *  展示picker
 *
 *  @param dataArray 数据源
 *  @param indexArray     默认选中项目值
 *  @param block     选取后执行方法
 */
+ (void) showPickerWithData:(NSArray *)dataArray
                 defaultIndex:(NSArray *)indexArray
                        block:(BabySanteDatePickerBlock)block {
    
    UIPickerView *pickerView = [BabySanteDatePicker pickerView];
    
    BabySanteDatePicker *babySanteDatePicker = [BabySanteDatePicker babySanteDatePickerViewWithPickerView:pickerView];
    babySanteDatePicker.dataSource = dataArray;
    babySanteDatePicker.block = block;
    pickerView.tag = BabySanteDatePickerTag_Custom;
    pickerView.dataSource = babySanteDatePicker;
    pickerView.delegate = babySanteDatePicker;
    
    [pickerView reloadAllComponents];
    
    //**验证数据源对象类型确定 PickerView Component个数
    if ([[dataArray objectAtIndex:0] isKindOfClass:[NSArray class]] &&
         [indexArray count] == [dataArray count] ) {
        for (int i= 0; i< dataArray.count; i++) {
            
            if ([[dataArray objectAtIndex:i] containsObject:[indexArray objectAtIndex:i]]) {
         
            [pickerView selectRow:[[dataArray objectAtIndex:i] indexOfObject:[indexArray objectAtIndex:i]] inComponent:i animated:NO];
                
            }
        }

    }else{
        [pickerView selectRow:[[indexArray objectAtIndex:0] integerValue] inComponent:0 animated:NO];
    }
    
    
    [mWindow addSubview:babySanteDatePicker];
    
    [babySanteDatePicker showBackgroundView];
    [babySanteDatePicker showPickerView];
}





#pragma mark -

+ (UIDatePicker *) datePickerWithMinDate:(NSDate *)minDate
                                 maxDate:(NSDate *)maxDate
                             defaultDate:(NSDate *)defaultDate
                               showHours:(BOOL)showHours {
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,
                                                                             BabySanteDatePickerToolBarHeight,
                                                                              [UIScreen mainScreen].bounds.size.width,
                                                                              BabySanteDatePickerPickerHeight)];
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    datePicker.date = defaultDate ? defaultDate : [NSDate date];
    datePicker.datePickerMode = showHours?UIDatePickerModeDateAndTime:UIDatePickerModeDate;
    return datePicker;
}

+ (UIPickerView *) pickerView {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                                             BabySanteDatePickerToolBarHeight,
                                                                             [UIScreen mainScreen].bounds.size.width,
                                                                             BabySanteDatePickerPickerHeight)];
    return pickerView;
}




/**
 *  初始化pickerViewContainer View
 *
 *  @return BabySanteDatePicker
 */
+ (BabySanteDatePicker *)babysantePickerContainerView{
    
    BabySanteDatePicker *babySanteDatePicker = [[BabySanteDatePicker alloc] initWithFrame:[UIScreen mainScreen].bounds];
    babySanteDatePicker.backgroundColor = [UIColor clearColor];
    
    //创建背景view
    babySanteDatePicker.backgroundView = [[UIControl alloc] initWithFrame:babySanteDatePicker.bounds];
    babySanteDatePicker.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    babySanteDatePicker.backgroundView.alpha = 0;
    [babySanteDatePicker.backgroundView addTarget:babySanteDatePicker action:@selector(action_backgroundViewTouched) forControlEvents:UIControlEventTouchUpInside];
    [babySanteDatePicker addSubview:babySanteDatePicker.backgroundView];
    
    //创建picker view
    babySanteDatePicker.pickerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                                       babySanteDatePicker.frame.size.height,
                                                                                       babySanteDatePicker.frame.size.width,
                                                                                       BabySanteDatePickerPickerHeight + BabySanteDatePickerToolBarHeight)];
    babySanteDatePicker.pickerContainerView.backgroundColor = [UIColor whiteColor];
    
    return babySanteDatePicker;
}



+ (BabySanteDatePicker *) babySanteDatePickerViewWithPickerView:(id)pickerView {
    
    BabySanteDatePicker *babySanteDatePicker = [BabySanteDatePicker babysantePickerContainerView];
    
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, babySanteDatePicker.frame.size.width, BabySanteDatePickerToolBarHeight)];
    toolBar.backgroundColor = Color_System_Tint_Color;
    
    UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCancel.frame = CGRectMake(0, 0, 60, BabySanteDatePickerToolBarHeight);
    [buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
    [buttonCancel addTarget:babySanteDatePicker action:@selector(action_backgroundViewTouched) forControlEvents:UIControlEventTouchUpInside];

    UIButton *buttonComfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonComfirm.frame = CGRectMake(babySanteDatePicker.frame.size.width - 60, 0, 60, BabySanteDatePickerToolBarHeight);
    [buttonComfirm setTitle:@"确定" forState:UIControlStateNormal];
    [buttonComfirm addTarget:babySanteDatePicker action:@selector(action_comfirmViewTouched) forControlEvents:UIControlEventTouchUpInside];

    [toolBar addSubview:buttonCancel];
    [toolBar addSubview:buttonComfirm];
    
    babySanteDatePicker.pickerView = pickerView;
    
    [babySanteDatePicker.pickerContainerView addSubview:toolBar];
    [babySanteDatePicker.pickerContainerView addSubview:pickerView];
    [babySanteDatePicker addSubview:babySanteDatePicker.pickerContainerView];
    
    return babySanteDatePicker;
}




- (void) action_comfirmViewTouched {
    
    NSString *value = nil;
    
    if ([self.pickerView isKindOfClass:[UIDatePicker class]]) {
        
        NSString *formatterString = @"yyyy-MM-dd";
        
        if (((UIDatePicker *)self.pickerView).datePickerMode == UIDatePickerModeDateAndTime) {
            formatterString = @"yyyy-MM-dd HH:mm";
        }
        
        NSDateFormatter *formatter = [NSDateFormatter dateFormatterWithFormat:formatterString];
        value = [formatter stringFromDate:((UIDatePicker *)self.pickerView).date];
    
    }else{
    
          
            if ([[_dataSource objectAtIndex:0] isKindOfClass:[NSArray class]]) {
                value = @"";
                for (int i= 0; i < _dataSource.count; i++) {
                    
                    value = [value stringByAppendingString:[self pickerView:self.pickerView titleForRow:[((UIPickerView *)self.pickerView) selectedRowInComponent:i] forComponent:i]];
                }
            }else{
                value = [self pickerView:self.pickerView titleForRow:[((UIPickerView *)self.pickerView) selectedRowInComponent:0] forComponent:0];
                
            }
            
           
            if (((UIPickerView *)self.pickerView).tag == BabySanteDatePickerTag_jq) {
                value = [value stringByAppendingString:@","];
                value = [value stringByAppendingString:[self pickerView:self.pickerView titleForRow:[((UIPickerView *)self.pickerView) selectedRowInComponent:1] forComponent:1]];
            }
        }
    
    
    if (self.block) {
        self.block(value);
    }
    
    [self action_backgroundViewTouched];
}

- (void) action_backgroundViewTouched {
    [self hidePickerView];
    [self hideBackgroundView];
}

- (void) showPickerView {
    WEAKSELF
    [UIView animateWithDuration:BabySanteDatePickerAnimationDuration
                     animations:^{
                         weakSelf.pickerContainerView.frame = CGRectMake(0,
                                                                weakSelf.frame.size.height - weakSelf.pickerContainerView.frame.size.height,
                                                                weakSelf.pickerContainerView.frame.size.width,
                                                                weakSelf.pickerContainerView.frame.size.height);
                     }
                     completion:nil];
}

- (void) hidePickerView {
    WEAKSELF
    [UIView animateWithDuration:BabySanteDatePickerAnimationDuration
                     animations:^{
                         weakSelf.pickerContainerView.frame = CGRectMake(0,
                                                                weakSelf.frame.size.height,
                                                                weakSelf.pickerContainerView.frame.size.width,
                                                                weakSelf.pickerContainerView.frame.size.height);
                     }
                     completion:nil];
}

- (void) showBackgroundView {
    WEAKSELF
    [UIView animateWithDuration:BabySanteDatePickerAnimationDuration
                     animations:^{
                         weakSelf.backgroundView.alpha = 1;
                     }
                     completion:nil];
}

- (void) hideBackgroundView {
    WEAKSELF
    [UIView animateWithDuration:BabySanteDatePickerAnimationDuration
                     animations:^{
                         weakSelf.backgroundView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [weakSelf removeFromSuperview];
                     }];
}

#pragma mark -

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    if ([[_dataSource objectAtIndex:0] isKindOfClass:[NSArray class]]) {
        
        return _dataSource.count;
        
    }else if (pickerView.tag == BabySanteDatePickerTag_jq) {
        return 2;
    }
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([[_dataSource objectAtIndex:0] isKindOfClass:[NSArray class]]) {
        
        return [[_dataSource objectAtIndex:component] count];
        
    }else if (pickerView.tag == BabySanteDatePickerTag_jq) {
        if (component == 0) {
            return 10;
        }
        return 10;
    }
    
    return _dataSource.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
 
    if ([[_dataSource objectAtIndex:0] isKindOfClass:[NSArray class]]) {
        
        return [[_dataSource objectAtIndex:component] objectAtIndex:row];
        
    }else if (pickerView.tag == BabySanteDatePickerTag_jq) {
        if (component == 0) {
            return [NSString stringWithFormat:@"经期%d天",(int)row + 1];
        }
        return [NSString stringWithFormat:@"周期%d天",(int)row + 25];
    }
    
    return _dataSource[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

@end

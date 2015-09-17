//
//  LXRelevantPickView.m
//  Recover
//
//  Created by 刘轩 on 15/9/17.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//
#define LXDatePickerAnimationDuration        0.25

#define LXDatePickerPickerHeight             180

#define LXDatePickerToolBarHeight            40

//普通picker
#define LXDatePickerTag_Custom               10086


#import "LXRelevantPickView.h"

@interface LXRelevantPickView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy) LXDataPickerPickingResultBlock block;

@property (nonatomic, strong) UIControl *backgroundView;
@property (nonatomic, strong) UIView *pickerContainerView;

@property (nonatomic, strong) id pickerView;

@property (nonatomic, strong) NSArray *arrPickerData;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) DataPickMoudle pickerMoudle;

@end


@implementation PickerMoudle

@end


@implementation LXRelevantPickView

+ (void) showPickerWithData:(NSArray *)dataArray
               defaultIndex:(NSArray *)indexArray
           withPickerMoudle:(DataPickMoudle)module
                      block:(LXDataPickerPickingResultBlock)block{
    UIPickerView *pickerView = [LXRelevantPickView pickerView];
    
    LXRelevantPickView *lxDatePicker = [LXRelevantPickView DatePickerViewWithPickerView:pickerView];
    
    lxDatePicker.block = block;
    lxDatePicker.pickerMoudle = module;
    lxDatePicker.arrPickerData = dataArray;
    pickerView.dataSource = lxDatePicker;
    pickerView.delegate = lxDatePicker;
    
    lxDatePicker.dataSource = [NSMutableArray arrayWithArray:dataArray];
    
    [pickerView reloadAllComponents];
    
    lxDatePicker.pickerMoudle == DataPickerMoudleRelevant ?([lxDatePicker resetCompanDataWith:0 UIPickerView:pickerView]) : nil;
    [mWindow addSubview:lxDatePicker];
    
    [lxDatePicker showBackgroundView];
    [lxDatePicker showPickerView];
    
}


/**
 *  初始化pickerViewContainer View
 *
 *  @return BabySanteDatePicker
 */
+ (LXRelevantPickView *)babysantePickerContainerView{
    
    LXRelevantPickView *babySanteDatePicker = [[LXRelevantPickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
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
                                                                                       LXDatePickerPickerHeight + LXDatePickerToolBarHeight)];
    babySanteDatePicker.pickerContainerView.backgroundColor = [UIColor whiteColor];
    
    return babySanteDatePicker;
}


+ (LXRelevantPickView *) DatePickerViewWithPickerView:(id)pickerView {
    
    LXRelevantPickView *lxDatePicker = [LXRelevantPickView babysantePickerContainerView];
    
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lxDatePicker.frame.size.width, LXDatePickerToolBarHeight)];
    toolBar.backgroundColor = Color_System_Tint_Color;
    
    UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCancel.frame = CGRectMake(0, 0, 60, LXDatePickerToolBarHeight);
    [buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
    [buttonCancel addTarget:lxDatePicker action:@selector(action_backgroundViewTouched) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonComfirm = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonComfirm.frame = CGRectMake(lxDatePicker.frame.size.width - 60, 0, 60,LXDatePickerToolBarHeight);
    [buttonComfirm setTitle:@"确定" forState:UIControlStateNormal];
    [buttonComfirm addTarget:lxDatePicker action:@selector(action_comfirmViewTouched) forControlEvents:UIControlEventTouchUpInside];
    
    [toolBar addSubview:buttonCancel];
    [toolBar addSubview:buttonComfirm];
    
    lxDatePicker.pickerView = pickerView;
    
    [lxDatePicker.pickerContainerView addSubview:toolBar];
    [lxDatePicker.pickerContainerView addSubview:pickerView];
    [lxDatePicker addSubview:lxDatePicker.pickerContainerView];
    
    return lxDatePicker;
}



+ (UIPickerView *) pickerView {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                                              LXDatePickerToolBarHeight,
                                                                              [UIScreen mainScreen].bounds.size.width,
                                                                              LXDatePickerPickerHeight)];
    return pickerView;
}



- (void) action_comfirmViewTouched {
    
    NSMutableArray *muArrChooseData = [NSMutableArray array];
    for (int i=0;i<_dataSource.count; i++) {
        NSMutableDictionary *dictChoose = [NSMutableDictionary dictionary];
        [dictChoose setObject:[NSString stringWithFormat:@"%i",i] forKey:@"indexcom"];
        NSInteger selIndex = [((UIPickerView *)_pickerView) selectedRowInComponent:i];
        
        [dictChoose setObject:[_dataSource[i] objectAtIndex:selIndex] forKey:@"seldata"];
        [muArrChooseData addObject:dictChoose];
    }
    
    if (self.block) {
        self.block(muArrChooseData);
    }
    
    [self action_backgroundViewTouched];
}


-(void)resetCompanDataWith:(NSInteger)component UIPickerView:(UIPickerView *)pickerView{
   
    for (NSInteger i = component; i<_arrPickerData.count; i++) {
        NSInteger parentIndex = i == 0 ? 0 : i-1;
        PickerMoudle *module = [_dataSource[parentIndex] objectAtIndex:[pickerView selectedRowInComponent:parentIndex]];
        //** 过滤i+1项目数据
        if (i > 0) {
            NSMutableArray *muArrCity = [NSMutableArray array];
            NSArray *arrCity = _arrPickerData[i];
            [arrCity enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PickerMoudle *m = (PickerMoudle *)obj;
                if ([m.parentID isEqualToString:module.selfID]) {
                    [muArrCity addObject:m];
                }
            }];
            
            [_dataSource setObject:muArrCity atIndexedSubscript:i];
        }
        
    }
    [pickerView reloadAllComponents];
}




- (void) action_backgroundViewTouched {
    [self hidePickerView];
    [self hideBackgroundView];
}

- (void) showPickerView {
    WEAKSELF
    [UIView animateWithDuration:LXDatePickerAnimationDuration
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
    [UIView animateWithDuration:LXDatePickerAnimationDuration
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
    [UIView animateWithDuration:LXDatePickerAnimationDuration
                     animations:^{
                         weakSelf.backgroundView.alpha = 1;
                     }
                     completion:nil];
}

- (void) hideBackgroundView {
    WEAKSELF
    [UIView animateWithDuration:LXDatePickerAnimationDuration
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
    }
    return 1;
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([[_dataSource objectAtIndex:0] isKindOfClass:[NSArray class]]) {
        
        return [[_dataSource objectAtIndex:component] count];
        
    }
    
    return _dataSource.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if ([[_dataSource objectAtIndex:0] isKindOfClass:[NSArray class]]) {
        
        return ((PickerMoudle *)[[_dataSource objectAtIndex:component] objectAtIndex:row]).name;
        
    }
    
    return _dataSource[row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_pickerMoudle == DataPickerMoudleRelevant) {
       
        [self resetCompanDataWith:component UIPickerView:pickerView];
        
    }
    
}



@end

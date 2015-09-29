//
//  LXRelevantPickView.h
//  Recover
//
//  Created by 刘轩 on 15/9/17.
//  Copyright (c) 2015年 刘轩. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum{
    DataPickerMoudleNomal = 1,
    DataPickerMoudleRelevant = 2
}DataPickMoudle;

typedef void(^LXDataPickerPickingResultBlock)(NSArray *chooseObj);

/**
 *  DataPicker View数据Moudle
 */
@interface PickerMoudle : NSObject
@property(nonatomic, copy) NSString *parentID;
@property(nonatomic, copy) NSString *selfID;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *mark;

@end



@interface LXRelevantPickView : UIView

/**
 *  展示picker
 *
 *  @param dataArray 数据源
 *  @param indexArray     默认选中项目值
 *  @param block     选取后执行方法
 */
+ (void) showPickerWithData:(NSArray *)dataArray
               defaultIndex:(NSArray *)indexArray
           withPickerMoudle:(DataPickMoudle)module
                      block:(LXDataPickerPickingResultBlock)block;

@end

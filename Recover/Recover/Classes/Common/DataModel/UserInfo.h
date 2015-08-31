//
//  UserInfo.h
//  BabySante
//
//  Created by dd on 15/4/15.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfo : BaseModel

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *userID;

/**
 *  0-没有设置状态，1-已经设置过
 */
@property (nonatomic, copy) NSString *status;

/**
 *  用户手机号
 */
@property (nonatomic, copy) NSString *userPhone;

/**
 *  用户性别，0-男，1-女
 */
@property (nonatomic, copy) NSString *userSex;

/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *userIco;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *nickName;

/**
 *  是否临时用户 0:否 1:是
 */
@property (nonatomic, copy) NSString *isTempUser;

/**
 *  用户身高
 */
@property (nonatomic, copy) NSString *height;

/**
 *  用户体重
 */
@property (nonatomic, copy) NSString *weight;



#pragma mark - 1.8版本以前属性

// 用户UnionID
@property(nonatomic,strong) NSString* unionID;

// 用户类型 iPhone / android
@property(nonatomic,strong) NSString* userType ;

// 用户昵称
@property(nonatomic,strong) NSString* userName ;

// 百度 userID chinnelID
@property(nonatomic,strong) NSString* bdUserID ;

@property(nonatomic,strong) NSString* bdChannelID ;

@property(nonatomic,strong) NSString* bdAppID ;

@end

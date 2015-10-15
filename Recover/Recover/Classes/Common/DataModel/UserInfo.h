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
 *  用户手机号
 */
@property (nonatomic, copy) NSString *phone;

/**
 *  用户性别，0-男，1-女
 */
@property (nonatomic, copy) NSString *sex;

/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *ico;


/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *nickName;




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

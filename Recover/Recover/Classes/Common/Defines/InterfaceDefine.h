//
//  InterfaceDefine.h
//
//  Created by dd on 15/1/16.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//


/*
 *定义接口
 */

//#define Interface_Server                    @"http://192.168.3.123/"//@"http://app.babysante.net/"//
#define Interface_Server                    @"http://app.babysante.net/"//@"http://app.babysante.net/"//
//#define Interface_Server                    @"http://app.babysante.com/"//@"http://app.babysante.net/"//


#define InterfaceAddressName(addressName)   [NSString stringWithFormat:@"%@%@",Interface_Server,addressName]

/**
 *  加密秘钥
 */
#define App_Secrect                         @"Gon1Lep8oN8rOgh9eW9Ouf3G"

/**
 *  加密后的信息的key 值为加密后的字符串
 */
#define App_Sign                            @"signature"


#define Return_message                      @"message"

#define Return_result                       @"ret"

#define Return_data                         @"return_data"



//

//
//  ApiDetail.h
//  AFuSports
//
//  Created by apple on 15/12/23.
//  Copyright (c) 2015年 apple. All rights reserved.

//在项目中把所有的API对应的相对URL地址、参数注释要求等等都放在了这里，好统一管理。

#ifndef AFuSports_ApiDetail_h
#define AFuSports_ApiDetail_h

#define AFuBaseAPI @"http://kentoyo.gicp.net:8080"

#define privateKey @"606b99f6a699b9e5689944ce51386168"
//验证码

#define URL_captcha  @"/api/member/captcha"

//登录模块
#define URL_REGISTER @"/api/member/register"
#define URL_LOGIN @"/api/member/login"
#define URL_FORGET @"/api/member/forget"
#define URL_LOGOUT @"/api/member/logout"
#define URL_RESET @"/api/member/reset"

#endif

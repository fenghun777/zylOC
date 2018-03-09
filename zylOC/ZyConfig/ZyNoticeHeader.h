
//
//  ZyNoticeHeader.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#ifndef ZyNoticeHeader_h
#define ZyNoticeHeader_h

//定义所有的通知相关

#define ZyNoticePost(n,o,u) [[NSNotificationCenter defaultCenter] postNotificationName:n object:o userInfo:u];


#define ZyNoticeAdd(s,n,o) [[NSNotificationCenter defaultCenter] addObserver:self selector:s name:n object:o]

#define ZyNotice_NoticeName @"ZyNotice_NoticeName"

#endif /* ZyNoticeHeader_h */

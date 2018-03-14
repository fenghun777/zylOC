//
//  NSUserDefaults+ZyCategory.h
//  zylOC
//
//  Created by yy z on 2018/3/14.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (ZyCategory)

//            删除所有存储在userdefault里的缓存
+ (void)zy_ResetDefaults;

@end

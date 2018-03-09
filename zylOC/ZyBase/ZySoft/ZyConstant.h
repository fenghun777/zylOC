//
//  ZyConstant.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyConstant : NSObject
+ (NSString *)urlWithKey:(NSString *)key;
+ (NSString *)urlWithKey:(NSString *)key andParam:(NSString *)param;
@end

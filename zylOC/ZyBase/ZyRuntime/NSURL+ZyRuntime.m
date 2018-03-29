//
//  NSURL+ZyRuntime.m
//  zylOC
//
//  Created by yy z on 2018/3/28.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "NSURL+ZyRuntime.h"
#import "ZyRuntime.h"

@implementation NSURL (ZyRuntime)

/**
 *  这个类一加载到内存当中就会调用(就是系统加载到内存中就会自动调用且只会调用一次，不用我们手动调用)
 */
+ (void)load{
    [ZyRuntime zy_ReplaceClassMethod:[NSURL class] originalSelector:@selector(URLWithString:) otherSelector:@selector(zy_URLWithString:)];
}

+ (instancetype)zy_URLWithString:(NSString *)URLString{
    NSURL *url = [NSURL zy_URLWithString:URLString];
    if (url == nil) {
        NSLog(@"======url为空");
    }
    return url;
}















@end

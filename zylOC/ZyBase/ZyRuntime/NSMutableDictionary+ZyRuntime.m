//
//  NSMutableDictionary+ZyRuntime.m
//  zylOC
//
//  Created by yy z on 2018/3/28.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "NSMutableDictionary+ZyRuntime.h"
#import "ZyRuntime.h"


@implementation NSMutableDictionary (ZyRuntime)

/**
 *  这个类一加载到内存当中就会调用(就是系统加载到内存中就会自动调用且只会调用一次，不用我们手动调用)
 */
+ (void)load{
    [ZyRuntime zy_ReplaceInstanceMethod:NSClassFromString(@"__NSDictionaryM") originalSelector:@selector(setObject:forKey:) otherSelector:@selector(zy_SetObject:forKey:)];
}

- (void)zy_SetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (aKey == nil || anObject == nil) {
        NSLog(@"能来到这里说明向字典里面添加了一个空值或者key为nil!!为了保证不崩溃这里相当于什么都没有做");
    } else {
        [self zy_SetObject:anObject forKey:aKey];
    }
}

@end

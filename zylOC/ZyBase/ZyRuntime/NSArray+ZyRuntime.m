//
//  NSArray+ZyRuntime.m
//  zylOC
//
//  Created by yy z on 2018/3/28.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "NSArray+ZyRuntime.h"
#import "ZyRuntime.h"

@implementation NSArray (ZyRuntime)

/**
 *  这个类一加载到内存当中就会调用(就是系统加载到内存中就会自动调用且只会调用一次，不用我们手动调用)
 */
+ (void)load{
    [ZyRuntime zy_ReplaceInstanceMethod:NSClassFromString(@"__NSArrayI") originalSelector:@selector(objectAtIndex:) otherSelector:@selector(zy_ObjectAtIndex:)];
}

/**
 *  要交换的方法
 *  @param index  下标
 */
- (id)zy_ObjectAtIndex:(NSUInteger)index {
    if (index <= self.count) {
        /* 能来到这里说明数组没有越界(之所以调用这个方法 是因为两个方法已经调换了 下面那句相当于调用原来的方法) */
        return [self zy_ObjectAtIndex:index];
    } else {
        NSLog(@"能来到这里说明数组越界了!!为了保证不崩溃返回是一个空相当于什么都没有做");
        return nil;
    }
}



@end

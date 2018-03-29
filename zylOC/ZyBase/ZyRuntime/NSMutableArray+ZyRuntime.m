//
//  NSMutableArray+ZyRuntime.m
//  zylOC
//
//  Created by yy z on 2018/3/28.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "NSMutableArray+ZyRuntime.h"
#import "ZyRuntime.h"

@implementation NSMutableArray (ZyRuntime)

/**
 *  这个类一加载到内存当中就会调用(就是系统加载到内存中就会自动调用且只会调用一次，不用我们手动调用)
 */
+ (void)load{
    [ZyRuntime zy_ReplaceInstanceMethod:NSClassFromString(@"__NSArrayM") originalSelector:@selector(objectAtIndex:) otherSelector:@selector(zy_ObjectAtIndex:)];
    
    [ZyRuntime zy_ReplaceInstanceMethod:NSClassFromString(@"__NSArrayM") originalSelector:@selector(addObject:) otherSelector:@selector(zy_AddObject:)];
    
    [ZyRuntime zy_ReplaceInstanceMethod:NSClassFromString(@"__NSArrayM") originalSelector:@selector(replaceObjectAtIndex:withObject:) otherSelector:@selector(zy_ReplaceObjectAtIndex:withObject:)];
}

- (id)zy_ObjectAtIndex:(NSUInteger)index {
    if (index <= self.count) {
        return [self zy_ObjectAtIndex:index];
    } else {
        NSLog(@"能来到这里说明数组越界了!!为了保证不崩溃返回是一个空相当于什么都没有做");
        return nil;
    }
}

- (void)zy_AddObject:(id)anObject {
    if (anObject == nil) {
        NSLog(@"能来到这里说明向数组里面添加了一个空值!!");
    } else {
        [self zy_AddObject:anObject];
    }
}

- (void)zy_ReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index > self.count || anObject == nil) {
        NSLog(@"能来到这里说明向数组里面替换了一个空值!!或者数组越界");
    } else {
        [self zy_ReplaceObjectAtIndex:index withObject:anObject];
    }
}

@end

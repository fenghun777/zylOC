//
//  NSMutableArray+ZyCategory.m
//  zylOC
//
//  Created by yy z on 2018/3/12.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "NSMutableArray+ZyCategory.h"

@implementation NSMutableArray (ZyCategory)

+ (NSMutableArray *)zy_ArrayByMovingItemToFirst:(NSMutableArray *)array withItemIndexToMove:(NSInteger)index{
    id item = array[index];
    [array removeObjectAtIndex:index];
    [array insertObject:item atIndex:0];
    
    return array;
}


@end

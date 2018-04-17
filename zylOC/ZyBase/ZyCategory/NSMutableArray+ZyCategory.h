//
//  NSMutableArray+ZyCategory.h
//  zylOC
//
//  Created by yy z on 2018/3/12.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ZyCategory)

//MARK:移动数组的某一项到第一项
+ (NSMutableArray *)zy_ArrayByMovingItemToFirst:(NSMutableArray *)array withItemIndexToMove:(NSInteger)index;

@end

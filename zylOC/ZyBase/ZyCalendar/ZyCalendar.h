//
//  ZyCalendar.h
//  zylOC
//
//  Created by 张钰营 on 2018/6/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^dateBlock)(NSUInteger,NSUInteger);

@interface ZyCalendar : NSObject

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, copy) dateBlock block;

- (NSArray *)setDayArr;

- (NSArray *)nextMonthDataArr;

- (NSArray *)lastMonthDataArr;
@end

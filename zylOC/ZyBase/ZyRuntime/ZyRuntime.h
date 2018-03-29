//
//  ZyRuntime.h
//  zylOC
//
//  Created by yy z on 2018/3/28.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZyRuntime : NSObject

/**
 *  通过运行时机制 为NSObject基类拓展一个类方法 替换工厂方法(可以把系统的工厂方法替换掉)
 *
 *  @param class            类 （为哪个类交换方法）
 *  @param originalSelector 系统的方法 类方法
 *  @param otherSelector    要交换的方法（自己处理过得方法） 类方法
 */
+ (void)zy_ReplaceClassMethod:(Class)class originalSelector:(SEL)originalSelector otherSelector:(SEL)otherSelector;

/**
 *  通过运行时机制 为NSObject基类拓展一个类方法 替换实例方法(可以把系统的对象方法替换掉)
 *
 *  @param class            类 （为哪个类交换方法）
 *  @param originalSelector 系统的方法 实例方法
 *  @param otherSelector    要交换的方法（自己处理过得方法） 实例方法
 */
+ (void)zy_ReplaceInstanceMethod:(Class)class originalSelector:(SEL)originalSelector otherSelector:(SEL)otherSelector;

@end

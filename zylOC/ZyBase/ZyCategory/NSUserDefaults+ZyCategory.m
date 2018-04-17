//
//  NSUserDefaults+ZyCategory.m
//  zylOC
//
//  Created by yy z on 2018/3/14.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "NSUserDefaults+ZyCategory.h"

@implementation NSUserDefaults (ZyCategory)

+ (void)zy_ResetDefaults{
//    这两种方式都可以删除
//    第一种
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *appDomain = [[NSBundle mainBundle]bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
//    第二种
    NSDictionary * dict = [userDefaults dictionaryRepresentation];
    for (id key in dict) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

+ (id)zy_GetValueForKey:(NSString *)key{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    id value = [userdefaults objectForKey:key];
    return value;
}

@end

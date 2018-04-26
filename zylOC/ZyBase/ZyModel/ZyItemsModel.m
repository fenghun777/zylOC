//
//  ZyItemsModel.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyItemsModel.h"

@implementation ZyItemsModel

//归档
- (void)encodeWithCoder:(NSCoder *)coder{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([ZyItemsModel class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
//        归档
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
//    c语言必须自己释放 ARC无法释放
    free(ivars);
}

//解档
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([ZyItemsModel class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            //        解档
            id value = [coder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        //    c语言必须自己释放 ARC无法释放
        free(ivars);
    }
    return self;
}


@end

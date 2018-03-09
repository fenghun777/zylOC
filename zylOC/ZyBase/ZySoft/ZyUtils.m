//
//  ZyUtils.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyUtils.h"

@implementation ZyUtils

+ (NSMutableArray *)arrayByMovingItemToFirst:(NSMutableArray *)array withItemIndexToMove:(NSInteger)index {
    id item = array[index];
    [array removeObjectAtIndex:index];
    [array insertObject:item atIndex:0];
    
    return array;
}

+ (NSString *)chineseToUTF8:(NSString *)str{
    NSMutableString *muStr = (NSMutableString *)str;
    
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            NSString *chineseStr = [str substringWithRange:NSMakeRange(i, 1)];
            NSString *utfStr = [chineseStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            muStr = (NSMutableString *)[muStr stringByReplacingOccurrencesOfString:chineseStr withString:utfStr];
        }
    }
    return (NSString *)muStr;
}
































@end

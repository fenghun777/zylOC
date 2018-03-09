//
//  UIColor+ZyCategory.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "UIColor+ZyCategory.h"

@implementation UIColor (ZyCategory)

+ (UIColor *)zy_RandomColor{
    CGFloat red =  arc4random_uniform(255);
    CGFloat blue = arc4random_uniform(255);
    CGFloat green = arc4random_uniform(255);
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

#pragma mark - 随机颜色（十六进制）
+ (NSString *)zy_RandomColorSixteen{
    NSString *colorString = @"";
    NSArray *colorArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"a", @"b", @"c", @"d", @"e", @"f"];
    
    for (NSInteger i= 0; i < 6; i++)
    {
        int r = arc4random()%colorArray.count;
        NSString *string = colorArray[r];
        colorString = [NSString stringWithFormat:@"%@%@", colorString, string];
    }
    NSLog(@"随机颜色为：%@", colorString);
    return colorString;
}

+ (UIColor *)zy_ColorWithHexString: (NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}




@end

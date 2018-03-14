//
//  NSDate+ZyCategory.m
//  zylOC
//
//  Created by yy z on 2018/3/14.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "NSDate+ZyCategory.h"

@implementation NSDate (ZyCategory)

+(NSString *)zy_TimeStamp{    
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

+ (BOOL)zy_DateIs24Or12{
    NSString *formatStringForHours=[NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA=[formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM=containsA.location!=NSNotFound;
    if (hasAMPM==true)
    {
        echo(@"为12小时制");
    }
    else
    {
        echo(@"为24小时制");
    }
    return hasAMPM;
}

+(NSString *)zy_FormattedTime:(NSDate *)thedate{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    NSTimeInterval ti = [thedate timeIntervalSinceDate:date];
    NSInteger hour = (ti / 3600);
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            datef.dateFormat = @"HH:mm";
        }else if (hour < 0 && hour >= -24) {
            datef.dateFormat = NSLocalizedString(@"NSDateCategory.text8", @"");
        }else {
            datef.dateFormat = @"yy/MM/dd HH:mm";
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            datef.dateFormat = NSLocalizedString(@"NSDateCategory.text9", @"");
        }else if (hour > 6 && hour <=11 ) {
            datef.dateFormat = NSLocalizedString(@"NSDateCategory.text10", @"");
        }else if (hour > 11 && hour <= 17) {
            datef.dateFormat = NSLocalizedString(@"NSDateCategory.text11", @"");
        }else if (hour > 17 && hour <= 24) {
            datef.dateFormat = NSLocalizedString(@"NSDateCategory.text12", @"");
        }else if (hour < 0 && hour >= -24){
            datef.dateFormat = NSLocalizedString(@"NSDateCategory.text13", @"");
        }else  {
            datef.dateFormat = @"yy/MM/dd";
        }
    }
    
    ret = [datef stringFromDate:thedate];
    return ret;
}

@end

//
//  ZyCalendar.m
//  zylOC
//
//  Created by 张钰营 on 2018/6/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyCalendar.h"

@interface ZyCalendar ()
@property (nonatomic, strong) NSCalendar *calendar;//日历
@property (nonatomic, assign) NSInteger second;//秒
@property (nonatomic, assign) NSInteger minute;//分
@property (nonatomic, assign) NSInteger hour;//时
@property (nonatomic, assign) NSInteger day;//天
@property (nonatomic, assign) NSInteger month;//月
@property (nonatomic, assign) NSInteger year;//年
@property (nonatomic, strong) NSMutableArray *dayArray;

@end

@implementation ZyCalendar

- (instancetype)init{
    if (self = [super init]) {
        //        NSCalendarIdentifierGregorian  = 公历 (阳历)
        //        NSCalendarIdentifierChinese  = 中国农历
        //        NSCalendarIdentifierBuddhist  = 佛教日历
        //        NSCalendarIdentifierIndian  = 印度日历
        //        NSCalendarIdentifierRepublicOfChina  = 中华民国日历（中国台湾）
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        //    NSCalendarUnitEra               = 纪元单位,
        //    NSCalendarUnitYear              = 年单位。值很大。（2016）年
        //    NSCalendarUnitMonth             = 月单位。范围为1-12
        //    NSCalendarUnitDay               = 天单位。范围为1-31
        //    NSCalendarUnitHour              = 小时单位。范围为0-24
        //    NSCalendarUnitMinute            = 分钟单位。范围为0-60
        //    NSCalendarUnitSecond            = 秒单位。范围为0-60
        //    NSCalendarUnitWeekday           = 星期单位。范围为1-7 （一个星期有七天）
        //    NSCalendarUnitWeekdayOrdinal    = 以7天为单位，范围为1-5 （1-7号为第1个7天，8-14号为第2个7天...）
        //    NSCalendarUnitQuarter           = 刻钟单位。范围为1-4 （1刻钟等于15分钟）
        //    NSCalendarUnitWeekOfMonth       = 月包含的周数。最多为6个周
        //    NSCalendarUnitWeekOfYear        = 年包含的周数。最多为53个周
        //    NSCalendarUnitYearForWeekOfYear = 暂未深究...
        //    NSCalendarUnitNanosecond        = 纳秒单位
        //    NSCalendarUnitCalendar          = 暂未深究...
        //    NSCalendarUnitTimeZone          = 暂未深究...
        NSDateComponents *nowCompoents =[self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        self.year = nowCompoents.year;
        self.month = nowCompoents.month;
        self.day = nowCompoents.day;
        self.hour = nowCompoents.hour;
        self.minute = nowCompoents.minute;
        self.second = nowCompoents.second;
        self.dayArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)setDayArr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld-%ld-%ld-%ld",_year,_month,_day, _hour, _minute, _second]];
    //本月的天数范围
    NSRange dayRange = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:nowDate];
    //上个月的天数范围
    NSRange lastdayRange = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self setLastMonthWithDay]];
    //本月第一天的NSDate对象
    NSDate *nowMonthfirst = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",_year,_month,1]];
    //本月第一天是星期几
    NSDateComponents * components = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:nowMonthfirst];
    //本月最后一天的NSDate对象
    NSDate * nextDay = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,dayRange.length]];
    NSDateComponents * lastDay = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:nextDay];
    //上个月遗留的天数
    for (NSInteger i = lastdayRange.length - components.weekday + 2; i <= lastdayRange.length; i++) {
        NSString * string = [NSString stringWithFormat:@"%ld",i];
        [self.dayArray addObject:string];
    }
    //本月的总天数
    for (NSInteger i = 1; i <= dayRange.length ; i++) {
        NSString * string = [NSString stringWithFormat:@"%ld",i];
        [self.dayArray addObject:string];
    }
    //下个月空出的天数
    for (NSInteger i = 1; i <= (7 - lastDay.weekday); i++) {
        NSString * string = [NSString stringWithFormat:@"%ld",i];
        [self.dayArray addObject:string];
    }
    self.index = components.weekday - 2 + self.day;
    self.block(_year, _month);
    return self.dayArray;
}

//返回本月第一天的NSDate对象
- (NSDate *)firstDayDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.year;
    components.month = self.month;
    components.day = 1;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

//返回上个月第一天的NSDate对象
- (NSDate *)setLastMonthWithDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = nil;
    if (self.month != 1) {
        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d",self.year,self.month-1,01]];
    }else{
        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%d-%d",self.year - 1,12,01]];
    }
    return date;
}

//下个月的数据
- (NSArray *)nextMonthDataArr {
    [self.dayArray removeAllObjects];
    if (_month == 12) {
        _month = 1;
        _year ++;
    }else {
        _month ++;
    }
    return [self setDayArr];
}

//上个月的数据
- (NSArray *)lastMonthDataArr {
    [self.dayArray removeAllObjects];
    if (_month == 1) {
        _month = 12;
        _year --;
    }else {
        _month --;
    }
    return [self setDayArr];
}














@end

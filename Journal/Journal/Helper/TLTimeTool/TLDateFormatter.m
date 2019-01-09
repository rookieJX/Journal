


//
//  TLDateFormatter.m
//  apartment
//
//  Created by JH on 2017/7/28.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "TLDateFormatter.h"

@implementation TLDateFormatter
static TLDateFormatter *_instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [_instance setDateFormat:@"yyyy-MM-dd"];
    });
    return _instance;
}


+ (instancetype)defaultDateFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
+(NSString *)dateFommater:(NSDate *)date{
    if (!date) {
        return @"";
    }
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [NSString stringWithFormat:@"%ld年 %ld月 %ld日",(long)comps.year,comps.month,comps.day];
}
+(NSDate *)stringDateFommater:(NSString *)stringDate{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *createdAtDate = [fmt dateFromString:stringDate];
    return createdAtDate;
}
+(NSDate *)dateBackwardsDate:(NSDate *)backwardsDate yearWards:(NSInteger)yearWards monthWards:(NSInteger)monthWard dayWards:(NSInteger)dayWard{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *comps = nil;
//    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:backwardsDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:yearWards];
    [adcomps setMonth:monthWard];
    [adcomps setDay:dayWard];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:backwardsDate options:0];
    return newdate;
}
+(struct TimeDifferenceStruct)caclutefromDate:(NSDate *)fromeDate toDate:(NSDate *)dtoDate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:fromeDate toDate:dtoDate options:0];
    int year = (int)components.year;
    int month = (int)components.month;
    int day = (int)components.day;

    struct TimeDifferenceStruct timeStruct = { year,month,day };
    return timeStruct;
}
+(NSInteger )compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return -1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return 1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}
@end

//
//  TLDateFormatter.h
//  apartment
//
//  Created by JH on 2017/7/28.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

struct TimeDifferenceStruct {
    int year;
    int month;
    int day;
};
/**
 时间格式：默认@"yyyy-MM--dd"，可以自己在设置
 */
@interface TLDateFormatter : NSDateFormatter
+ (instancetype)sharedInstance;
+ (instancetype)defaultDateFormatter;

/**
 %ld年 %ld月 %ld日
 */
+(NSString *)dateFommater:(NSDate *)date;

/**
 yyyy-mm-dd
 */
+(NSDate *)stringDateFommater:(NSString *)stringDate;

/**
 日期向后推 year month day
 */
+(NSDate *)dateBackwardsDate:(NSDate *)backwardsDate yearWards:(NSInteger)yearWards monthWards:(NSInteger)monthWard dayWards:(NSInteger)dayWard;

/**
 俩日期差多少年月日
 */
+(struct TimeDifferenceStruct)caclutefromDate:(NSDate *)fromeDate toDate:(NSDate *)dtoDate;

/**
 oneday和anotherday比较早晚
    -1,oneDay比 anotherDay时间晚
    1、oneDay比 anotherDay时间早
    0、俩时间一致
 */
+(NSInteger )compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
@end

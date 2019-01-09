//
//  TL_JudgeHelper.m
//  Bank94
//
//  Created by Liu Hui on 2017/4/24.
//  Copyright © 2017年 tonglingwangluo. All rights reserved.
//

#import "TLJudgeHelper.h"

@implementation TLJudgeHelper
+(BOOL)judgeIsNullId:(id)object
{
    if(object == nil)
    {
        return YES;
    }
    else if([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+(BOOL)judgeIsEmptyDictionary:(NSDictionary *)judgeDictionary{
    if (![judgeDictionary isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if (judgeDictionary.count <= 0) {
        return YES;
    }else{
        return NO;
    }
}
+(BOOL)judgeStringIsEmpty:(NSString *)judgeString{
    if (![judgeString isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (judgeString == nil || judgeString == NULL) {
        return YES;
    }
    if ([judgeString isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[judgeString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([judgeString isEqualToString:@"null"]) {
        return YES;
    }
    if ([judgeString isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([judgeString isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}
+(BOOL)judgeImageIsEmpty:(UIImage *)judgeImage{
    CGImageRef cgref = [judgeImage CGImage];
    CIImage *cim = [judgeImage CIImage];
    
    if (cim == nil && cgref == NULL)
    {
        return YES;
    } else {
        return NO;
    }
}
+ (BOOL)judgeIsPhoneNumber:(NSString *)judgeString {
   
    // 只判断1开头，11位数字
    NSString *phoneRegex = @"1[0-9]{10}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:judgeString];
    
}

+ (BOOL)judgeIsNumber:(NSString *)judgeString {
    NSString * regex        = @"(/^[0-9]*$/)";
    
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch            = [pred evaluateWithObject:judgeString];
    
    if (isMatch) {
        
        return YES;
        
    }else{
        
        return NO;
        
    }
   
}

+ (BOOL)judgeIsTLPwdRule:(NSString *)judgeString {

    if (!judgeString) {
        return NO;
    }
    
    judgeString = [self cutStringWithWihtespaceAndNewLine:judgeString];
    
    if (judgeString.length < 6 || judgeString.length > 16) {
        return NO;
    }
    
    return YES;
    
}

//返回去除空格和换行的字符串
+ (NSString *)cutStringWithWihtespaceAndNewLine:(NSString *)sourceStr
{
    return [sourceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//验证新的交易密码，6位数字
+(BOOL)vertifyNewTradePwd:(NSString *)newTradePwd{
    NSString * regex = @"^\\d{6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:newTradePwd];
    return isMatch;
}

+(BOOL)currentTimeInCurrentTime:(NSDate *)nowDate FromTime:(NSString *)fromTimeStr ToTime:(NSString *)toTimeStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *fromeDate = [fmt dateFromString:fromTimeStr];
    NSDate *toDate = [fmt dateFromString:toTimeStr];
    // 获得比较结果(谁大谁小)
    NSComparisonResult nowAndFromDateResult = [nowDate compare:fromeDate];
    NSComparisonResult nowAndToDateResult = [nowDate compare:toDate];
    //比from大，比to则在区间内
    if (nowAndFromDateResult == NSOrderedDescending && nowAndToDateResult == NSOrderedAscending) {
        return YES;
    }else{
        return NO;
    }
    
}

+ (BOOL)limitTextField:(UITextField *)textField length:(NSInteger)length {
    NSString * toBeString = textField.text;
    
    NSString * lang       = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) { // 如果输入的是简体中文
        UITextRange * selectRange = [textField markedTextRange];
        // 获取高亮部分
        UITextPosition * position = [textField positionFromPosition:selectRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length < length) {
                return YES;
            } else  {
                textField.text = [toBeString substringToIndex:length];
                return YES;
            }
        } else {
            return YES;
        }
    } else { // 中文输入法以外的直接对其进行统计限制即可，不考虑其他情况
        if (toBeString.length < length) {
            return YES;
        } else {
            textField.text = [toBeString substringToIndex:length];
            return YES;
        }
    }
}
@end

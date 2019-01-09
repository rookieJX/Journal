//
//  TL_JudgeHelper.h
//  Bank94
//
//  Created by Liu Hui on 2017/4/24.
//  Copyright © 2017年 tonglingwangluo. All rights reserved.
//

//判断相关逻辑，放在这个类方法中
#import <Foundation/Foundation.h>

@interface TLJudgeHelper : NSObject

/**
 判断对象为空对象

 @param object 输入对象
 @return 对象是否为空
 */
+(BOOL)judgeIsNullId:(id)object;
/**
 判断字典对象是否为字典或者是否为空

 @param judgeDictionary 被判断的输入的dic
 @return YES,不是字典类型或者为空字典,NO，是字典类型，不为空
 */
+(BOOL)judgeIsEmptyDictionary:(NSDictionary *)judgeDictionary;

/**
 判断字符串为空字符串或者是否为字符串类型

 @param judgeString 判断的字符串
 @return YES：为空字符串或者类型不为字符串，NO：是字符串类型并不为空
 */
+(BOOL)judgeStringIsEmpty:(NSString *)judgeString;


/**
 判断字符串是不是手机号码

 @param judgeString 判断的字符串
 @return YES：是手机号码，NO：不是手机号码
 */
+ (BOOL)judgeIsPhoneNumber:(NSString *)judgeString;

/**
 判断字符串是不是纯数字
 
 @param judgeString 判断的字符串
 @return YES：是数字，NO：不是数字
 */
+ (BOOL)judgeIsNumber:(NSString *)judgeString;


/**
 判断是不是规定的密码格式

 @param judgeString 判断的字符串
 @return YES：是正确的格式，NO：不是正确的格式
 */
+ (BOOL)judgeIsTLPwdRule:(NSString *)judgeString;
/**
 判断图片是否是空图片
 */
+ (BOOL)judgeImageIsEmpty:(UIImage *)judgeImage;

/**
 验证新的交易密码

 @param newTradePwd 新的交易密码
 @return 是否符合
 */
+(BOOL)vertifyNewTradePwd:(NSString *)newTradePwd;


/**
 判断当前时间是否在指定的时间戳里

 @param nowDate 当前时间
 @param fromTimeStr 开始时间
 @param toTimeStr 结束时间
 @return 返回结果
 */
+(BOOL)currentTimeInCurrentTime:(NSDate *)nowDate FromTime:(NSString *)fromTimeStr ToTime:(NSString *)toTimeStr;

/**
 限时输入长度
 
 @param textField 限制输入控件
 @param length 限制输入长度
 @return 限制结果
 */
+ (BOOL)limitTextField:(UITextField *)textField length:(NSInteger)length;

@end

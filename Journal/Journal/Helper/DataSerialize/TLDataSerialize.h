//
//  TL_DataSerialize.h
//  Bank94
//
//  Created by Liu Hui on 2017/4/24.
//  Copyright © 2017年 tonglingwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLDataSerialize : NSObject

/**
将字典转化为字符串字典

 @param dictionary 传入要转化的字典
 @return 转化后的字符串
 */
+(NSString *)dictionarySerializeToString:(NSDictionary *)dictionary;

/**
 将可变字典转化为字符串字典

 @param mutableDictionary 传入要转化的可变字典
 @return 转化后的字符串
 */
+(NSString *)mutableDictionarySerializeToString:(NSMutableDictionary *)mutableDictionary;

/**
 数组序列化成字符串
 */
+(NSString *)arrarySerializeToString:(NSArray *)arrary;
/**
 将字典字符串转化格式为字典

 @param dictionaryString 字典字符串
 @return 转化后的字典
 */
+(NSDictionary *)stringSerializerToDictionary:(NSString *)dictionaryString;

/**
  将字符串转化格式为id
 */
+(id)stringSerializerToID:(NSString *)dictionaryString;
/**
 将字典或者数组转为jsondata

 @param dicOrArry 传入字典或者字符串均可
 @return 返回data格式的json数据
 */
+(NSData *)searializerToJsonDataWithDicOrArry:(id)dicOrArry;

/**
 <#Description#>

 @param M <#M description#>
 @param par <#par description#>
 @return <#return value description#>
 */
+(NSDictionary *)searializerRequestParamaters:(NSString *)M par:(id)par;

/**
 压缩图片到尺寸 720x720，并返回data

 @param image 要压缩的图片
 @return 返回压缩后图片的data
 */
+(NSData *)searializerImageCompress:(UIImage *)image;

/**
 压缩图片到尺寸 720x720，并返回base64编码后的data

 @param image 要压缩的图片
 @return base64编码后的data
 */
+(NSString *)searializerImageCompressBase64:(UIImage *)image;
@end

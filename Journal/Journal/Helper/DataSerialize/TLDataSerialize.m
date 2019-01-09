//
//  TL_DataSerialize.m
//  Bank94
//
//  Created by Liu Hui on 2017/4/24.
//  Copyright © 2017年 tonglingwangluo. All rights reserved.
//

#import "TLDataSerialize.h"

@implementation TLDataSerialize
+(NSString *)dictionarySerializeToString:(NSDictionary *)dictionary{
    if ([TLJudgeHelper judgeIsEmptyDictionary:dictionary]) {
        return @"";
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dictionaryStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return dictionaryStr;
}
+(NSString *)mutableDictionarySerializeToString:(NSMutableDictionary *)mutableDictionary{
    NSDictionary *dictionary = mutableDictionary;
    return [self dictionarySerializeToString:dictionary];
}
+(NSString *)arrarySerializeToString:(NSArray *)arrary{
    if (arrary.count <= 0 ) {
        return @"";
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dictionaryStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return dictionaryStr;
}
+(NSDictionary *)stringSerializerToDictionary:(NSString *)dictionaryString{
    if ([TLJudgeHelper judgeStringIsEmpty:dictionaryString]) {
        return @{};
    }
    NSData *JSONData = [dictionaryString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
+(id)stringSerializerToID:(NSString *)dictionaryString{
    if ([TLJudgeHelper judgeStringIsEmpty:dictionaryString]) {
        return @{};
    }
    NSData *JSONData = [dictionaryString dataUsingEncoding:NSUTF8StringEncoding];
    id responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
+(NSData *)searializerToJsonDataWithDicOrArry:(id)dicOrArry{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicOrArry
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
+(NSDictionary *)searializerRequestParamaters:(NSString *)M par:(id)par{
    NSDictionary *paramters = @{
                                @"D":[TLJudgeHelper judgeIsEmptyDictionary:par]?@{}:par,
                                @"M":M
                                }.copy;
    return paramters;
}
+(NSData *)searializerImageCompress:(UIImage *)image{
    NSData  * data = UIImageJPEGRepresentation([TLMyControlTool imageWithImage:image scaledToSize:CGSizeMake(image.size.width*2/3, image.size.height*2/3)], 1);
    return data;
}
+(NSString *)searializerImageCompressBase64:(UIImage *)image{
//    NSData  * data = [self compressImageWithImage:image aimLength:300*1024 accuracyOfLength:1024];
    NSData *data = [self zipImageWithImage:image];
    NSString *imgStr =[[NSString alloc] initWithData: [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength] encoding:NSUTF8StringEncoding];
    imgStr = [imgStr stringByReplacingOccurrencesOfString:@"=" withString:@"<"];
    return imgStr;
}
+ (NSData *)compressImageWithImage:(UIImage *)image aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy{
    UIImage * newImage = [UIImage imageWithData:[self searializerImageCompress:image]];
    NSData  * data = UIImageJPEGRepresentation(newImage, 0.4);
    return data;
//    NSInteger imageDataLen = [data length];
//    if (imageDataLen <= length + accuracy) {
//        return data;
//    }else{
//        NSData * imageData = UIImageJPEGRepresentation( newImage, 0.99);
//        if (imageData.length < length + accuracy) {
//            return imageData;
//        }
//        CGFloat maxQuality = 1.0;
//        CGFloat minQuality = 0.0;
//        int flag = 0;
//        while (1) {
//            CGFloat midQuality = (maxQuality + minQuality)/2;
//            if (flag == 6) {
//                return UIImageJPEGRepresentation(newImage, minQuality);
//            }
//            flag ++;
//            NSData * imageData = UIImageJPEGRepresentation(newImage, midQuality);
//            NSInteger len = imageData.length;
//            if (len > length+accuracy) {
//                maxQuality = midQuality;
//                continue;
//            }else if (len < length-accuracy){
//                minQuality = midQuality;
//                continue;
//            }else{
//                return imageData;
//                break;
//            }
//        }
//    }
}

/**
 压图片质量
 
 @param image image
 @return Data
 */
+ (NSData *)zipImageWithImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    CGFloat maxFileSize = 200*1024;
    CGFloat compression = 0.9f;
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while ([compressedData length] > maxFileSize) {
        compression *= 0.9;
        compressedData = UIImageJPEGRepresentation([[self class] compressImage:image newWidth:image.size.width*compression], compression);
    }
    return compressedData;
}

/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
@end

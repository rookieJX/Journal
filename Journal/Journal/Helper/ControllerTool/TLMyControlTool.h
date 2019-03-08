//
//  TLMyControlTool.h
//  apartment
//
//  Created by 94bank on 2017/7/20.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  控制器工具

#import <Foundation/Foundation.h>

@interface TLMyControlTool : NSObject

+ (instancetype)defaultController;



/**
 不变形的压缩图片到特定尺寸

 @param image 压缩前图片
 @param newSize 新的尺寸
 @return 压缩后的图片
 */
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 打电话
 */
+(void)callToPhoneNumber:(NSString *)phoneNumber;
@end

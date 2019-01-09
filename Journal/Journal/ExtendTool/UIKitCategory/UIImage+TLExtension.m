//
//  UIImage+TLExtension.m
//  apartment
//
//  Created by 94bank on 2017/7/17.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "UIImage+TLExtension.h"

@implementation UIImage (TLExtension)

+ (UIImage *)originalImageWithImageName:(NSString *)imageName {
    
    UIImage * image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

+ (UIImage *)resizedImage:(NSString *)imageName {
    
    UIImage * image = [UIImage originalImageWithImageName:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5
                                      topCapHeight:image.size.height * 0.5];
    
}

- (UIImage *)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end

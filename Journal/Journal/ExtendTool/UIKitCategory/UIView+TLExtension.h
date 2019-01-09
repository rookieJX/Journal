//
//  UIView+TLExtension.h
//  apartment
//
//  Created by 94bank on 2017/7/17.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TLExtension)
@property (nonatomic, assign) CGFloat frameX;
@property (nonatomic, assign) CGFloat frameY;
@property (nonatomic, assign) CGFloat frameCenterX;
@property (nonatomic, assign) CGFloat frameCenterY;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;
@property (nonatomic, assign) CGSize  frameSize;
@property (nonatomic, assign) CGFloat frameMaxX;
@property (nonatomic, assign) CGFloat frameMaxY;

/**
 设置某一控件的圆角
 
 @param value 圆角半径
 @param rectCorner 圆角位置
 */
- (void)drawCornerViewRadius:(CGFloat)value roundingCorners:(UIRectCorner)rectCorner ;
@end

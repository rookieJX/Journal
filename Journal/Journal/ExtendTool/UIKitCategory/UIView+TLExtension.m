//
//  UIView+TLExtension.m
//  apartment
//
//  Created by 94bank on 2017/7/17.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "UIView+TLExtension.h"

@implementation UIView (TLExtension)
- (void)setFrameX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)frameX
{
    return self.frame.origin.x;
}

- (void)setFrameY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)frameY
{
    return self.frame.origin.y;
}

- (CGFloat)frameMaxX{
    return self.frame.origin.x+self.frame.size.width;
}

- (void)setFrameMaxX:(CGFloat)MaxX{
    CGRect frame = self.frame;
    frame.origin.x = MaxX-self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)frameMaxY{
    return self.frame.origin.y+self.frame.size.height;
}

- (void)setFrameMaxY:(CGFloat)MaxY{
    CGRect frame = self.frame;
    frame.origin.y = MaxY-self.frame.size.height;
    self.frame = frame;
}

- (void)setFrameCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)frameCenterX
{
    return self.center.x;
}

- (void)setFrameCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)frameCenterY
{
    return self.center.y;
}

- (void)setFrameWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)frameWidth
{
    return self.frame.size.width;
}

- (void)setFrameHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGFloat)frameHeight
{
    return self.frame.size.height;
}

- (void)setFrameSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)frameSize
{
    return self.frame.size;
}

/**
 设置某一控件的圆角
 
 @param value 圆角半径
 @param rectCorner 圆角位置
 */
- (void)drawCornerViewRadius:(CGFloat)value roundingCorners:(UIRectCorner)rectCorner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end

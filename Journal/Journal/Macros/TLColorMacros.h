//
//  TLColorMacros.h
//  apartment
//
//  Created by 94bank on 2017/7/17.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  颜色类

#ifndef TLColorMacros_h
#define TLColorMacros_h

/** 随机色 */
#define kRandColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

/**
 根据颜色RGB设置颜色,alpha默认是1.0f
 
 @param R 红色色值
 @param G 绿色色值
 @param B 蓝色色值
 @return 返回UIColor
 */
#define TLRainColor(R,G,B)          TLRGBAColor(R,G,B,1.0)

/**
 根据颜色RGB设置颜色,alpha
 
 @param R 红色色值
 @param G 绿色色值
 @param B 蓝色色值
 @param AL alpha通道值
 @return 返回UIColor
 */
#define TLRGBAColor(R,G,B,AL)       [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(AL)]

/**
 根据十六进制色值设置颜色，alpha默认是1.0f
 
 @param hex 十六进制色值
 @return 返回UIColor
 */
#define TLHexColor(hex)             TLHexColorValues(hex,1.0f)

/**
 根据十六进制色值设置颜色
 
 @param hex 十六进制色值
 @param a alpha通道值
 @return 返回UIColor
 */
#define TLHexColorValues(hex,a)    ([UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a])

/**
 白色
 */
#define ColorWhite                 TLRainColor(255,255,255)
/**
 #228B22 主题色
 */
#define ColorTheme                  TLHexColor(0x228B22)
/**
 #999999 辅助、次要短文字
 */
#define ColorGray2                  TLRainColor(153,153,153)

/**
 #eeeeee用于分割线
 */
#define ColorLine                   TLRainColor(238,238,238)

/**
 #用于整个页面的背景色，即模块之间的分割色
 */
#define ColorBackground             ColorLine

/**
 #ffa000主要用于图标以及其他特殊文字颜色
 */
#define ColorOrange                 TLRainColor(255,160,0)

/**
 #70c155主要用于已经预定，再租的颜色
 */
#define ColorGreen                  TLRainColor(112, 193, 85)

/**
 #333333主要用于主要标题颜色
 */
#define ColorTitle                  TLRainColor(51, 51, 51)

/**
 #666666主要用于次要标题颜色
 */
#define ColorSubTitle                  TLRainColor(102, 102, 102)

/**
 #bcbcbc主要用于次要标题颜色
 */
#define ColorPlaceHolder                  TLRainColor(188, 188, 188)
#endif /* TLColorMacros_h */

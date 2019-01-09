//
//  UIButton+TLExtension.h
//  bank94
//
//  Created by 94bank on 2017/6/27.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//  按钮

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TLCategoryTitleType) {
    TLCategoryTtileTypeLeft = 111,  // 文字在左边
    TLCategoryTitleTypeBottom,      // 文字在下方
    TLCategoryTitleTypeTop,          // 文字在顶部
    TLCategoryTitleTypeDefault
};

@interface UIButton (TLExtension)


/**
 快速设置文字位置（默认文字在下方）
 @param titleType 文字位置
 */
- (void)tl_setButtonTtitleType:(TLCategoryTitleType)titleType;

@end

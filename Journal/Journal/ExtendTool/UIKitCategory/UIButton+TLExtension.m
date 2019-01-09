//
//  UIButton+TLExtension.m
//  bank94
//
//  Created by 94bank on 2017/6/27.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//

#import "UIButton+TLExtension.h"

@implementation UIButton (TLExtension)
- (void)tl_setButtonTtitleType:(TLCategoryTitleType)titleType {
    
    CGSize titleSize = self.titleLabel.intrinsicContentSize;
    CGSize imageSize = self.imageView.intrinsicContentSize;
    CGFloat interval = 1.0;   // 自定义一个间距
    
    switch (titleType) {
        case TLCategoryTitleTypeTop:  // 文字在顶部
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(titleSize.height,0, 0, -titleSize.width)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(-imageSize.height, -imageSize.width, 0, 0)];
        }
            break;
        case TLCategoryTtileTypeLeft:  // 文字在左边
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,titleSize.width, 0, -titleSize.width)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width)];
        }
            break;
        case TLCategoryTitleTypeBottom:  // 文字在底部
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(-(titleSize.height + interval),0, 0, -titleSize.width)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval, -imageSize.width, 0, 0)];
        }
            break;
        default:
            break;
    }
}


@end

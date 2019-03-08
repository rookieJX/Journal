//
//  UIBarButtonItem+TLExtension.m
//  apartment
//
//  Created by 94bank on 2017/7/17.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "UIBarButtonItem+TLExtension.h"
#import "UIImage+TLExtension.h"

@implementation UIBarButtonItem (TLExtension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                                target:(id)target
                                action:(SEL)action {
    // 创建导航栏
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 创建正常状态下按钮
    [button setImage:[UIImage imageNamed:imageName]
            forState:UIControlStateNormal];
    
    // 创建选中状态下按钮
    [button setImage:[UIImage imageNamed:highImageName]
            forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.frameSize = button.currentImage.size;
    
    // 监听按钮的点击
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title  style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    
    // 创建按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 创建正常状态下的文字
    [button setTitle:title
            forState:UIControlStateNormal];
    
    // 创建正常状态下的文字
    [button setTitleColor:[UIColor blackColor]
                 forState:UIControlStateNormal];
    
    // 正常状态下的文字尺寸
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // 选中状态下的文字颜色
    [button setTitleColor:[UIColor lightGrayColor]
                 forState:UIControlStateHighlighted];
    
    // 禁用状态下的文字颜色
    [button setTitleColor:[UIColor lightGrayColor]
                 forState:UIControlStateDisabled];
    
    // 文字自适应
    [button sizeToFit];
    
    // 监听方法
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end

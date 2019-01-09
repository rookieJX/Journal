//
//  UIBarButtonItem+TLExtension.h
//  apartment
//
//  Created by 94bank on 2017/7/17.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  快速设置按钮

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TLExtension)

/**
 *  快速设置导航栏上图片
 *
 *  @param imageName     图片名称
 *  @param highImageName 选中图片名称
 *  @param target        目标函数
 *  @param action        方法名
 *
 *  @return 返回导航栏按钮
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

/**
 *  快速设置导航栏上文字
 *
 *  @param title  导航栏文字
 *  @param style  文字样式
 *  @param target 目标函数
 *  @param action 方法名称
 *
 *  @return 返回导航栏按钮
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title  style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;

@end

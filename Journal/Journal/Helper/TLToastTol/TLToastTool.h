//
//  TLToastTool.h
//  apartment
//
//  Created by 94bank on 2017/7/20.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  弹框提醒

#import <UIKit/UIKit.h>

@interface TLToastTool : UIView


/**
 弹框提醒文字

 @param message 提醒文字
 */
+ (void)showMessage:(NSString *)message;

/**
 弹出视图(居中)
 
 @param view 视图
 @return 背景
 */
+ (instancetype)makeToastView:(UIView *)view;


/**
 弹出视图(底部)

 @param view 视图
 @return 背景
 */
+ (instancetype)makeToasBottomView:(UIView *)view;

/**
 移除视图
 */
- (void)removeTool;

@end

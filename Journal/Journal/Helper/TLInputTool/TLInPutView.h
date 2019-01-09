//
//  TLInPutView.h
//  bank94
//
//  Created by 94bank on 2017/6/22.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//  封装登录界面输入框

#import <UIKit/UIKit.h>

@class TLInPutView;

@protocol TLInPutViewDelegate <NSObject>

@optional

/**
 点击了清除按钮
 */
- (void)inputViewDidClieckClearButton:(TLInPutView *)inputView;

@end

@interface TLInPutView : UITextField


/**
 输入控件

 @param inputImageName 输入控件名称
 @param imageToContentMargin 图片到内容间距
 @param placeHolder 占位文字
 @return 输入控件
 */
+ (instancetype)inputViewWithInputImageName:(NSString *)inputImageName marginImageToContent:(CGFloat)imageToContentMargin placeHolderText:(NSString *)placeHolder;


/**
 输入控件(左边图片到文字间距为20时使用这个方法)
 
 @param inputImageName 输入控件名称
 @param placeHolder 占位文字
 @return 输入控件
 */
+ (instancetype)inputViewWithInputImageName:(NSString *)inputImageName placeHolderText:(NSString *)placeHolder;

/**
 输入代理
 */
@property (weak, nonatomic) id<TLInPutViewDelegate>inputViewDelegate;

@end

//
//  TLTimeButton.h
//  bank94
//
//  Created by 94bank on 2017/6/23.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//  倒计时按钮

#import <UIKit/UIKit.h>

@class TLTimeButton;

@protocol TLTimerButtonDelegate <NSObject>

@required
- (void)timerButtonDidClick:(TLTimeButton *)button;

@end

@interface TLTimeButton : UIButton

/** 按钮点击 */
@property (nonatomic,weak) id<TLTimerButtonDelegate> delegate;


/**
 打开倒计时

 @param lastTime 倒计时时间
 */
-(void)openCountdownWithTime:(NSInteger)lastTime;

@end

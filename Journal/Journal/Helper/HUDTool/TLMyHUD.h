//
//  TLMyHUD.h
//  bank94
//
//  Created by Liu Hui on 2017/6/27.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TLMyHUD : NSObject

/**
 初始化

 @return 初始化
 */
+ (TLMyHUD *)shareMyHUDManger;

-(void)showLoadingViewTo:(UIView *)view;

-(void)hidLoadingViewTo:(UIView *)view;
@end

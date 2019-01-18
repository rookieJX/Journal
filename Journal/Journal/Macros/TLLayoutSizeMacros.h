//
//  TLLayoutSizeMacros.h
//  TLBasicDev
//
//  Created by 宋俊红 on 17/1/23.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#ifndef TLLayoutSizeMacros_h
#define TLLayoutSizeMacros_h
#pragma mark -----------------------------------------尺寸大小--------------------------------------------
/**
 是否是X的设备（指的是屏幕尺寸）
 */
#define UI_IS_IPHONEX         (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 812.0)

/**
 底部TarBar高度
 */
#define UI_TABBAR_HEIGHT                (UI_IS_IPHONEX ? 83 : 49)
/**
 状态栏高度
 */
#define UI_NAVIGATION_STATUSBAR_HEIGHT   (UI_IS_IPHONEX ? 44 : 20)

/**
 导航栏高度
 */
#define UI_NAVIGATION_HEIGHT             (UI_IS_IPHONEX ? 88 : 64)

/**
 屏幕的宽度

 @return 屏宽
 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**
 屏幕的高度

 @return 屏高
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


/**
 屏幕尺寸

 @return 尺寸
 */
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

/**
 tabbar 的高度

 @return 49
 */
#define TABBAR_HEIGHT  49

/**
 状态栏的高度

 @return 20
 */
#define STATUSBAR_HEIGHT 20

/**
 导航栏的高度

 @return 49
 */
#define NAVBAR_HEIGHT  44


/**
 一般来说，控件的左边距
 
 @return 15
 */
#define LEFT_GAP  15

/**
 线的高度
 
 @return 0.5
 */
#define LINE_HEIGHT  0.5

/**
 当前屏幕宽度/750屏幕宽度，相对于750宽度的屏幕，
 
 @return 相对的比例
 */
#define  ScreenWTo750 SCREEN_WIDTH*2/750.0


/**
 抽屉效果向右拖动距离

 @return 拖动距离
 */
#define SCREEN_DRAW_MARGIN 250.0f


/**
 客源管理界面选项卡高度

 @return 高度
 */
#define CUSTOMER_HEADER_HEIGHT 55.0f

#endif /* TLLayoutSizeMacros_h */

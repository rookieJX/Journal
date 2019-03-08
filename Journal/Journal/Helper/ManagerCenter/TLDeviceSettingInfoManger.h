//
//  TLDeviceSettingInfoManger.h
//  Journal
//
//  Created by 王加祥 on 2019/1/9.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define     kSetting_isShowWelcomeScrollerView  @"isShowWelcomeScrollerview"


NS_ASSUME_NONNULL_BEGIN

@interface TLDeviceSettingInfoManger : NSObject

/**
 初始化
 
 @return 初始化
 */
+(instancetype)shareManger;

/**
 设置当前已经显示过的新特性界面的版本号
 
 @param version 版本号
 */
- (void)setWelcomeBeatVersionValue:(NSString *)version;

/**
 获取是否需要显示新特性引导界面
 
 @return YES表示需要再显示
 */
-(BOOL)getIsShowWelcomeScrollerview;
@end

NS_ASSUME_NONNULL_END

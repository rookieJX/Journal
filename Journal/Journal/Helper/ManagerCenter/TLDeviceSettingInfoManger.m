//
//  TLDeviceSettingInfoManger.m
//  Journal
//
//  Created by 王加祥 on 2019/1/9.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "TLDeviceSettingInfoManger.h"

@interface TLDeviceSettingInfoManger ()
@property (strong, nonatomic) NSUserDefaults*  settingDefaults;
@end

@implementation TLDeviceSettingInfoManger

#pragma mark - ClassLoad
+(instancetype)shareManger{
    static dispatch_once_t onceToken;
    static TLDeviceSettingInfoManger *settingManger = nil;
    dispatch_once(&onceToken, ^{
        settingManger = [[self alloc]init];
        settingManger.settingDefaults = [NSUserDefaults standardUserDefaults];
    });
    return settingManger;
}


#pragma mark - Meth
#pragma mark Setter/Getter LeadingMeth
- (void)setWelcomeBeatVersionValue:(NSString *)version {
    [self.settingDefaults setValue:version forKey:kSetting_isShowWelcomeScrollerView];
}
- (BOOL)getIsShowWelcomeScrollerview{
    
    // 保存的版本
    NSString *saveVersion = [self.settingDefaults objectForKey:kSetting_isShowWelcomeScrollerView];
    
    // 当前版本
    NSString *currentVersion = TL_CURRENT_VERSION;
    if (![currentVersion isEqualToString:saveVersion]) { // 如果是第一次使用，就进入版本新特性控制器
        return YES;
        
    } else {
        
        return NO;
    }
}
@end

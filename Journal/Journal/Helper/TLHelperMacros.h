//
//  TLHelperMacros.h
//  apartment
//
//  Created by 94bank on 2017/7/17.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  辅助类文件

#ifndef TLHelperMacros_h
#define TLHelperMacros_h

#import "TLDeviceSettingInfoManger.h"


#pragma mark - 判断类
    #import "TLJudgeHelper.h"

#pragma mark - 手机设备
    #import "TLDeviceTools.h"


#pragma mark - 网络中心
    #import "TLAppInfoManager.h"

#pragma mark - 暂无数据
    #import "TLNoDataView.h"


/**
 设置中心
 
 @return 设置中心
 */
#define MyDeviceSettingManger       [TLDeviceSettingInfoManger shareManger]

#endif /* TLHelperMacros_h */

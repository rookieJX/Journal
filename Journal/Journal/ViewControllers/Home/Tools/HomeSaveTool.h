//
//  HomeSaveTool.h
//  Journal
//
//  Created by 王加祥 on 2019/3/6.
//  Copyright © 2019 JX.Wang. All rights reserved.
//  保存工具

#import <Foundation/Foundation.h>
#import "HomeRecordingModel.h"

#define KEY_RECORDING_LIST @"sp_recording_list"
#define HOME_RECORDING_CACHE [HomeSaveTool sharedHomeSaveTool]


@interface HomeSaveTool : NSObject

singleton_interface(HomeSaveTool);

#pragma mark - 设置本地语音缓存
- (void)setHomeRecrodingModelCache:(NSArray <HomeRecordingModel *>*)array;
#pragma mark - 获取本地语音缓存
- (NSArray <HomeRecordingModel *>*)getHomeRecordingModelCache;
#pragma mark - 清除本地缓存
- (void)remoHomeRecordingModelCache;
@end


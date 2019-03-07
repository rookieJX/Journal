//
//  AudioRecorder.h
//  Journal
//
//  Created by 王加祥 on 2019/3/7.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioRecorder : NSObject

#pragma mark - 录音

/// 实例化单例
+ (AudioRecorder *)shareManager;

#pragma mark - 音频处理-录音

/// 开始录音
- (void)audioRecorderStartWithFilePath:(NSString *)filePath;

/// 停止录音
- (void)audioRecorderStop;

/// 录音时长
- (NSTimeInterval)durationAudioRecorderWithFilePath:(NSString *)filePath;

#pragma mark - 音频处理-播放/停止

/// 音频开始播放或停止
- (void)audioPlayWithFilePath:(NSString *)filePath;

/// 音频播放停止
- (void)audioStop;

@end

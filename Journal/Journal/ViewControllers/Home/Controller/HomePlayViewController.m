//
//  HomePlayViewController.m
//  Journal
//
//  Created by 王加祥 on 2019/3/7.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "HomePlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface HomePlayViewController ()<AVAudioPlayerDelegate>
/** 标题 */
@property (nonatomic,strong) UILabel * titleLabel;
/** 时间 */
@property (nonatomic,strong) UILabel * timeLabel;
/** 播放进度条 */
@property (nonatomic,strong) UIProgressView * playProgressView;
@end

@implementation HomePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self config_nav];
    
    [self config_layout];
    
    [self config_data];
}

- (void)config_nav {
    
    self.navigationItem.title   = @"播放语音";
    
    self.view.backgroundColor   = ColorBackground;
}

- (void)config_data {
    self.titleLabel.text = [NSString stringWithFormat:@"语音标题\n\n%@",self.recordingModel.title];
    self.timeLabel.text  = [NSString stringWithFormat:@"语音时长\n\n%@",[self getFormatString:self.recordingModel.time]];
    
    if (kStringIsEmpty(self.recordingModel.filePath) ) {
        [TLToastTool showMessage:@"语音播放失败"];
        return;
    }
    
    
}


- (void)config_layout {
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(20);
        make.height.mas_equalTo(@(100));
    }];
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(@(70));

    }];
    
    [self.playProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(@(2));
    }];
}

- (NSString *)getFormatString:(NSInteger)totalSeconds {
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
}

#pragma mark - Lazy Loading

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel           = [[UILabel alloc] init];
        _titleLabel.font      = FONT_18;
        _titleLabel.textColor = ColorTitle;
        _titleLabel.numberOfLines   = 0;
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel           = [[UILabel alloc] init];
        _timeLabel.font      = FONT_14;
        _timeLabel.textColor = ColorSubTitle;
        _timeLabel.numberOfLines    = 0;
        _timeLabel.textAlignment    = NSTextAlignmentCenter;
        [self.view addSubview:_timeLabel];
    }
    return _timeLabel;
}


- (UIProgressView *)playProgressView{
    if (_playProgressView == nil) {
        _playProgressView = [[UIProgressView alloc] init];
        _playProgressView.trackTintColor    = TLRainColor(214, 229, 222);
        _playProgressView.progressTintColor = TLRainColor(77, 183, 224);
        _playProgressView.progress  = 0;
        [self.view addSubview:_playProgressView];
    }
    return _playProgressView;
}

@end

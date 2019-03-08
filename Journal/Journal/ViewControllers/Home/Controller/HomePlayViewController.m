//
//  HomePlayViewController.m
//  Journal
//
//  Created by 王加祥 on 2019/3/7.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "HomePlayViewController.h"
#import "AudioRecorder.h"


@interface HomePlayViewController ()
/** 标题 */
@property (nonatomic,strong) UILabel * titleLabel;
/** 时间 */
@property (nonatomic,strong) UILabel * timeLabel;
/** 播放进度条 */
@property (nonatomic,strong) UIProgressView * playProgressView;
@property (nonatomic,strong) NSTimer *recordTimer;
@property (nonatomic,assign) NSTimeInterval totalRecordingSeconds;
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
    
    // 设置push到的控制器的默认的导航按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back"
                                                                           highImageName:@"navigationbar_back_highlighted"
                                                                                  target:self
                                                                                  action:@selector(back)];
}

- (void)config_data {
    self.titleLabel.text = [NSString stringWithFormat:@"语音标题\n\n%@",self.recordingModel.title];
    self.timeLabel.text  = [NSString stringWithFormat:@"语音时长\n\n%.0lf s",self.recordingModel.time];
    
    if (kStringIsEmpty(self.recordingModel.filePath) ) {
        [TLToastTool showMessage:@"语音播放失败"];
        return;
    }
    
    [[AudioRecorder shareManager] audioPlayWithFilePath:self.recordingModel.filePath];
    [self startRecordTimer];
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

- (void)back {
    [[AudioRecorder shareManager] audioStop];
    [self.navigationController popViewControllerAnimated:YES];
}

// 开始定时器
- (void)startRecordTimer {
    
    self.totalRecordingSeconds  = 0.0f;
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(actionForRecordTimerAction:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)actionForRecordTimerAction:(CADisplayLink *)displaylink {
    TL_CLog(@"当前时间：%lf--%lf--%ld",displaylink.timestamp,displaylink.duration,displaylink.preferredFramesPerSecond);
    
    if (self.totalRecordingSeconds >= self.recordingModel.time) {
        [displaylink invalidate];
        
        displaylink = nil;
    } else {
        CGFloat rate = self.totalRecordingSeconds / self.recordingModel.time;
        TL_CLog(@"当前比例：%lf---%lf",rate,self.recordingModel.time);
        self.playProgressView.progress  = rate;
    }
    self.totalRecordingSeconds += 0.017;
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

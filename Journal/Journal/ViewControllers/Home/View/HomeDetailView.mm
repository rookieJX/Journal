//
//  HomeDetailView.m
//  Journal
//
//  Created by 王加祥 on 2019/1/18.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "HomeDetailView.h"
#import <AVFoundation/AVFoundation.h>
#import "HomeRecordingModel.h"
#import "AudioRecorder.h"

#define sampleRate 44100
#define kRecordingTitleLength 16

@interface HomeDetailView ()<AVAudioRecorderDelegate>
/** 地址 */
@property (nonatomic,strong) NSString * filePath;
/** 输入标题 */
@property (nonatomic,strong) UITextField * titleTextField;
/** 统计数字 */
@property (nonatomic,strong) UILabel * titleCountLabel;
/** 录音提示图片 */
@property (nonatomic,strong) UIImageView * recordingImageView;
/** 统计时间 */
@property (nonatomic,strong) UILabel * recordingTimeLabel;
/** 保存按钮 */
@property (nonatomic,strong) UIButton * saveButton;
/** 暂停按钮 */
@property (nonatomic,strong) UIButton * pauseButton;
#pragma mark - 录音相关参数
@property (nonatomic,strong) NSTimer *recordTimer;
/** 录音时间（单位：s） */
@property (nonatomic,assign) NSInteger totalRecordingSeconds;
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;
/** 列表 */
@property (nonatomic,strong) NSMutableArray * saveRecordingArrays;
/** 当前录音模型 */
@property (nonatomic,strong) HomeRecordingModel * currentRecordingModel;
@end

@implementation HomeDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config_init];
        [self config_layout];
    
    }
    return self;
}

#pragma mark - Init
- (void)config_init {
    self.backgroundColor       = TLRainColor(242, 250, 252);
    self.totalRecordingSeconds = 0;
    self.saveRecordingArrays   = @[].mutableCopy;
    NSArray *currentArrays     = [HOME_RECORDING_CACHE getHomeRecordingModelCache];
    if(currentArrays.count) [self.saveRecordingArrays addObjectsFromArray:currentArrays];
}
#pragma mark - Layout
- (void)config_layout {
    
    [self.titleCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(16);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.width.mas_equalTo(@(40));
        make.height.mas_equalTo(@(37));
    }];
    
    [self.titleTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(16);
        make.left.mas_equalTo(self).mas_offset(20);
        make.right.mas_equalTo(self.titleCountLabel.mas_left).mas_offset(5);
        make.height.mas_equalTo(@(37));
    }];
    
    [self.pauseButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@(100));
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-15);
    }];
    
    [self.recordingTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_equalTo(15);
        make.right.mas_equalTo(self.mas_right).mas_equalTo(-15);
        make.height.mas_equalTo(@(30));
        make.bottom.mas_equalTo(self.pauseButton.mas_top).mas_offset(-10);
    }];
    
    [self.recordingImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(@(102));
        make.bottom.mas_equalTo(self.recordingTimeLabel.mas_top).mas_offset(-150);
    }];
    
    [self.saveButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.pauseButton);
        make.right.mas_equalTo(self.pauseButton.mas_left).mas_offset(-15);
        make.width.height.mas_equalTo(@(70));
    }];
    
}


- (NSString *)getFormatString:(NSInteger)totalSeconds {
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
}
#pragma mark - Target
- (void)actionForSaveButtonClick {
    self.pauseButton.selected   = NO;
    [self stopRecording];
    
}

- (void)actionForPauseButtonClick:(UIButton *)sender {
    self.pauseButton.selected   = !sender.isSelected;
    [self privateRecordingStatus];
}

- (void)actionForTitleTextFieldChaged:(UITextField *)textField {
    NSString *toBeString = textField.text;
    NSString * lang       = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) { // 如果输入的是简体中文
        UITextRange * selectRange = [textField markedTextRange];
        // 获取高亮部分
        UITextPosition * position = [textField positionFromPosition:selectRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kRecordingTitleLength) {
                self.titleTextField.text = [toBeString substringToIndex:kRecordingTitleLength];
            } else {
                [self feedbackStringWithMessage:toBeString];
            }
        }
    } else { // 中文输入法以外的直接对其进行统计限制即可，不考虑其他情况
        if (toBeString.length > kRecordingTitleLength) {
            // 提醒最长字符
            self.titleTextField.text = [toBeString substringToIndex:kRecordingTitleLength];
        }else {
            [self feedbackStringWithMessage:toBeString];
            
        }
    }
}

#pragma mark - Public Meth
/**
 开始录音
 */
- (void)actionForHomeDetailViewStartRecording {
    self.pauseButton.selected   = YES;
    [self privateRecordingStatus];
}

/**
 暂停录音
 */
- (void)actionForHomeDetailViewPauseRecording {
    self.pauseButton.selected   = NO;
    [self privateRecordingStatus];
}

#pragma mark - 录音相关
#pragma mark 开始录音
- (void)startRecording {
    [self startRecordTimer];
    [self startRecorder];
}


// 开始定时器
- (void)startRecordTimer {
    if (!self.recordTimer) {
        self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(actionForRecordTimerAction) userInfo:nil repeats:YES];
        [self.recordTimer setFireDate:[NSDate distantPast]];
        [[NSRunLoop currentRunLoop] addTimer:self.recordTimer forMode:NSRunLoopCommonModes];
    }
}


//// 开始录音
//- (void)startRecordPlayer {
//
//    if (![self.audioRecorder isRecording]) {
//        [self.audioRecorder record];
//    }
//
//}

#pragma mark 暂停录音
- (void)pauseRecording {
    [self pauseRecordTimer];
    [self pauseRecordPlayer];
}


// 暂停定时器
- (void)pauseRecordTimer {
    if (self.recordTimer) {
        [self.recordTimer invalidate];
        self.recordTimer = nil;
    }
}

// 暂停录音
- (void)pauseRecordPlayer {
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
    }
    
}

#pragma mark 结束录音
- (void)stopRecording {
    [self stopRecordTimer];
    
    [self stopRecordPlayer];
    // 保存录音按钮
    [self getAACDataSource];
}

// 结束定时器
- (void)stopRecordTimer {
    [self pauseRecordTimer];
}

// 结束录音
- (void)stopRecordPlayer {
    [self.audioRecorder stop];
}
#pragma mark - Target
- (void)actionForRecordTimerAction {
    self.totalRecordingSeconds += 1;
    
    self.recordingTimeLabel.text    = [self getFormatString:self.totalRecordingSeconds];
}

#pragma mark - Private Meth
- (void)feedbackStringWithMessage:(NSString *)message {
    self.titleCountLabel.text   = [NSString stringWithFormat:@"%ld/16",message.length];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
- (void)privateRecordingStatus {
    if (self.pauseButton.isSelected) { // 开始录音
        [self startRecording];
    } else { // 暂停录音
        [self pauseRecording];
        
    }
}

#pragma mark - Getter
- (void)getAACDataSource {
    
    NSString *folderPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.aac",[self getCurrentSavingTitle]]];
    if (!kStringIsEmpty(folderPath)) {
        TL_CLog(@"文件保存地址：%@",folderPath);
        self.currentRecordingModel = [[HomeRecordingModel alloc] init];
        self.currentRecordingModel.filePath = folderPath;
        self.currentRecordingModel.time     = self.totalRecordingSeconds;
        self.currentRecordingModel.title = kStringIsEmpty(self.titleTextField.text) ? [NSString stringWithFormat:@"默认标题%@",[self getCurrentSavingTitle]] : self.titleTextField.text;
        [self uploadRecordingFile];
    }
}

// 上传文件
- (void)uploadRecordingFile {
    [self.saveRecordingArrays addObject:self.currentRecordingModel];
    [HOME_RECORDING_CACHE setHomeRecrodingModelCache:self.saveRecordingArrays];
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionForHomeDetailViewSave:)]) {
        [self.delegate actionForHomeDetailViewSave:self];
    }
}

#pragma mark - Lazy Loading
- (UITextField *)titleTextField{
    if (_titleTextField == nil) {
        _titleTextField                 = [[UITextField alloc] init];
        _titleTextField.backgroundColor = [UIColor whiteColor];
        _titleTextField.borderStyle     = UITextBorderStyleNone;
        _titleTextField.placeholder     = @"语音记事本";
        _titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _titleTextField.font            = [UIFont systemFontOfSize:14];
        _titleTextField.textColor       = TLRainColor(102, 102, 102);
        _titleTextField.leftView        = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, 0)];
        _titleTextField.leftViewMode    = UITextFieldViewModeAlways;
        [_titleTextField addTarget:self action:@selector(actionForTitleTextFieldChaged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_titleTextField];
    }
    return _titleTextField;
}

- (UILabel *)titleCountLabel{
    if (_titleCountLabel == nil) {
        _titleCountLabel = [[UILabel alloc] init];
        _titleCountLabel.backgroundColor    = [UIColor whiteColor];
        _titleCountLabel.textColor  = TLRainColor(153, 153, 153);
        _titleCountLabel.font   = [UIFont systemFontOfSize:12];
        _titleCountLabel.text   = @"0/16";
        _titleCountLabel.textAlignment  = NSTextAlignmentCenter;
        [self addSubview:_titleCountLabel];
    }
    return _titleCountLabel;
}

- (UIImageView *)recordingImageView{
    if (_recordingImageView == nil) {
        _recordingImageView = [[UIImageView alloc] init];
        _recordingImageView.image   = [UIImage imageNamed:@"yy_ts"];
        [self addSubview:_recordingImageView];
    }
    return _recordingImageView;
}

- (UILabel *)recordingTimeLabel{
    if (_recordingTimeLabel == nil) {
        _recordingTimeLabel               = [[UILabel alloc] init];
        _recordingTimeLabel.textColor     = TLRainColor(102, 102, 102);
        _recordingTimeLabel.font          = [UIFont systemFontOfSize:18];
        _recordingTimeLabel.textAlignment = NSTextAlignmentCenter;
        _recordingTimeLabel.text = @"00:00:00";
        [self addSubview:_recordingTimeLabel];
    }
    return _recordingTimeLabel;
}
- (UIButton *)saveButton{
    if (_saveButton == nil) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setBackgroundImage:[UIImage imageNamed:@"yy_bc"] forState:UIControlStateNormal];
        [_saveButton setBackgroundImage:[UIImage imageNamed:@"yy_bc2"] forState:UIControlStateHighlighted];
        [_saveButton addTarget:self action:@selector(actionForSaveButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_saveButton];
    }
    return _saveButton;
}

- (UIButton *)pauseButton{
    if (_pauseButton == nil) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pauseButton.adjustsImageWhenHighlighted  = NO;
        [_pauseButton setBackgroundImage:[UIImage imageNamed:@"yy_ly_ks"] forState:UIControlStateNormal];
        [_pauseButton setBackgroundImage:[UIImage imageNamed:@"yy_zt"] forState:UIControlStateSelected];
        [_pauseButton addTarget:self action:@selector(actionForPauseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pauseButton];
    }
    return _pauseButton;
}


- (AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [session setActive:YES error:nil];
        
        //创建录音文件保存路径
        NSURL *url                     = [self getAACPath];
        //创建录音参数
        NSDictionary *setting          = [self getAudioSetting];
        NSError *error                 = nil;
        _audioRecorder                 = [[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate        = self;
        _audioRecorder.meteringEnabled = YES;
        [_audioRecorder prepareToRecord];
        if (error) {
            NSLog(@"创建AVAudioRecorder Error：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

- (NSURL *)getAACPath {
    NSString *folderPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.aac",[self getCurrentSavingTitle]]];
    NSURL *url=[NSURL fileURLWithPath:folderPath];
    return url;
}


/**
 *  录音参数设置
 */
- (NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    [dicM setObject:@(kAudioFormatMPEG4AAC) forKey:AVFormatIDKey];
    [dicM setObject:@(sampleRate) forKey:AVSampleRateKey]; //44.1khz的采样率
    [dicM setObject:@(2) forKey:AVNumberOfChannelsKey];
    [dicM setObject:@(16) forKey:AVLinearPCMBitDepthKey]; //16bit的PCM数据
    [dicM setObject:[NSNumber numberWithInt:AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    return dicM;
}


/**
 获取当前保存默认标题
 
 @return 保存后的默认标题
 */
- (NSString *)getCurrentSavingTitle {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
    
}
- (void)dealloc
{
    TL_CLog(@"释放语音记事本");
}





// 开始录音
- (void)startRecorder
{
    self.filePath = [[AudioRecorder shareManager] GetFilePathWithDate];
    [[AudioRecorder shareManager] audioRecorderStartWithFilePath:self.filePath];
}

// 停止录音，并保存
- (void)saveRecorder
{
    [[AudioRecorder shareManager] audioRecorderStop];
}

// 录音开始播放，或停止
- (void)playRecorder
{
    [[AudioRecorder shareManager] audioPlayWithFilePath:self.filePath];
}

// 录音停止播放
- (void)stopRecorder
{
    [[AudioRecorder shareManager] audioStop];
}

@end

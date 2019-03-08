//
//  HomeDetailViewController.m
//  Journal
//
//  Created by 王加祥 on 2019/1/18.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "HomeDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioRecorder.h"
#import "HomeRecordingModel.h"

#define kRecordingTitleLength 16

@interface HomeDetailViewController ()

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong) NSMutableArray    *recorderMutableArray;


@property (nonatomic,strong) NSTimer *recordTimer;
@property (nonatomic,assign) NSInteger totalRecordingSeconds;
@property (nonatomic,strong) UILabel * recordingTimeLabel;
/** 输入标题 */
@property (nonatomic,strong) UITextField * titleTextField;
/** 统计数字 */
@property (nonatomic,strong) UILabel * titleCountLabel;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config_base];
    
    [self audioRecordingStart];
    
}

#pragma mark - Base
- (void)config_base {
    self.navigationItem.title   = @"语音记事本";
    self.view.backgroundColor   = ColorBackground;
    
    self.recorderMutableArray   = @[].mutableCopy;
}

#pragma mark - View
- (void)config_views {
    
    [self.titleCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(16);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.width.mas_equalTo(@(40));
        make.height.mas_equalTo(@(37));
    }];
    
    [self.titleTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(16);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.titleCountLabel.mas_left).mas_offset(5);
        make.height.mas_equalTo(@(37));
    }];
    
    [self.recordingTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_equalTo(15);
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(-15);
        make.height.mas_equalTo(@(30));
        make.top.mas_equalTo(self.titleTextField.mas_bottom).mas_offset(20);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0, SCREEN_HEIGHT - UI_TABBAR_HEIGHT - UI_NAVIGATION_HEIGHT, SCREEN_WIDTH, UI_TABBAR_HEIGHT);
    button.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [button setTitle:@"按下开始录音" forState:UIControlStateNormal];
    [button setTitle:@"正在录音 释放停止录音" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    // 录音响应
    [button addTarget:self action:@selector(recordStartButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(recordStopButtonUp:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(recordStopButtonExit:) forControlEvents:UIControlEventTouchDragOutside];
}

#pragma mark - 录音相关
// 开始录音
- (void)audioRecordingStart {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session respondsToSelector:@selector(requestRecordPermission:)]){
        [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted)
            {  //用户同意获取麦克风
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self config_views];
                });
            }else{
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"系统未检测到麦克风权限" message:@"是否跳转到设置界面打开语音功能？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"跳转" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL  success) {}];
                    }
                }];
                [controller addAction:cancelAction];
                [controller addAction:sureAction];
                [self presentViewController:controller animated:YES completion:nil];
            }
        }];
    }
}



#pragma mark - Target
- (void)recordStartButtonDown:(UIButton *)button
{
    [self startRecorder];
    [self startRecordTimer];
}

- (void)recordStopButtonUp:(UIButton *)button
{
    TL_CLog(@"抬起");
    [self stopRecorder];
    [self saveRecorder];
}

- (void)recordStopButtonExit:(UIButton *)button
{
    TL_CLog(@"取消");
    [self abandonRecorder];
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
#pragma mark - Private Meth
- (void)feedbackStringWithMessage:(NSString *)message {
    self.titleCountLabel.text   = [NSString stringWithFormat:@"%ld/16",message.length];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// 开始定时器
- (void)startRecordTimer {
    if (!self.recordTimer) {
        self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(actionForRecordTimerAction) userInfo:nil repeats:YES];
        [self.recordTimer setFireDate:[NSDate distantPast]];
        [[NSRunLoop currentRunLoop] addTimer:self.recordTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)actionForRecordTimerAction {
    self.totalRecordingSeconds += 1;
    
    self.recordingTimeLabel.text    = [NSString stringWithFormat:@"录音时长：%ld s",self.totalRecordingSeconds];
}
- (void)pauseRecordTimer {
    if (self.recordTimer) {
        [self.recordTimer invalidate];
        self.recordTimer = nil;
    }
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
#pragma mark - 录音方法

// 开始录音
- (void)startRecorder
{
    self.filePath = [[AudioRecorder shareManager] GetFilePathWithDate];
    [[AudioRecorder shareManager] audioRecorderStartWithFilePath:self.filePath];
}

// 停止录音
- (void)stopRecorder {
    [[AudioRecorder shareManager] audioRecorderStop];
    [self pauseRecordTimer];
}



// 停止录音，并保存
- (void)saveRecorder
{
    
    NSArray *recorderArray = [HOME_RECORDING_CACHE getHomeRecordingModelCache];
    if (recorderArray.count)  [self.recorderMutableArray addObjectsFromArray:recorderArray];
    
    HomeRecordingModel *model   = [[HomeRecordingModel alloc] init];
    model.filePath  = self.filePath;
    model.time      = [[AudioRecorder shareManager] durationAudioRecorderWithFilePath:self.filePath];
    model.title     = [NSString stringWithFormat:@"录音备忘录%@",[self getCurrentSavingTitle]];
    [self.recorderMutableArray addObject:model];
    
    [HOME_RECORDING_CACHE setHomeRecrodingModelCache:self.recorderMutableArray];
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 丢弃录音
- (void)abandonRecorder {
    [self stopRecorder];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"是否要取消录音" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveRecorder];
    }];
    [controller addAction:cancelAction];
    [controller addAction:sureAction];
    [self presentViewController:controller animated:YES completion:nil];
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
        [self.view addSubview:_titleTextField];
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
        [self.view addSubview:_titleCountLabel];
    }
    return _titleCountLabel;
}
- (UILabel *)recordingTimeLabel{
    if (_recordingTimeLabel == nil) {
        _recordingTimeLabel               = [[UILabel alloc] init];
        _recordingTimeLabel.textColor     = TLRainColor(102, 102, 102);
        _recordingTimeLabel.font          = FONT_12;
        _recordingTimeLabel.textAlignment = NSTextAlignmentCenter;
        _recordingTimeLabel.text = @"录音时长：";
        [self.view addSubview:_recordingTimeLabel];
    }
    return _recordingTimeLabel;
}
- (void)dealloc {
    TL_CLog(@"释放HomeDetailViewController");
}
@end

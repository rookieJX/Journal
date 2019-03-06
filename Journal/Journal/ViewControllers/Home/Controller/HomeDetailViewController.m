//
//  HomeDetailViewController.m
//  Journal
//
//  Created by 王加祥 on 2019/1/18.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "HomeDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HomeDetailView.h"

@interface HomeDetailViewController ()<HomeDetailViewDelegate>
/** 界面 */
@property (nonatomic,strong) HomeDetailView * detailView;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config_base];
    
    [self detailView];
    
    [self audioRecordingStart];
}

#pragma mark - Base
- (void)config_base {
    self.navigationItem.title   = @"语音记事本";
    self.view.backgroundColor   = ColorBackground;
}

#pragma mark - Lazy Loading
- (HomeDetailView *)detailView{
    if (_detailView == nil) {
        _detailView = [[HomeDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-UI_NAVIGATION_HEIGHT)];
        _detailView.delegate    = self;
        [self.view addSubview:_detailView];
    }
    return _detailView;
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
                    [self.detailView actionForHomeDetailViewStartRecording];
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

#pragma mark - HomeDetailViewDelegate
- (void)actionForHomeDetailViewSave:(HomeDetailView *)detailView {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    TL_CLog(@"释放HomeDetailViewController");
}
@end

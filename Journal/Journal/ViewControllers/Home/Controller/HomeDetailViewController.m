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

@interface HomeDetailViewController ()
/** 界面 */
@property (nonatomic,strong) HomeDetailView * detailView;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config_base];
    
    [self detailView];
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
        [self.view addSubview:_detailView];
    }
    return _detailView;
}
@end

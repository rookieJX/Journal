//
//  HomeViewController.m
//  Journal
//
//  Created by 王加祥 on 2019/1/9.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewCell.h"
#import "HomeDetailViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 列表 */
@property (nonatomic,strong) UITableView * tableView;
/** 当前语音列表 */
@property (nonatomic,strong) NSArray * voicesListsArray;
/** 提醒创建语音 */
@property (nonatomic,strong) UILabel * backVoiceMessageLabel;
/** 创建语音按钮 */
@property (nonatomic,strong) UIButton * createVoiceButton;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self config_base];
    
    [self config_tableView];
    
    [self config_layout];
}
#pragma mark - UI
- (void)config_base {
    self.view.backgroundColor   = ColorBackground;
    self.navigationItem.title   = @"记事本";
}

- (void)config_tableView {
    self.tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-UI_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor  = ColorBackground;
    [self.tableView registerClass:[HomeViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeViewCell class])];
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)config_layout {
    [self.createVoiceButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(@(UI_TABBAR_HEIGHT));
    }];
}
#pragma mark - UITableViewDelegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = self.voicesListsArray.count;
    self.backVoiceMessageLabel.hidden   = count;
    self.tableView.hidden               = !count;
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeViewCell class]) forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do Something
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

#pragma mark - Target
- (void)actionForCreateButtonClick {
    HomeDetailViewController *detailController  = [[HomeDetailViewController alloc] init];
    [self.navigationController pushViewController:detailController animated:YES];
}
#pragma mark - Lazy
- (UILabel *)backVoiceMessageLabel{
    if (_backVoiceMessageLabel == nil) {
        _backVoiceMessageLabel = [[UILabel alloc] init];
        _backVoiceMessageLabel.text = @"当前还没有语音哦~\n点击创建语音按钮创建语音吧";
        _backVoiceMessageLabel.frame            = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-UI_NAVIGATION_HEIGHT-UI_TABBAR_HEIGHT);
        _backVoiceMessageLabel.textColor        = ColorPlaceHolder;
        _backVoiceMessageLabel.font             = FONT_14;
        _backVoiceMessageLabel.textAlignment    = NSTextAlignmentCenter;
        _backVoiceMessageLabel.numberOfLines    = 0;
        _backVoiceMessageLabel.backgroundColor  = ColorBackground;
        [self.view addSubview:_backVoiceMessageLabel];
    }
    return _backVoiceMessageLabel;
}
- (UIButton *)createVoiceButton{
    if (_createVoiceButton == nil) {
        _createVoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _createVoiceButton.titleLabel.font  = FONT_18;
        _createVoiceButton.backgroundColor  = ColorTheme;
        [_createVoiceButton setTitle:@"点击录音" forState:UIControlStateNormal];
        [_createVoiceButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [_createVoiceButton addTarget:self action:@selector(actionForCreateButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_createVoiceButton];
    }
    return _createVoiceButton;
}
@end

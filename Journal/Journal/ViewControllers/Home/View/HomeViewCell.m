//
//  HomeViewCell.m
//  Journal
//
//  Created by 王加祥 on 2019/1/10.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "HomeViewCell.h"

@interface HomeViewCell ()
/** 背景 */
@property (nonatomic,strong) UIView * backView;
/** 标题 */
@property (nonatomic,strong) UILabel * titleLabel;
/** 时间 */
@property (nonatomic,strong) UILabel * timeLabel;
@end

@implementation HomeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self config_view];
        [self config_layout];
    }
    
    return self;
}

- (void)config_view {
    self.contentView.backgroundColor    = ColorBackground;
    
    [self.contentView addSubview:self.backView];
}

- (void)config_layout {
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).mas_offset(10);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
    }];
    
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(80));
        make.top.bottom.mas_equalTo(self.backView);
        make.right.mas_equalTo(self.backView.mas_right).mas_offset(-10);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(10);
        make.top.bottom.mas_equalTo(self.backView);
        make.right.mas_equalTo(self.timeLabel.mas_right);
    }];
    
    
}

- (void)setRecordingModel:(HomeRecordingModel *)recordingModel {
    self.titleLabel.text    = recordingModel.title;
    self.timeLabel.text     = [self getFormatString:recordingModel.time];
}

- (NSString *)getFormatString:(NSInteger)totalSeconds {
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
}

#pragma mark - Lazy Loading
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor   = [UIColor whiteColor];
        _backView.clipsToBounds = YES;
        _backView.layer.cornerRadius    = 5.0f;
        [self.contentView addSubview:_backView];
    }
    return _backView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel           = [[UILabel alloc] init];
        _titleLabel.font      = FONT_16;
        _titleLabel.textColor = ColorTitle;
        _titleLabel.textAlignment   = NSTextAlignmentLeft;
        [self.backView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel           = [[UILabel alloc] init];
        _timeLabel.font      = FONT_12;
        _timeLabel.textColor = ColorSubTitle;
        _timeLabel.textAlignment    = NSTextAlignmentRight;
        [self.backView addSubview:_timeLabel];
    }
    return _timeLabel;
}
@end

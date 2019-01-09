//
//  TLNoDataView.m
//  apartment
//
//  Created by 94bank on 2017/8/1.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "TLNoDataView.h"

@implementation TLNoDataView

- (void)setNoDataWithType:(NoDataType)type {
    switch (type) {
        case NoDataTypeFeedback:
        {
            [self makeFeedbackNoDdateVie];
        }
            break;
        case NoDataTypeNomal:
        {
            [self makeNomalNoDateView];
        }
            break;
        default:
        {
            [self makeNomalNoDateView];
        }
            break;
    }

}



/**
 暂无报修记录
 */
- (void)makeFeedbackNoDdateVie {
    self.backgroundColor = ColorBackground;
    UIView *nodateView = [[UIView alloc] init];
    nodateView.backgroundColor = [UIColor clearColor];
    [self addSubview:nodateView];
    
    [nodateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
    UIImageView *nodateImView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NoFeedbackIMG"]];
    [nodateView addSubview:nodateImView];
    
    [nodateImView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(nodateView);
        make.top.mas_equalTo(nodateView.mas_top).mas_offset(160);
    }];
    
    UILabel *nodateLabel = [self creteLabelWithTitle:@"哎呀 ~ 还没有报修记录" font:nil textAlignment:NSTextAlignmentCenter];
    nodateLabel.textColor   = ColorGray2;
    [nodateView addSubview:nodateLabel];
    [nodateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(nodateView);
        make.top.mas_equalTo(nodateImView.mas_bottom).offset(40);
    }];

}



-(void)makeNomalNoDateView{
    
    self.backgroundColor = ColorBackground;
    UIView *nodateView = [[UIView alloc] init];
    nodateView.backgroundColor = [UIColor clearColor];
    [self addSubview:nodateView];
    
    [nodateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
    UIImageView *nodateImView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NoDataIMG"]];
    [nodateView addSubview:nodateImView];
    
    [nodateImView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(nodateView);
        make.bottom.mas_equalTo(nodateView.mas_bottom).mas_offset(-(SCREEN_HEIGHT-70)/2.0);
    }];
    
    UILabel *nodateLabel = [self creteLabelWithTitle:@"暂无数据" font:nil textAlignment:NSTextAlignmentCenter];
    nodateLabel.textColor   = ColorGray2;
    [nodateView addSubview:nodateLabel];
    [nodateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(nodateView);
        make.top.mas_equalTo(nodateImView.mas_bottom).offset(15);
    }];
}

/**
 快速创建label
 
 @param title 标题
 @param font 字体大小
 @param textAlignment 位置
 @return label
 */
- (UILabel *)creteLabelWithTitle:(NSString *)title font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label          = [[UILabel alloc] init];
    label.text              = [TLJudgeHelper judgeStringIsEmpty:title] ?  @"" : title;
    label.font              = font ? font : FONT_14;
    label.textAlignment     = textAlignment ? textAlignment : NSTextAlignmentLeft;
    return label;
}
@end

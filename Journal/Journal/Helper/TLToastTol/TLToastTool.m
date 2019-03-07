//
//  TLToastTool.m
//  apartment
//
//  Created by 94bank on 2017/7/20.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "TLToastTool.h"
#import "UIView+Toast.h"

#define kTLToastToolWidth  (TL_SCREEN_WIDTH - 100)      // 弹出框最大宽度
#define KTLToastToolHeight (TL_SCREEN_HEIGHT - 120)     // 弹出框最大高度
#define kTLToastToolAlertSureH 44               // 警告框底部确定按钮高度
#define kTLToastToolAlertMargin 15              // 警告文字左右间距
#define kTLToastToolAlertTopMargin 28           // 警告文字顶部间距
#define kTLToastToolAlertWidth (TL_SCREEN_WIDTH - 100 - kTLToastToolAlertMargin - kTLToastToolAlertMargin)      // 警告框最大宽度

@interface TLToastTool ()
/** 弹出文字显示 */
@property (strong, nonatomic) UILabel *messageLabel;
/** 背景 */
@property (nonatomic,weak) UIView * bGView;
/** 警告背景 */
@property (nonatomic,strong) UIView * alertView;
/** 确定按钮 */
@property (nonatomic,strong) UIButton * alertButton;
@end

@implementation TLToastTool


+ (void)showMessage:(NSString *)message {
    [TL_Winow hideToasts];
    CSToastStyle *tyle = [[CSToastStyle alloc] initWithDefaultStyle];
    tyle.backgroundColor = TLRGBAColor(10, 10, 10, 0.6);
    tyle.messageFont       = FONT_14;
    [TL_Winow makeToast:message duration:2 position:CSToastPositionCenter style:tyle];
}

#pragma mark - PublicMeth



+ (instancetype)makeToastView:(UIView *)view {
    TLToastTool *tool = [[self alloc] init];
    [tool showToastView:view];
    return tool;
}

+ (instancetype)makeToasBottomView:(UIView *)view {
    TLToastTool *tool = [[self alloc] init];
    [tool showBottomToastView:view];
    return tool;
}


- (void)removeTool {
    [self sureClick];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.bGView==nil) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            view.backgroundColor = [UIColor clearColor];
            [TL_Winow addSubview:view];
            self.bGView =view;
        }
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sureClick)];
        [self addGestureRecognizer:tap];
        
        [TL_Winow addSubview:self];
    }
    return self;
}

#pragma mark - PrivateMeth



/**
 弹框视图提醒
 
 @param view 视图提醒
 */
- (void)showToastView:(UIView *)view {
    
    [self addSubview:view];
    
    // 设置圆角
    [view drawCornerViewRadius:5 roundingCorners:UIRectCornerAllCorners];
    
    self.backgroundColor = TLRGBAColor(0, 0, 0, 0.5);
    
    // 添加约束
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(view.frameWidth);
        make.height.mas_equalTo(view.frameHeight);
    }];
}


- (void)showBottomToastView:(UIView *)view {
    [self addSubview:view];
    
    self.backgroundColor = TLRGBAColor(0, 0, 0, 0.5);
    
    // 添加约束
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(view.frameWidth);
        make.height.mas_equalTo(view.frameHeight);
    }];
}




/**
 文字间距
 
 @param content 文字内容
 @param space 间距大小
 */
- (NSMutableAttributedString *)contentLineSpac:(NSString *)content spaceWith:(CGFloat)space font:(CGFloat)font{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, [content length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    return attributedString;
}



#pragma mark - Target
- (void)sureClick {
    // 自动消失
    [self removeFromSuperview];
    [self.bGView removeFromSuperview];
    self.bGView = nil;
}


#pragma mark - LazyLoad
- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font          = FONT_16;
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _messageLabel;
}

- (UIView *)alertView {
    if (_alertView == nil) {
        
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.clipsToBounds   = YES;
        _alertView.layer.cornerRadius = 13;
        
        // 创建分割线
        UIView *seperartView = [[UIView alloc] init];
        seperartView.backgroundColor = ColorLine;
        [_alertView addSubview:seperartView];
        
        [seperartView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(LINE_HEIGHT));
            make.width.mas_equalTo(_alertView);
            make.left.mas_equalTo(_alertView);
            make.bottom.mas_equalTo(_alertView.mas_bottom).offset(-kTLToastToolAlertSureH);
        }];
        
        
    }
    return _alertView;
}

@end

//
//  TLInPutView.m
//  bank94
//
//  Created by 94bank on 2017/6/22.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//

#import "TLInPutView.h"

@interface TLInPutView ()

/** 图片 */
@property (strong, nonatomic) UIImageView * placeHolderImageView;
/** 占位文字 */
@property (strong, nonatomic) UILabel * placeHolderTextLabel;
/** 分割线 */
@property (weak, nonatomic) UIView *seperateView;
@end

@implementation TLInPutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self addTarget:self action:@selector(textStringChange) forControlEvents:UIControlEventEditingChanged];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textStringChange) name:@"ChangeText" object:nil];
        UIImageView *placeHolderImageView = [[UIImageView alloc] init];
        placeHolderImageView.contentMode  = UIViewContentModeLeft;
        self.leftViewMode                 = UITextFieldViewModeAlways;
        self.leftView                     = placeHolderImageView;
        self.placeHolderImageView         = placeHolderImageView;
        
        // 替换清除按钮
        UIImageView *clearImageVIew = [[UIImageView alloc] init];
        clearImageVIew.image        = [UIImage imageNamed:@"login_input_close"];
        clearImageVIew.userInteractionEnabled = YES;
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearImageTouch:)];
        [clearImageVIew addGestureRecognizer:pan];
        clearImageVIew.contentMode  = UIViewContentModeRight;
        self.rightView              = clearImageVIew;
        
        // 占位文字
        UILabel *placeHolderTextLabel  = [[UILabel alloc] init];
        placeHolderTextLabel.textColor = TLRainColor(188, 188, 188);
        placeHolderTextLabel.font      = FONT_14;
        [self addSubview:placeHolderTextLabel];
        self.placeHolderTextLabel     = placeHolderTextLabel;
        
        // 分割线
        UIView *seperateView         = [[UIView alloc] init];
        seperateView.backgroundColor = ColorLine;
        [self addSubview:seperateView];
        _seperateView                = seperateView;
        
    }
    return self;
}

+ (instancetype)inputViewWithInputImageName:(NSString *)inputImageName placeHolderText:(NSString *)placeHolder {
    return [TLInPutView inputViewWithInputImageName:inputImageName marginImageToContent:20.0f placeHolderText:placeHolder];
}

+ (instancetype)inputViewWithInputImageName:(NSString *)inputImageName marginImageToContent:(CGFloat)imageToContentMargin placeHolderText:(NSString *)placeHolder {
    TLInPutView *inputView = [[self alloc] init];
    inputView.placeHolderImageView.image = [UIImage imageNamed:inputImageName];
    inputView.placeHolderImageView.frameWidth += inputView.placeHolderImageView.image.size.width + imageToContentMargin;
    inputView.placeHolderTextLabel.text = placeHolder;
    return inputView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placeHolderTextLabel.frame = CGRectMake(self.placeHolderImageView.frameWidth, 0, self.frameWidth-self.placeHolderImageView.frameWidth, self.frameHeight);
    self.rightView.frame = CGRectMake(self.frameWidth - self.frameHeight, 0, self.frameHeight, self.frameHeight);
    self.seperateView.frame = CGRectMake(0, self.frameHeight-LINE_HEIGHT, self.frameWidth, LINE_HEIGHT);
}

#pragma mark - PrivateMeth
- (void)clearImageTouch:(UIGestureRecognizer *)gesture {
    self.text = nil;
    [self textStringChange];
    if (self.inputViewDelegate && [self.inputViewDelegate respondsToSelector:@selector(inputViewDidClieckClearButton:)]) {
        [self.inputViewDelegate inputViewDidClieckClearButton:self];
    }
}

#pragma mark - Target 
- (void)textStringChange {
    if (self.text.length > 0) {
        self.rightViewMode = UITextFieldViewModeAlways;
        self.placeHolderTextLabel.hidden = YES;
    } else {
        self.rightViewMode = UITextFieldViewModeNever;
        self.placeHolderTextLabel.hidden = NO;
    }
}


- (BOOL)resignFirstResponder {
    
    BOOL responer = [super resignFirstResponder];
    if (responer) {
        self.rightViewMode = UITextFieldViewModeNever;

        if (self.text.length > 0) {

            self.placeHolderTextLabel.hidden = YES;
        } else {

            self.placeHolderTextLabel.hidden = NO;
        }
    }
    
    return responer;
}

- (BOOL)becomeFirstResponder {
    [self textStringChange];
    return [super becomeFirstResponder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

//
//  TLTextView.m
//  apartment
//
//  Created by 94bank on 2017/7/27.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "TLTextView.h"

@interface TLTextView ()

@property (nonatomic,weak)UILabel *placeholderLabel;

@end

@implementation TLTextView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        UILabel *placeholderLabel = [[UILabel alloc]init];
        
        placeholderLabel.frameX = 10;
        placeholderLabel.frameY = 10;
        placeholderLabel.textColor = ColorPlaceHolder;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        // 监听输入的通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)textChange{
    
    
    self.placeholderLabel.hidden = self.hasText;
}

-(void)setPlaceholderText:(NSString *)placeholderText{
    
    _placeholderText = [placeholderText copy];
    
    self.placeholderLabel.text = placeholderText;
    [self.placeholderLabel sizeToFit];
    
    [self setNeedsLayout];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
    [self setNeedsLayout];
}

-(void)setText:(NSString *)text{
    
    
    [super setText:text];
    [self textChange];
    
}
-(void)setTextColor:(UIColor *)textColor{
    
    [super setTextColor:textColor];
}

-(void)setFont:(UIFont *)font{
    
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setPlaceLeftCenter:(BOOL)placeLeftCenter {
    if (placeLeftCenter) {
        self.placeholderLabel.frameY =( self.frameHeight - self.placeholderLabel.frameHeight )/2;
        [self setNeedsLayout];
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.placeholderLabel.frameWidth = self.frameWidth - self.placeholderLabel.frameX * 2;
    
    [self.placeholderLabel sizeToFit];
    
}

@end

//
//  TLDrawViewToast.m
//  apartment
//
//  Created by 94bank on 2017/8/4.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "TLDrawViewToast.h"

@interface TLDrawViewToast ()
/** 背景 */
@property (nonatomic,weak) UIView * bGView;

@end

@implementation TLDrawViewToast

+ (instancetype)showDrawViewToastWithFrame:(CGRect)frame {
    static TLDrawViewToast *toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[TLDrawViewToast alloc] initWithFrame:frame];
    });
    toast.hidden    = NO;
    toast.bGView.hidden = NO;
    return toast;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.bGView == nil) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            view.userInteractionEnabled = NO;
            view.backgroundColor = [UIColor clearColor];
            [TL_Winow addSubview:view];
            self.bGView =view;
            
            self.frame = frame;
            self.backgroundColor        = TLRGBAColor(0, 0, 0, 0.6);
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sureClick)];
            [self addGestureRecognizer:tap];
            
            [TL_Winow addSubview:self];
        }
        
        
    }
    return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitTestView = [super hitTest:point withEvent:event];
    if (hitTestView == self) {
        [self sureClick];
        hitTestView = nil;
    }
    return hitTestView;
}

- (void)removeDrawToast {
    [self sureClick];
}

#pragma mark - Target
- (void)sureClick {
    self.hidden = YES;
    self.bGView.hidden  = YES;
}
@end

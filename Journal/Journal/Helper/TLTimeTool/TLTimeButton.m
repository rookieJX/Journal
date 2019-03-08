//
//  TLTimeButton.m
//  bank94
//
//  Created by 94bank on 2017/6/23.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//

#import "TLTimeButton.h"

@implementation TLTimeButton

/**
 *  初始化方法
 *
 *  @param frame frame
 *
 *  @return 实例化对象
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentHorizontalAlignment       = UIControlContentHorizontalAlignmentRight;
        [self addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchDown];
        
    }
    return self;
}


#pragma mark - Delegate
- (void)btnclick {
    if ([self.delegate respondsToSelector:@selector(timerButtonDidClick:)]) {
        [self.delegate timerButtonDidClick:self];
    }
}

#pragma mark - 开启倒计时效果
// 开启倒计时效果
-(void)openCountdownWithTime:(NSInteger)lastTime
{
    __block NSInteger time = lastTime; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                [self setTitleColor:TLHexColor(0x027dd5) forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                self.selected = NO;
            });
            
        }else{
            
            int seconds = time % 120;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                self.selected = YES;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end

//
//  TLDrawViewToast.h
//  apartment
//
//  Created by 94bank on 2017/8/4.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  当有抽屉效果出现是中间控制器添加蒙版

#import <UIKit/UIKit.h>

@interface TLDrawViewToast : UIView

+ (instancetype)showDrawViewToastWithFrame:(CGRect)frame;


- (void)removeDrawToast;
@end

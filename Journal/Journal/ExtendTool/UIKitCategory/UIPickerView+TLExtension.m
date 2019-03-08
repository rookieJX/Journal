//
//  UIPickerView+TLExtension.m
//  apartment
//
//  Created by 94bank on 2017/8/11.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "UIPickerView+TLExtension.h"

@implementation UIPickerView (TLExtension)
- (void)changeSpearatorLineWithColor:(UIColor *)color
{
    for (UIView *subView1 in self.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView *subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    subView2.backgroundColor = [UIColor redColor];
                }
            }
        }
    }
}


@end

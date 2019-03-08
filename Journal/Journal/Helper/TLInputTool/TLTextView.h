//
//  TLTextView.h
//  apartment
//
//  Created by 94bank on 2017/7/27.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  输入控件

#import <UIKit/UIKit.h>

@interface TLTextView : UITextView

/** 占位文字 */
@property (nonatomic,strong)NSString *placeholderText;

/** 占位文字颜色 */
@property (nonatomic,strong)UIColor *placeholderColor;

/** 是否左居中 */
@property (nonatomic,assign) BOOL placeLeftCenter;

@end

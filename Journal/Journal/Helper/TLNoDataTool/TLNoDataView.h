//
//  TLNoDataView.h
//  apartment
//
//  Created by 94bank on 2017/8/1.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  暂无数据界面

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NoDataType) {
    NoDataTypeNomal = 22,       // 普通一般暂无数据
    NoDataTypeFeedback          // 报修记录暂无数据
};

@interface TLNoDataView : UIView

- (void)setNoDataWithType:(NoDataType)type;
@end

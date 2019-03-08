//
//  UIResponder+TLExtension.h
//  apartment
//
//  Created by 94bank on 2017/9/21.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (TLExtension)


/**
 传递点击事件

 @param action 事件名称
 @param object 参数
 */
- (void)tl_ResponderChainEvent:(NSString *)action withObject:(NSDictionary *)object;
@end

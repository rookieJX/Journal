//
//  UIResponder+TLExtension.m
//  apartment
//
//  Created by 94bank on 2017/9/21.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "UIResponder+TLExtension.h"

@implementation UIResponder (TLExtension)

- (void)tl_ResponderChainEvent:(NSString *)action withObject:(NSDictionary *)object {
    [self.nextResponder tl_ResponderChainEvent:action withObject:object];
}
@end

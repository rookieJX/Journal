//
//  NSObject+ToNSString.m
//  apartment
//
//  Created by 94bank on 2017/7/19.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "NSObject+ToNSString.h"

@implementation NSObject (ToNSString)
- (NSString *)toNSString{
    if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",self];
}
@end

//
//  HomeSaveTool.m
//  Journal
//
//  Created by 王加祥 on 2019/3/6.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "HomeSaveTool.h"

@implementation HomeSaveTool
singleton_implementation(HomeSaveTool)

- (void)setHomeRecrodingModelCache:(NSArray<HomeRecordingModel *> *)array {
    [self remoHomeRecordingModelCache];
    [[NSUserDefaults standardUserDefaults] setObject:[array yy_modelToJSONString] forKey:KEY_RECORDING_LIST];
}

- (NSArray<HomeRecordingModel *> *)getHomeRecordingModelCache {
    NSString * json = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_RECORDING_LIST];
    NSArray *array = [NSArray yy_modelArrayWithClass:[HomeRecordingModel class] json:json];
    return array;
}

- (void)remoHomeRecordingModelCache {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_RECORDING_LIST];
}
@end

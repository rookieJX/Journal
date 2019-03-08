//
//  HomeRecordingModel.h
//  Journal
//
//  Created by 王加祥 on 2019/3/6.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeRecordingModel : NSObject

/** 标题 */
@property (nonatomic,strong) NSString * title;
/** 时间 */
@property (nonatomic,assign) NSTimeInterval time;
/** 内存地址 */
@property (nonatomic,strong) NSString * filePath;

@end


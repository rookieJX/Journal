//
//  HomePlayViewController.h
//  Journal
//
//  Created by 王加祥 on 2019/3/7.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeRecordingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePlayViewController : UIViewController
/** 当前播放模型 */
@property (nonatomic,strong) HomeRecordingModel * recordingModel;
@end

NS_ASSUME_NONNULL_END

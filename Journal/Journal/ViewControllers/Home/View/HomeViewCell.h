//
//  HomeViewCell.h
//  Journal
//
//  Created by 王加祥 on 2019/1/10.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeRecordingModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewCell : UITableViewCell

/** 模型 */
@property (nonatomic,strong) HomeRecordingModel * recordingModel;

@end

NS_ASSUME_NONNULL_END

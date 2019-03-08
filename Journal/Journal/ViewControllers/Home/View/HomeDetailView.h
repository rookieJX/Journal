//
//  HomeDetailView.h
//  Journal
//
//  Created by 王加祥 on 2019/1/18.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HomeDetailView;

@protocol HomeDetailViewDelegate <NSObject>

@optional
- (void)actionForHomeDetailViewSave:(HomeDetailView *)detailView;

@end

@interface HomeDetailView : UIView

/** 保存代理 */
@property (nonatomic,weak) id<HomeDetailViewDelegate> delegate;

/**
 开始录音
 */
- (void)actionForHomeDetailViewStartRecording;

/**
 暂停录音
 */
- (void)actionForHomeDetailViewPauseRecording;

@end

NS_ASSUME_NONNULL_END

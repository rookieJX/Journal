//
//  TLAppInfoManager.h
//  bank94
//
//  Created by liujie on 17/6/27.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability.h>
#import "TLSingleton.h"
@interface TLAppInfoManager : NSObject
singleton_h(TLAppInfoManager)
@property(nonatomic,strong)Reachability * netReachablity;
@end

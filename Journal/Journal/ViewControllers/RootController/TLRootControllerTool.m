//
//  TLRootControllerTool.m
//  apartment
//
//  Created by 94bank on 2017/7/18.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "TLRootControllerTool.h"
#import "JXNavigationController.h"
#import "HomeViewController.h"

@implementation TLRootControllerTool

+ (void)chooseRootController {
    if ([MyDeviceSettingManger getIsShowWelcomeScrollerview]) { // 新特性界面

    } else {

    }
    HomeViewController *homeController  = [[HomeViewController alloc] init];
    JXNavigationController *navgationController = [[JXNavigationController alloc] initWithRootViewController:homeController];
    TL_Winow.rootViewController = navgationController;
    
}

@end

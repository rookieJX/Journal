//
//  TLDrawViewControllerTool.m
//  apartment
//
//  Created by 94bank on 2017/7/21.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "TLDrawViewControllerTool.h"

@interface TLDrawViewControllerTool ()

@end

@implementation TLDrawViewControllerTool

+ (instancetype)createDrawControllerWithLeftController:(UIViewController *)leftController
                                      centerController:(UIViewController *)centerController {

    TLDrawViewControllerTool *drawController  = [[TLDrawViewControllerTool alloc] initWithCenterViewController:centerController
                                                                                      leftDrawerViewController:leftController
                                                                                     rightDrawerViewController:nil];
    
    [drawController setShowsShadow:NO];
    //重用 标识
//    [drawController setRestorationIdentifier:@"MMDrawer"];
    //左边控制器 宽度
    [drawController setMaximumLeftDrawerWidth:SCREEN_DRAW_MARGIN];
    //手势开关:  打开 左右两侧 控制器
    [drawController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    //手势开关:  关闭 左右两侧 控制器
    [drawController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    return drawController;
    
}

@end

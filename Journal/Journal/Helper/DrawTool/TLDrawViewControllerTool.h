//
//  TLDrawViewControllerTool.h
//  apartment
//
//  Created by 94bank on 2017/7/21.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  抽屉效果工具类

#import "MMDrawerController.h"

@interface TLDrawViewControllerTool : MMDrawerController


/**
 创建一个抽屉效果工具类

 @param leftController 抽屉左边控制器
 @param centerController 抽屉中间控制器
 @return 返回抽屉控制器
 */
+ (instancetype)createDrawControllerWithLeftController:(UIViewController *)leftController centerController:(UIViewController *)centerController;

@end

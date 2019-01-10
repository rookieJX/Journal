//
//  JXNavigationController.m
//  JXWeiBo
//
//  Created by 王加祥 on 16/6/16.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "JXNavigationController.h"

@interface JXNavigationController ()

@end

@implementation JXNavigationController

/**
 *  当导航控制器创建之后会创建四次，因为有四个控制器
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏代理,主要功能是当我们滑动的时候可以回到上层,但是当我们自定义
    // 导航栏,这个代理就会有值,有值就会失效
    self.interactivePopGestureRecognizer.delegate = nil;
}

/**
 *  当第一次调用这个类的时候调用1次
 */
+ (void)initialize {

    // 设置UIBarButtonItem的主题
    [self setupBarButtonItem];
    
    // 设置导航
    [self setupnavigationBarTheme];
    
    
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItem {
    // 通过appearance对象能修改项目总所有的UIBarButotnItem的样式
    UIBarButtonItem * appearance = [UIBarButtonItem appearance];
    
    // 设置普通文本的属性样式
    NSMutableDictionary * nomalTextAttrs = [NSMutableDictionary dictionary];
    nomalTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    nomalTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [appearance setTitleTextAttributes:nomalTextAttrs forState:UIControlStateNormal];
    
    // 设置高亮文本的样式属性
    NSMutableDictionary * highTextAttrs = [NSMutableDictionary dictionary];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    highTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置禁用状态的文字属性
    NSMutableDictionary * enableTextAttrs = [NSMutableDictionary dictionary];
    enableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    enableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [appearance setTitleTextAttributes:enableTextAttrs forState:UIControlStateDisabled];
}

/**
 *  设置导航栏的主题
 */
+ (void)setupnavigationBarTheme {
    UINavigationBar * appearance = [UINavigationBar appearance];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航栏文字
    NSMutableDictionary *attributts = [NSMutableDictionary dictionary];
    attributts[NSFontAttributeName] = [UIFont boldSystemFontOfSize:22.0f];
    attributts[NSForegroundColorAttributeName] = [UIColor blackColor];
    [appearance setTitleTextAttributes:attributts];
}

/**
 *  拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) { // 当传进来的不是第一个控制器的时候隐藏,如果现在的push的不是栈底控制器
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置push到的控制器的默认的导航按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back"
                                                                               highImageName:@"navigationbar_back_highlighted"
                                                                                      target:self
                                                                                      action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more"
                                                                                highImageName:@"navigationbar_more_highlighted"
                                                                                       target:self
                                                                                       action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
}
@end

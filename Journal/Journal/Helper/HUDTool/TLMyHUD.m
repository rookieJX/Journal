//
//  TLMyHUD.m
//  bank94
//
//  Created by Liu Hui on 2017/6/27.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//

#import "TLMyHUD.h"
#import <MBProgressHUD.h>

static TLMyHUD *myHUD;
@implementation TLMyHUD
+(TLMyHUD *)shareMyHUDManger{
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        myHUD = [[self alloc]init];
    });
    return myHUD;
}

-(void)showLoadingViewTo:(UIView *)view{
    if (!view) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.font = [UIFont systemFontOfSize:15.0f];
    hud.label.text = @"加载中...";
}

-(void)hidLoadingViewTo:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
@end

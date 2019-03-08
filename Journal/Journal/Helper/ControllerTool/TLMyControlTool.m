//
//  TLMyControlTool.m
//  apartment
//
//  Created by 94bank on 2017/7/20.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "TLMyControlTool.h"


static TLMyControlTool *myController    = nil;

@implementation TLMyControlTool

+ (instancetype)defaultController {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myController    = [[TLMyControlTool alloc] init];
    });
    return myController;
}



+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+(void)callToPhoneNumber:(NSString *)phoneNumber{
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",phoneNumber]; 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}
@end

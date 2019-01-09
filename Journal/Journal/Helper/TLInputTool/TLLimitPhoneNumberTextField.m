//
//  TLLimitPhoneNumberTextField.m
//  apartment
//
//  Created by Liu Hui on 2017/8/21.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//

#import "TLLimitPhoneNumberTextField.h"

@implementation TLLimitPhoneNumberTextField

-(void)awakeFromNib{
    [super awakeFromNib];
     [self makeLimitePhoneNumber];
}
-(void)makeLimitePhoneNumber{
    self.keyboardType = UIKeyboardTypeNumberPad;
    [self addTarget:self action:@selector(actionForPhoneTextfiledChanged:) forControlEvents:UIControlEventEditingChanged];
}
-(IBAction)actionForPhoneTextfiledChanged:(UITextField *)sender{
    if (sender.text.length > 11) {
        sender.text = [sender.text substringToIndex:11];
    }
}
@end

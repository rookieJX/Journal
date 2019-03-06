//
//  HomeViewCell.m
//  Journal
//
//  Created by 王加祥 on 2019/1/10.
//  Copyright © 2019 JX.Wang. All rights reserved.
//

#import "HomeViewCell.h"

@interface HomeViewCell ()

@end

@implementation HomeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor    = [UIColor redColor];
    }
    
    return self;
}

- (void)config_view {
    
}
@end

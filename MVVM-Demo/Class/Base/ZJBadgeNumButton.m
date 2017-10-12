//
//  ZJBadgeNumButton.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/23.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJBadgeNumButton.h"

@implementation ZJBadgeNumButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.hidden = NO;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.backgroundColor = [UIColor purpleColor];
    }
    
    return self;
}

#pragma mark ---重写数字的set方法---
- (void)setBadgeNum:(NSString *)badgeNum{
    _badgeNum = badgeNum;
    
    if (badgeNum) {
        
        [self setTitle:badgeNum forState:UIControlStateNormal];
        
    }
    
}
@end

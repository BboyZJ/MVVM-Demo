//
//  ZJRootViewController.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/23.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJRootViewController.h"

//screen尺寸
#define kScreenSize             [UIScreen mainScreen].bounds.size
#define kScreenWidth            kScreenSize.width
#define kScreenHeight           kScreenSize.height

@interface ZJRootViewController ()

@end

@implementation ZJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //关闭自动调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加自定义navBar
    if (!_navBarView) {
        
        _navBarView = [[ZJNavBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        [self.view addSubview:_navBarView];
    }
    
}

#pragma mark ---移除系统的tabBar---
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    for (UIView * view in self.tabBarController.tabBar.subviews) {
        
        if ([view isKindOfClass:[UIControl class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    [self.view bringSubviewToFront:_navBarView];
}

@end

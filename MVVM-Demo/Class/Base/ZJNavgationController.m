//
//  ZJNavgationController.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/20.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJNavgationController.h"

@interface ZJNavgationController ()<UINavigationControllerDelegate>

//定义一个属性保存interactivePopGestureRecognizer的delegate属性
@property (nonatomic,weak)id popDlegate;

@end

@implementation ZJNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解决返回手势失效的问题
    self.popDlegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
    //将系统的navbar隐藏
    self.navigationBarHidden = YES;
    
}

#pragma mark ---解决返回手势失效的问题---
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popDlegate;
    }else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark ---解决push时隐藏tabbar---
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ZJTabBarController.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/20.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJTabBarController.h"
#import "ZJNavgationController.h"
#import "ZJTabBarView.h"
#import "ZJOneViewController.h"
#import "ZJTwoViewController.h"
#import "ZJThreeViewController.h"
#import "ZJFourViewController.h"

@interface ZJTabBarController ()<ZJTabBarButtonDelegate>

@property (nonatomic,strong)ZJTabBarView * customTabBar;

@end

@implementation ZJTabBarController

//视图将要出现的时候
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //删除系统自动生成的UITabBarButton
    for (UIView * child in self.tabBar.subviews) {
        
        if ([child isKindOfClass:[UIControl class]]) {
            
            [child removeFromSuperview];
        }
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //添加tabBarView
    [self addTabBarView];
    //添加所有的子视图控制器
    [self addAllChildsControllers];
}

#pragma mark ---添加tabBarView---
- (void)addTabBarView{
    
    ZJTabBarView * customTabBar = [ZJTabBarView new];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    _customTabBar = customTabBar;
    //添加自定义addTabBarView
    [self.tabBar addSubview:customTabBar];
}
//点击tabBar
- (void)tabBarClick:(ZJTabBarView *)tabBar FromBtn:(NSInteger)from toBtn:(NSInteger)to{
    
     NSLog(@"from:%ld to:%ld",from,to);
    //切换界面
    self.selectedIndex = to;
    
}
//点击中间按钮的事件
- (void)tabBarClickCenterBtn:(ZJTabBarView *)tabBar{
    
    NSLog(@"点击了中间按钮");
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, window.frame.size.height, window.frame.size.width, window.frame.size.height);
    view.backgroundColor = [UIColor blackColor];
    view.alpha = .5;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)]];
    [window addSubview:view];
    
    [UIView animateWithDuration:.5 animations:^{
        
        view.frame = CGRectMake(0, 0, window.frame.size.width,  window.frame.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}
- (void)viewTap:(UITapGestureRecognizer *)tap{
    
    UIView * view = tap.view;
    [view removeFromSuperview];
}
#pragma mark ---添加所有的子视图控制器---
- (void)addAllChildsControllers{
    
    //one
    ZJOneViewController * oneVC = [ZJOneViewController new];
    [self setupChildViewController:oneVC Title:@"one" NorImageName:@"tabBar_one_nor" SelectedImageName:@"tabBar_one_select"];
    
    //two
    ZJTwoViewController * twoVC = [ZJTwoViewController new];
    [self setupChildViewController:twoVC Title:@"two" NorImageName:@"tabBar_two_nor" SelectedImageName:@"tabBar_two_select"];
    
    //thee
    ZJThreeViewController * threeVC = [ZJThreeViewController new];
    [self setupChildViewController:threeVC Title:@"three" NorImageName:@"tabBar_three_nor" SelectedImageName:@"tabBar_three_select"];
    
    //four
    ZJFourViewController * fourVC = [ZJFourViewController new];
    [self setupChildViewController:fourVC Title:@"four" NorImageName:@"tabBar_four_nor" SelectedImageName:@"tabBar_four_select"];
    
    
}

#pragma mark ---设置tabBarItem信息---
- (void)setupChildViewController:(UIViewController *)controller Title:(NSString *)title NorImageName:(NSString *)norImageName SelectedImageName:(NSString *)selectedName{
    
    //title
    controller.title = title;
    
    //image
    controller.tabBarItem.image = [UIImage imageNamed:norImageName];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //navBar
    ZJNavgationController * navC = [[ZJNavgationController alloc] initWithRootViewController:controller];
    [self addChildViewController:navC];
    
    //badge
    controller.tabBarItem.badgeValue = [NSString stringWithFormat:@"%u",arc4random_uniform(120)];
    
    //customTabBar添加Item
    [_customTabBar addTabBarButtonItem:controller.tabBarItem];
}

@end

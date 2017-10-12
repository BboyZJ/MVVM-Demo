//
//  ZJTabBarView.h
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/20.
//  Copyright © 2017年 张建. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJTabBarView;
@protocol ZJTabBarButtonDelegate <NSObject>

//点击中间按钮的事件
- (void)tabBarClickCenterBtn:(ZJTabBarView *)tabBar;
//点击tabbar下标
- (void)tabBarClick:(ZJTabBarView *)tabBar FromBtn:(NSInteger)from toBtn:(NSInteger)to;

@end

@interface ZJTabBarView : UIView

//代理
@property (nonatomic,weak)id<ZJTabBarButtonDelegate>delegate;

- (void)addTabBarButtonItem:(UITabBarItem *)item;

@end

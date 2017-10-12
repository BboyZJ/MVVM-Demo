//
//  ZJTabBarView.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/20.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJTabBarView.h"
#import "ZJTabBarButton.h"

@interface ZJTabBarView ()

@property (nonatomic,strong)NSMutableArray * tabBarBtnArr;//tabBarArr
@property (nonatomic,strong)UIButton * tabBarCenterBtn;//中间按钮
@property (nonatomic,strong)ZJTabBarButton * selectedBtn;//选中按钮

@end
@implementation ZJTabBarView

#pragma mark ---初始化---
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];

    }
    return self;
}
#pragma mark ---懒加载---
- (NSMutableArray *)tabBarBtnArr{
    
    if (!_tabBarBtnArr) {
        
        _tabBarBtnArr = [NSMutableArray array];
    }
    return _tabBarBtnArr;
}

#pragma mark ---添加item---
- (void)addTabBarButtonItem:(UITabBarItem *)item{
    
    //按钮存数组
    ZJTabBarButton * btn = [ZJTabBarButton new];
    [self addSubview:btn];
    [self.tabBarBtnArr addObject:btn];
    
    //item
    btn.item = item;
    //点击按钮的事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置初始点击按钮
    if (self.tabBarBtnArr.count == 1) {
        
        [self btnClick:btn];
    }
    
}

#pragma mark ---切换item的状态----
- (void)btnClick:(ZJTabBarButton *)button{
    
    //点击tabbar
    if (_delegate && [_delegate respondsToSelector:@selector(tabBarClick:FromBtn:toBtn:)]) {
        
        [_delegate tabBarClick:self FromBtn:self.selectedBtn.tag toBtn:button.tag];
    }
    
    self.selectedBtn.selected = NO;//取消之前选中
    button.selected = YES;//设置当前选中
    self.selectedBtn = button;//当前选中记录
}

#pragma mark ---刷新界面---
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat H = self.frame.size.height;
    CGFloat W = self.frame.size.width;
    
    // 添加中间的按钮
    CGFloat centerH = 55;
    CGFloat centerW = 55;
    _tabBarCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _tabBarCenterBtn.frame = CGRectMake((W - centerW) / 2.0, H - centerH, centerW, centerH);
    [_tabBarCenterBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_center_select"] forState:UIControlStateNormal];
    [_tabBarCenterBtn addTarget:self action:@selector(centerButton:) forControlEvents:UIControlEventTouchUpInside];
    _tabBarCenterBtn.layer.cornerRadius = centerH / 2.0f;
    _tabBarCenterBtn.layer.masksToBounds = YES;
    _tabBarCenterBtn.backgroundColor = [UIColor cyanColor];
    [self addSubview:_tabBarCenterBtn];

    //添加其它按钮
    CGFloat btnH = H;
    CGFloat btnW = (W - centerW) / self.tabBarBtnArr.count;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < self.tabBarBtnArr.count; i ++) {
        
        ZJTabBarButton * btn = self.tabBarBtnArr[i];
        btn.tag = i;
        CGFloat btnX;
        if ((i + 1) <= (self.tabBarBtnArr.count / 2.0)) {
            btnX = i * btnW;
        }else {
            btnX = i * btnW + centerW;
        }
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}
#pragma mark ---点击中间按钮的事件---
- (void)centerButton:(UIButton *)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(tabBarClickCenterBtn:)]) {
        
        [_delegate tabBarClickCenterBtn:self];
    }
    
}
@end

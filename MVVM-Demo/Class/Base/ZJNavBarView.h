//
//  ZJNavBarView.h
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/23.
//  Copyright © 2017年 张建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNavBarView : UIView

//button
@property (nonatomic,strong)UIButton * leftItemBtn;
@property (nonatomic,strong)UIButton * rightItemBtn;
@property (nonatomic,strong)UIButton * titleItemBtn;

//bg
@property (nonatomic,strong) UIColor  * backGroudColor;//背景颜色
@property (nonatomic,copy) NSString * backGroudImage;//背景图片

//title
@property (nonatomic,copy) NSString   * labelTitle; //标题文字
@property (nonatomic,copy) NSString   * buttonTitle;
@property (nonatomic,strong) UIImage  * titleImage;//标题图片
@property (nonatomic,strong) UIColor  * titleColor;//标题颜色
@property (nonatomic,strong) UIFont   * titleFont;//标题文字大小
@property (nonatomic,strong) UIView   * titleView;//标题视图

//left
@property (nonatomic,copy) NSString * leftTitle;
@property (nonatomic,strong) UIColor * leftColor;
@property (nonatomic,strong) UIColor * leftHighlightedColor;
@property (nonatomic,copy) NSString * leftImageStr;
@property (nonatomic,strong) UIFont * leftFont;

//right
@property (nonatomic,copy) NSString * rightTitle;
@property (nonatomic,strong) UIColor * rightColor;
@property (nonatomic,strong) UIColor * rightHighlightedColor;
@property (nonatomic,copy) NSString * rightImageStr;
@property (nonatomic,strong) UIFont * rightFont;


//左侧按钮的点击事件
- (void)leftBarBtnAddTarget:(id)target Action:(SEL)action;

//右侧按钮的点击事件
- (void)rightBarBtnAddTarget:(id)target Action:(SEL)action;

@end

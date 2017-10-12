//
//  ZJNavBarView.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/23.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJNavBarView.h"

@interface ZJNavBarView ()

//imageView
@property (nonatomic,strong)UIImageView * backImageView;//背景图片

//label
@property (nonatomic,strong)UILabel * titleItemLabel;//title

//view
@property (nonatomic,strong)UIView * bottomLineView;

@end
@implementation ZJNavBarView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //默认背景颜色
        self.backgroundColor = [UIColor whiteColor];
        
        //添加barItem
        [self addNavBarItem];
    }
    return self;
}

#pragma mark ---添加barItem---
- (void)addNavBarItem{
    
    //backImage
    _backImageView = [[UIImageView alloc] init];
    _backImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_backImageView];
    
    //titleLabel
    _titleItemLabel = [[UILabel alloc] init];
    _titleItemLabel.textAlignment = NSTextAlignmentCenter;
    _titleItemLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:_titleItemLabel];
    
    //leftBtn
    _leftItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftItemBtn.backgroundColor = [UIColor clearColor];
    [_leftItemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftItemBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self addSubview:_leftItemBtn];
    
    //rightBtn
    _rightItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightItemBtn.backgroundColor = [UIColor clearColor];
    [_rightItemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightItemBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self addSubview:_rightItemBtn];

    //titleBtn
    _titleItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleItemBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleItemBtn];
    
    //titleView
    _titleView = [[UIView alloc] init];
    _titleView.backgroundColor = [UIColor magentaColor];
    [self addSubview:_titleView];
    
    //bottomLineView
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = [UIColor blackColor];
    [self addSubview:_bottomLineView];
    
}

#pragma mark ---back---
//背景颜色
- (void)setBackGroudColor:(UIColor *)backGroudColor{
    _backGroudColor = backGroudColor;
    
    self.backGroudColor = backGroudColor;
}
//背景图片
- (void)setBackGroudImage:(NSString *)backGroudImage{
    _backGroudImage = backGroudImage;
    
    _backImageView.frame = self.bounds;
    
    _backImageView.image = [UIImage imageNamed:backGroudImage];
}

#pragma mark ---title---
//---title---
- (void)setLabelTitle:(NSString *)labelTitle{
    _labelTitle = labelTitle;
    
    ZJWeakSelf(weakSelf);
    
    [_titleItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.mas_left).offset(100);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-100);
        make.top.mas_equalTo(weakSelf.mas_top).offset(20);
        make.height.mas_equalTo(44);
    }];
    
    _titleItemLabel.text = labelTitle;
}

//---title---
- (void)setButtonTitle:(NSString *)buttonTitle{
    _buttonTitle = buttonTitle;
    
    ZJWeakSelf(weakSelf);
    
    [_titleItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.mas_left).offset(100);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-100);
        make.top.mas_equalTo(weakSelf.mas_top).offset(20);
        make.height.mas_equalTo(44);
        
    }];
    
}
//---image---
- (void)setTitleImage:(UIImage *)titleImage{
    _titleImage = titleImage;
    
    [_titleItemBtn setImage:titleImage forState:UIControlStateNormal];
    
    ZJWeakSelf(weakSelf);
    
    [_titleItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.mas_left).offset(100);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-100);
        make.top.mas_equalTo(weakSelf.mas_top).offset(20);
        make.height.mas_equalTo(44);
        
    }];
}
//---font---
- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    
    _titleItemLabel.font = titleFont;
    
    _titleItemBtn.titleLabel.font = titleFont;
}
//---color---
- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    
    _titleItemLabel.textColor = titleColor;
    
    [_titleItemBtn setTitleColor:titleColor forState:UIControlStateNormal];
}

#pragma mark ---left---
//lefttitle
- (void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    
    [_leftItemBtn setTitle:leftTitle forState:UIControlStateNormal];
    
    _leftItemBtn.frame = CGRectMake(0, 20, 44, 44);
    
}
- (void)setLeftColor:(UIColor *)leftColor{
    _leftColor = leftColor;
    
    [_leftItemBtn setTitleColor:leftColor forState:UIControlStateNormal];
}
- (void)setLeftHighlightedColor:(UIColor *)leftHighlightedColor{
    _leftHighlightedColor = leftHighlightedColor;
    
    [_leftItemBtn setTitleColor:_leftHighlightedColor forState:UIControlStateHighlighted];
}
- (void)setLeftFont:(UIFont *)leftFont{
    _leftFont = leftFont;
    
    _leftItemBtn.titleLabel.font = leftFont;
}

//leftImage
- (void)setLeftImageStr:(NSString *)leftImageStr{
    _leftImageStr = leftImageStr;
    
    [_leftItemBtn setImage:[UIImage imageNamed:leftImageStr] forState:UIControlStateNormal];
   
    _leftItemBtn.frame = CGRectMake(0, 20, 44, 44);
   
}


#pragma mark ---right---
//rightTitle
- (void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    
    [_rightItemBtn setTitle:rightTitle forState:UIControlStateNormal];
    
    _rightItemBtn.frame = CGRectMake(kScreenWidth - 44, 20, 44, 44);
    
}
- (void)setRightColor:(UIColor *)rightColor{
    _rightColor = rightColor;
    
    [_rightItemBtn setTitleColor:rightColor forState:UIControlStateNormal];
}
- (void)setRightHighlightedColor:(UIColor *)rightHighlightedColor{
    _rightHighlightedColor = rightHighlightedColor;
    
    [_rightItemBtn setTitleColor:rightHighlightedColor forState:UIControlStateHighlighted];
}
- (void)setRightFont:(UIFont *)rightFont{
    _rightFont = rightFont;
    
    _rightItemBtn.titleLabel.font = rightFont;
}
- (void)setRightImageStr:(NSString *)rightImageStr{
    _rightImageStr = rightImageStr;
    
    [_rightItemBtn setImage:[UIImage imageNamed:rightImageStr] forState:UIControlStateNormal];
    
    _rightItemBtn.frame = CGRectMake(kScreenWidth - 44, 20, 44, 44);
}



#pragma mark ---left的点击事件---
- (void)leftBarBtnAddTarget:(id)target Action:(SEL)action{
    
    [_leftItemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark ---right的点击事件---
- (void)rightBarBtnAddTarget:(id)target Action:(SEL)action{
    
    [_rightItemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}


@end

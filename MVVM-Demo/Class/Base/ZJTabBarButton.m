//
//  ZJTabBarButton.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/23.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJTabBarButton.h"
#import "ZJBadgeNumButton.h"

// 图标的比例
#define TabBarButtonImageRatio 0.5


@interface ZJTabBarButton ()

@property (nonatomic,strong)ZJBadgeNumButton * badgeBtn;//提醒数字

@end
@implementation ZJTabBarButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView.contentMode = UIViewContentModeCenter;//图片居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;//文字居中
        self.titleLabel.font = [UIFont systemFontOfSize:11];//文字大小
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];//正常文字颜色
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];//选中文字颜色
        
        //添加badge
        [self addBadgeButton];
    }
    return self;
}
#pragma mark ---添加badge---
- (void)addBadgeButton{
    
    _badgeBtn = [ZJBadgeNumButton new];
    _badgeBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_badgeBtn];
    
}

#pragma mark ---监听item----
- (void)setItem:(UITabBarItem *)item{
    _item = item;
    
    //监听属性的改变KVO
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
 
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];

}

#pragma mark ---监听到某个对象的属性改变了，就会调用---
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    //文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];

    //图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];

    
    //badge
    [self setupBadgeFrame];
   
}
#pragma mark ---设置数字提示的frame---
- (void)setupBadgeFrame{

   
    CGFloat badgeY = 5;
    CGFloat badgeH = 15;
    CGFloat badgeW;
    
    if ([self.item.badgeValue integerValue] > 99) {
        
        _badgeBtn.badgeNum = @"99+";
        badgeW = [_badgeBtn.badgeNum boundingRectWithSize:CGSizeMake(100, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size.width + 5;

    }else {
        
        _badgeBtn.badgeNum = self.item.badgeValue;
        if ([self.item.badgeValue integerValue] < 10) {
            
            badgeW = 15;
            
        }else if ([self.item.badgeValue integerValue] == 0) {
            
            badgeW = 0;
        }else {
            
            badgeW = [_badgeBtn.badgeNum boundingRectWithSize:CGSizeMake(100, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size.width + 5;
        }
        
    }
    CGFloat badgeX = (self.frame.size.width / 2.0 - badgeW - 10);
    _badgeBtn.frame = CGRectMake(badgeX, badgeY, badgeW, 15);
    
    //切圆角
    _badgeBtn.layer.cornerRadius = badgeH / 2.0;
    _badgeBtn.layer.masksToBounds = YES;

}
#pragma mark ---文字的frame---
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleY = contentRect.size.height * TabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);

    
}
#pragma mark ---内部图片的frame---
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 1.0;
    return CGRectMake(0, 0, imageW, imageH);
    
}

#pragma mark ---释放监听---
- (void)dealloc{
    
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];

}

@end

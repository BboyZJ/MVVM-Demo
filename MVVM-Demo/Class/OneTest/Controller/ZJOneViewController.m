//
//  ZJOneViewController.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/20.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJOneViewController.h"
#import "ZJOneDetailViewController.h"

@interface ZJOneViewController ()

//用来标识时间变量
@property (nonatomic,strong)NSDate * time;
//用来标识文字显示区域
@property (nonatomic,strong)UILabel * label;

@end

@implementation ZJOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    /*
     RAC:响应式编程，我们所熟知的iOS 开发中的事件包括：
     
     Target
     Delegate
     KVO
     通知
     时钟
     网络异步回调
     而 ReactiveCocoa ，就是用 信号 接管了 iOS 中的所有事件；也就意味着，用一种统一的方式来处理iOS中的所有事件，解决了各种分散的事件处理方式，显然这么一个庞大的框架学习起来也会比较难！而且如果习惯了iOS原生的编程，可能会觉得不习惯！
     
     */
    [self addTimeBilingStr];
    
}
#pragma mark ---初始化UI---
- (void)initUI{
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.navBarView.labelTitle = @"one";
    
    //next
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((self.view.frame.size.width - 200)/2.0, 100, 200, 50);
    [btn setTitle:@"next" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    
    //label
    _label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2.0, 200, 200, 50)];
    _label.backgroundColor = [UIColor yellowColor];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textColor = [UIColor greenColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];

}
//下一页的点击事件
- (void)next:(UIButton *)sender{
    
    ZJOneDetailViewController * detailVC = [[ZJOneDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark ---addTimeBilingStr---
- (void)addTimeBilingStr{
    
    //申请注册一个每1秒将会在主线程执行一次的信号量
    RACSignal *  repeatSignal = [RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] ;
    //为信号量添加执行代码端
    [repeatSignal subscribeNext:^(NSDate * time) {
        
        self.time = time;
    }];
    
    //申请一个事件属性的信号量KVO
    RACSignal * timeSignal = [self rac_valuesForKeyPath:@"time" observer:self];
    //为信号量添加执行代码端
    [timeSignal subscribeNext:^(NSDate * time) {
        
        NSDateFormatter * fm = [[NSDateFormatter alloc] init];
        [fm setDateFormat:@"HH:mm:ss"];
        
        self.label.text = [fm stringFromDate:time];
        
    }];
 
    //过滤设置
//    [self secondTime];
}
- (void)secondTime{
    
    //申请注册一个时间属性的信号量
    RACSignal *timeSignal = [self rac_valuesForKeyPath:@"time" observer:self];
    //为信号量添加过滤block
    [[timeSignal filter:^BOOL(NSDate * time) {
        
        //获取描述的时间
        NSDateComponents *com = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:time];
        
        return com.second % 2 == 0;
    }] subscribeNext:^(NSDate * time) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        
        self.label.text = [formatter stringFromDate:time];
        
    }];

}
@end

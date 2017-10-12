//
//  ZJTwoDetailController.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/2/6.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJTwoDetailController.h"

@interface ZJTwoDetailController ()
{
    BOOL rightBarSelected;
    
}

@property (nonatomic,strong) UIImageView * imgView;


@end

@implementation ZJTwoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor cyanColor];
    
    self.navBarView.labelTitle = @"twoDetail";
    
    self.navBarView.leftImageStr = @"nav_two_left_nor";
    [self.navBarView leftBarBtnAddTarget:self Action:@selector(leftBarBtnClick)];
    
    self.navBarView.rightImageStr = @"nav_two_right_nor";
    [self.navBarView rightBarBtnAddTarget:self Action:@selector(rightBarBtnClick)];
    
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"postData" object:nil] subscribeNext:^(NSNotification *notification) {
        NSLog(@"%@", notification.name);
        NSLog(@"%@", notification.object);
    }];

    
    //RAC的NSData
    [self NSData];
    
    
    //RAC的map
    /*
         flattenMap:方法通过调用block（value）来创建一个新的方法，它可以灵活的定义新创建的信号
         map:方法，将会创建一个和原来一摸一样的信号，只不过新的信号传递的值变为了block（value）
         我们有时需要对信号block返回来的数据进行处理,或者是转换格式,或者是拼接字符串,这个时候就要用到map和flattenMap了,二者的区别主要在于:FlatternMap返回的是一个信号,而map返回的是对象,一般情况下我们使用的是map
     */
    [self map];
    [self fltternMap];
    
    //filter函数筛选
    [self filter];
}

#pragma mark ---点击左侧按钮的事件---
- (void)leftBarBtnClick{
    
    if (rightBarSelected) {
        
        NSLog(@"点击了全选");
        
        
    }else {
        
        NSLog(@"点击了返回按钮");
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
   
}

#pragma mrk ---点击右侧按钮的点击事件---
- (void)rightBarBtnClick{
    
    if (rightBarSelected) {
        
        NSLog(@"选中了");
        //leftBar
        self.navBarView.leftTitle = @"";
        self.navBarView.leftImageStr = @"nav_two_left_nor";
        
        //rightBar
        self.navBarView.rightTitle = @"";
        self.navBarView.rightImageStr = @"nav_two_right_nor";
        
        
        //转换为未选中
        rightBarSelected = NO;
        
    }else {
        
        NSLog(@"未选中");
        //leftBar
        self.navBarView.leftImageStr = @"";
        self.navBarView.leftTitle = @"全选";
        self.navBarView.leftColor = [UIColor magentaColor];
        self.navBarView.leftHighlightedColor = [UIColor lightGrayColor];
        
        //rightBar
        self.navBarView.rightImageStr = @"";
        self.navBarView.rightTitle = @"取消";
        self.navBarView.rightColor = [UIColor magentaColor];
        self.navBarView.rightHighlightedColor = [UIColor lightGrayColor];
        
        //转为选中了
        rightBarSelected = YES;
    }
    
}
//RAC的NSData
- (void)NSData{
    
    NSURL* url = [NSURL URLWithString:@"http://www.jianshu.com"];
    RACSignal* getDataSignal = [NSData rac_readContentsOfURL:url options:NSDataReadingUncached
                                                   scheduler:[RACScheduler mainThreadScheduler]];
    [getDataSignal subscribeNext:^(id x) {
       
//        NSLog(@"%@",x);  //这里的x就是NSData数据
        
    }];
    
}
//RAC的map
- (void)map{
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imgView];
    
   //map函数就像signal管道上的中间处理器，从这边走过的signal都会经过一段处理后，变成新的signal继续传输。
    NSURL * url = [NSURL URLWithString:@"http://img1.gtimg.com/gamezone/pics/24159/24159840.jpg"];
    RACSignal * dataSignal = [NSData rac_readContentsOfURL:url options:NSDataReadingUncached scheduler:[RACScheduler mainThreadScheduler]];
    //map函数进行转换
    RACSignal * imgSignal = [dataSignal map:^id(id value) {
        
        if (value) {
            
            return [UIImage imageWithData:value];
        }
        return nil;
    }];
    
    //输出
    [imgSignal subscribeNext:^(UIImage * image) {
        
        _imgView.image = image;
        
    }];
}
//fltternMap
- (void)fltternMap{
    
    @weakify(self);
//    [[[self.a_age rac_textSignal] flattenMap:^RACStream *(id value) {
//        
//        return [RACReturnSignal return:[NSString stringWithFormat:@"年龄是:%@",value]];
//        
//    }] subscribeNext:^(id x) {
//        
//        @strongify(self);
//        self.b_age.text = x;
//        
//    }];
    
}

//filter函数筛选
- (void)filter{
    
    //3个网络图片
    NSURL* url = [NSURL URLWithString:@"http://img1.gtimg.com/gamezone/pics/24159/24159840.jpg"];
    NSURL* url2 = [NSURL URLWithString:@"http://i3.hoopchina.com.cn/blogfile/201306/29/137247593017986.jpg"];
    NSURL* url3 = [NSURL URLWithString:@"http://img.youxile.com/pic/1301/25170237170.jpg"];
    
    //3个信号
    RACSignal * imgSignal = [[NSData rac_readContentsOfURL:url options:NSDataReadingUncached scheduler:[RACScheduler mainThreadScheduler]] map:^id(id value) {
        
        if (value) {
            
            return [UIImage imageWithData:value];
        }
        return nil;
    }];
    
    RACSignal * imgSignal2 = [[NSData rac_readContentsOfURL:url2 options:NSDataReadingUncached scheduler:[RACScheduler mainThreadScheduler]] map:^id(id value) {
        
        if (value) {
            
            return [UIImage imageWithData:value];
        }
        return nil;
    }];
    
    RACSignal * imgSignal3 = [[NSData rac_readContentsOfURL:url3 options:NSDataReadingUncached scheduler:[RACScheduler mainThreadScheduler]] map:^id(id value) {
        
        if (value) {
            
            return [UIImage imageWithData:value];
        }
        return nil;
    }];
    
    //合并操作
    [[[RACSignal merge:@[imgSignal,imgSignal2,imgSignal3]] filter:^BOOL(id value) {
        
        return value;
        
    }] subscribeNext:^(id x) {
        
        NSLog(@"result:%@",x);
    }];
    
}

@end

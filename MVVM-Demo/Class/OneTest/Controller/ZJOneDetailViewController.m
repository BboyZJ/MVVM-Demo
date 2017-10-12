//
//  ZJOneDetailViewController.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/23.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJOneDetailViewController.h"
#import "ZJOneViewModel.h"

@interface ZJOneDetailViewController ()

@property (nonatomic,strong) UITextField *usernameTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) ZJOneViewModel * viewModel;
@property (nonatomic,strong) RACCommand * orderCreatCommand;

@end

@implementation ZJOneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navBarView.labelTitle = @"oneDetail";
    
    self.navBarView.leftTitle = @"返回";
    self.navBarView.rightTitle = @"Right";
    [self.navBarView leftBarBtnAddTarget:self Action:@selector(leftBarBtnClick)];

    
    //RACCommand简单使用
    /**
         RACCommand：用于表示事件在执行，一般是在UI的某些动作来出发这些事件，比如点击按钮；RACCommand的实例能够决定是否可以被执行，这个特性反应在UI上，而且它能确保在其不可用时不会被执行。
     
        1. executionSignals:需要执行的block成功的时候返回的信号，他是在主线程执行的。
        2. executing：判断当前的block是否在执行，执行完之后会返回@(NO).
        3. enabled:当前命令是否enabled，默认是no，他也可以根据enableSignal来设置或者allowsConcurrentExecution设置为NO的时候（command已经开始执行）
        4. errors:执行command的时候获取的error都会通过这个信号发送
        5. allowsConcurrentExecution：是否允许并发执行command，默认是NO。
     */
    //实例1
//    [self RACCommand];
    
    //实例2
    [self RACCommand2];
    
}
#pragma mark ---返回按钮的点击事件---
- (void)leftBarBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//RACCommand简单使用
- (void)RACCommand{
    
   //两种方法创建
    //第一种
    _orderCreatCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            return nil;
        }];
    }];
    
    //第二种
    RACSignal * isEnableSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return nil;
    }];
    _orderCreatCommand = [[RACCommand alloc] initWithEnabled:isEnableSignal signalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            return nil;
        }];
    }];
}

//RACCommand2
- (void)RACCommand2{
    
   //1.配置
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.placeholder = @"输入用户名";
    self.usernameTextField.backgroundColor = [UIColor purpleColor];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"输入密码";
    self.passwordTextField.backgroundColor = [UIColor purpleColor];
    
    UIView *superView = self.view;
    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.passwordTextField];
    
    @weakify(self)
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.centerY.equalTo(@(10));
        make.width.equalTo(@(200));
        make.height.equalTo(@(35));
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(self.usernameTextField.mas_width);
        make.height.mas_equalTo(self.usernameTextField.mas_height);
        make.centerY.mas_equalTo(self.usernameTextField.mas_centerY).offset(45);
        make.centerX.mas_equalTo(self.usernameTextField.mas_centerX);
        
    }];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_bottom).offset(-40);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    [self.button setTitle:@"登陆" forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor redColor];
    
    //2.绑定viewModel
    [self.usernameTextField.rac_textSignal subscribeNext:^(id x) {
        
        @strongify(self);
        self.viewModel.username = x;
        
    }];
    
    [self.passwordTextField.rac_textSignal subscribeNext:^(id x) {
        
        @strongify(self);
        self.viewModel.password = x;
    }];
    
    //绑定
    self.viewModel = [[ZJOneViewModel alloc] init];
    self.button.rac_command = self.viewModel.loginCommand;
    
    //判断是否正在执行
    [self.button.rac_command.executing subscribeNext:^(id x) {
        
        NSLog(@"executing:%@",x);
        if ([x isEqual:@(1)]) {
            
            self.button.enabled = NO;
        }else {
            
            self.button.enabled = YES;
        }
        
    }];
    
    //执行结果
    [self.button.rac_command.executionSignals subscribeNext:^(id x) {
        
        NSLog(@"result:%@",x);
        if ([x isEqual: @(1)]) {
            
            NSLog(@"成功");
        }
        else {
            
            NSLog(@"不成功");
        }
    }];
    
    //错误处理
    [self.button.rac_command.errors subscribeNext:^(id x) {
        
        NSLog(@"error:%@",x);
        
    }];


}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

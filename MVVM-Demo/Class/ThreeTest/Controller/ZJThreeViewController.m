//
//  ZJThreeViewController.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/20.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJThreeViewController.h"

@interface ZJThreeViewController ()

@property (nonatomic,strong)UILabel * userNameLabel;
@property (nonatomic,strong)UITextField * userName;
@property (nonatomic,strong)UILabel * passwordLabel;
@property (nonatomic,strong)UITextField * password;
@property (nonatomic,strong)UIButton * btn;
@property (nonatomic,strong)RACDelegateProxy * proxy;

@end

@implementation ZJThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    
    [self initUI];
}

- (void)initUI{
    
    //alertController
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"显示的标题" message:@"标题的提示信息" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击确认");
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"警告" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击警告");
        
    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        NSLog(@"添加一个textField就会调用 这个block");
        
    }];
    
    //btn
    _btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 200) / 2.0, 100, 200, 50)];
    [_btn setTitle:@"alertController" forState:UIControlStateNormal];
    _btn.backgroundColor = [UIColor redColor];
//    _btn.enabled = NO;
    [self.view addSubview:_btn];
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self presentViewController:alertController animated:YES completion:nil];
    }];

    
    
    //userName
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 100, 50)];
    _userNameLabel.text = @"用户名称:";
    _userNameLabel.textColor = [UIColor blackColor];
    _userNameLabel.textAlignment = NSTextAlignmentLeft;
    _userNameLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_userNameLabel];
    
    _userName = [[UITextField alloc] initWithFrame:CGRectMake(160, 200, 200, 50)];
    _userName.textAlignment = NSTextAlignmentLeft;
    _userName.borderStyle = UITextBorderStyleRoundedRect;
    _userName.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:_userName];
    
    //password
    _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,300, 100, 50)];
    _passwordLabel.text = @"用户密码：";
    _passwordLabel.textColor = [UIColor blackColor];
    _passwordLabel.textAlignment = NSTextAlignmentLeft;
    _passwordLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_passwordLabel];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(160, 300, 200, 50)];
    _password.textAlignment = NSTextAlignmentLeft;
    _password.borderStyle = UITextBorderStyleRoundedRect;
    _password.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_password];
    
    
    //RAC实现判断用户和密码相同
    [self addRAC];
}

#pragma mark ---addRAC---
- (void)addRAC{
    
    //1.username
    [[self.userName rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x) {
        
        NSLog(@"username编辑改变了");
        
    }];
    //2.对于textFild的文字更改监听也有更简单的写法
    [[self.userName rac_textSignal] subscribeNext:^(NSString * username) {
        
        NSLog(@"username:%@",username);
        
    }];
    
    //3.组合信号-限制btn能否被点击
    id signal = @[[self.userName rac_textSignal],[self.password rac_textSignal]];
    @weakify(self);
    [[RACSignal combineLatest:signal] subscribeNext:^(RACTuple * x) {
        
        @strongify(self);
        NSString * name = [x first];
        NSString * password = [x second];
        if (name.length > 0 && password.length > 0) {
            
            self.btn.enabled = YES;
    
        }else {
            
            self.btn.enabled = NO;
        }
        
        
    }];
    
    //4.验证：name的输入字符时，输入回撤或点击键盘的回撤使password变为第一响应器
    //******定义代理
    self.proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITextFieldDelegate)];
    //代理去注册文本框的监听方法
    [[self.proxy rac_signalForSelector:@selector(textFieldShouldReturn:)] subscribeNext:^(id x) {
        
        @strongify(self);
        if (self.userName.hasText && self.userName.text.length >= 6) {
            
            [self.password becomeFirstResponder];
        }else if (!self.userName.hasText) {
            
            NSLog(@"用户名不能为空");
        }else if (self.userName.text.length > 0) {
            
            NSLog(@"用户名不能少于6位");
        }
        
    }];
    self.userName.delegate = (id<UITextFieldDelegate>)self.proxy;
    
    //5.通知
    //验证：点击textfield时，系统键盘会发送通知,打印通知的内容
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(id x) {
        
        NSLog(@"notificationDemo : %@", x);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ZJOneViewModel.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/5/2.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJOneViewModel.h"

@interface ZJOneViewModel ()


@end
@implementation ZJOneViewModel

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self loginCommand];
    }
    return self;
}

//loginCommand
- (RACCommand *)loginCommand{
    
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        
        return [self loginWithUsername:self.username password:self.password];
        
    }];
    
    return _loginCommand;
}


//真正登录的执行代码
- (RACSignal *)loginWithUsername:(NSString *)username password:(NSString *)password {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //发送信号
            if (username.length > 0 && password.length > 0) {
                
                [subscriber sendNext:@(1)];
            }else {
                
                [subscriber sendNext:@(0)];
            }
           
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
}


@end

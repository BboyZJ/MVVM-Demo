//
//  ZJOneViewModel.h
//  MVVM-Demo
//
//  Created by 张建 on 2017/5/2.
//  Copyright © 2017年 张建. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJOneViewModel : NSObject

@property (nonatomic,copy)NSString * username;//用户民
@property (nonatomic,copy)NSString * password;//密码
@property (nonatomic,strong)RACCommand * loginCommand;//loginCommand

@end

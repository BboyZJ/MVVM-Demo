//
//  ZJTwoViewController.m
//  MVVM-Demo
//
//  Created by 张建 on 2017/1/20.
//  Copyright © 2017年 张建. All rights reserved.
//

#import "ZJTwoViewController.h"
#import "ZJTwoDetailController.h"

@interface ZJTwoViewController ()

@property (nonatomic,strong)UIButton * btn;

@end

@implementation ZJTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];;

    [self initUI];
    
}

#pragma mark ---initUI---
- (void)initUI{
    
    
    //RAC-通知
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postData" object:dataArray];
    
    self.navBarView.labelTitle = @"two";
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake((self.view.frame.size.width - 200)/2.0, 100, 200, 50);
    [self.btn setTitle:@"next" forState:UIControlStateNormal];
    self.btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.btn];
    
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"点击了");
        ZJTwoDetailController * detailVC = [[ZJTwoDetailController alloc] init];
        
        [self.navigationController pushViewController:detailVC animated:YES];

    }];

}

@end

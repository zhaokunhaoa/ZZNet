//
//  Test02ViewController.m
//  ZZNet
//
//  Created by Zhao Kun on 2018/4/17.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import "Test02ViewController.h"
#import "ZKTestVC02Request.h"
#import "ZKTestVC03Request.h"

@interface Test02ViewController ()
@property (nonatomic, strong) ZKTestVC02Request *request2;
@property (nonatomic, strong) ZKTestVC03Request *request3;

@end

@implementation Test02ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 100, 100, 40);
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 200, 100, 40);
    [btn2 setTitle:@"btn2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(clickBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}


- (void)clickBtn1 {
    [self.request2 start];
}

- (void)clickBtn2 {
    [self.request3 startAndCompletion:^{
        NSLog(@">>> 集中了 >>>");
    }];
}


- (ZKTestVC02Request *)request2 {
    if (!_request2) {
        _request2 = [ZKTestVC02Request new];
    }
    return _request2;
}

- (ZKTestVC03Request *)request3 {
    if (!_request3) {
        _request3 = [ZKTestVC03Request new];
    }
    return _request3;
}

@end

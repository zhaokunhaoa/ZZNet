//
//  ViewController.m
//  ZZNet
//
//  Created by kobe on 2018/3/8.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import "ViewController.h"
#import "Test02ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"main: %@", [NSThread mainThread]);
//
//    dispatch_queue_t queue = dispatch_queue_create("com.hanamichi", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(queue, ^{
//        for (NSInteger i = 0; i < 10; i++) {
//            NSLog(@"%zd: %@", i, [NSThread currentThread]);
//        }
//    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickSerial:(UIButton *)sender {
    [self.navigationController pushViewController:[Test02ViewController new] animated:true];
}

@end

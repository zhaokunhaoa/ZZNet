//
//  TestViewController.m
//  ZZNet
//
//  Created by kobe on 2018/3/8.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import "TestViewController.h"
#import "ZKBaseRequest.h"

@interface TestViewController ()

@property (nonatomic, strong) ZKBaseRequest *request;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)start:(id)sender {
    [self.request start];
}

- (IBAction)sync:(id)sender {
    [self.request testSync];
}

- (IBAction)group:(id)sender {
    [self.request testSyncAndTotal];
}

- (IBAction)cancel:(id)sender {
    [self.request cancel];
}

#pragma mark - getter
- (ZKBaseRequest *)request {
    if (!_request) {
        _request = [ZKBaseRequest new];
    }
    return _request;
}

@end

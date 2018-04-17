//
//  TestViewController.m
//  ZZNet
//
//  Created by kobe on 2018/3/8.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import "TestViewController.h"
#import "ZKTestVCRequest.h"

NSString * const tarketKey = @"Request City";

@interface TestViewController () <ZKBaseRequestDelegate>

@property (nonatomic, strong) ZKTestVCRequest *request;

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", self.request.targetKey);
}

- (void)requestFinished:(ZKBaseRequest *)request responseObject:(id)responseObject {
    NSLog(@"%@", responseObject);
}

- (void)requestFailed:(ZKBaseRequest *)request error:(NSError *)error {
    NSLog(@"%@", error.debugDescription);
}

#pragma mark - getter
- (ZKTestVCRequest *)request {
    if (!_request) {
        _request = [[ZKTestVCRequest alloc] initWithTargetKey:tarketKey];
        _request.delegate = self;
    }
    return _request;
}

@end

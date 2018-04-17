//
//  ZKTestVC02Request.m
//  ZZNet
//
//  Created by Zhao Kun on 2018/4/17.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import "ZKTestVC02Request.h"
#import "ZKTestVCRequest.h"

@implementation ZKTestVC02Request

- (NSArray<ZKBaseRequest *> *)requests {
    ZKTestVCRequest *request01 = [[ZKTestVCRequest alloc] initWithTargetKey:@"001"];
    ZKTestVCRequest *request02 = [[ZKTestVCRequest alloc] initWithTargetKey:@"002"];
    ZKTestVCRequest *request03 = [[ZKTestVCRequest alloc] initWithTargetKey:@"003"];
    return @[request01,request02,request03];
}

@end

//
//  ZKGroupRequest.m
//  ZZNet
//
//  Created by Zhao Kun on 2018/3/9.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import "ZKGroupRequest.h"

@implementation ZKGroupRequest

- (void)start {
    NSString *key = [NSString stringWithFormat:@"ZZNet.Request.Sync.task.%@",NSStringFromClass([self class])];
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create([key UTF8String], DISPATCH_QUEUE_SERIAL);
    //设置信号总量为1，保证只有一个进程执行
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    for (ZKBaseRequest *request in self.requests) {
        request.requestType = ZKBaseRequestTypeSerial;
        dispatch_async(queue, ^(){
            //等待信号量
            //请求A
            [request startWithSemaphore:semaphore];
        });
    }
}

- (void)startAndCompletion:(void (^)())completion {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (ZKBaseRequest *request in self.requests) {
        request.requestType = ZKBaseRequestTypeGroup;
        dispatch_group_async(group, queue, ^{
            [request startInGroup];
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //刷新界面
        completion();
    });
}

- (void)cancel {
    for (ZKBaseRequest *request in self.requests) {
        [request cancel];
    }
}

@end


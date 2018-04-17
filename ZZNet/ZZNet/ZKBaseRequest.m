//
//  ZKBaseRequest.m
//  TestAFN
//
//  Created by kobe on 2018/3/8.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import "ZKBaseRequest.h"
#import <AFNetworking/AFNetworking.h>

@interface ZKBaseRequest ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** NSURLSessionDataTask */
@property (nonatomic, weak) NSURLSessionDataTask *task;
/** tasks */
@property (nonatomic, strong) NSMutableDictionary *tasks;
@end



@implementation ZKBaseRequest

@synthesize targetKey = _targetKey;

- (instancetype)initWithTargetKey:(NSString *)targetKey {
    return [self initWithTargetKey:targetKey requestType:ZKBaseRequestTypeDefault];
}

- (instancetype)initWithTargetKey:(NSString *)targetKey requestType:(ZKBaseRequestType)requestType {
    self = [super init];
    if (self) {
        _targetKey = targetKey;
        _requestType = requestType;
    }
    return self;
}

- (void)start {
    
    NSURLSessionDataTask *task = [self.manager GET:[[self action] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n>>>>> success >>>>>\n");
        [self.tasks removeObjectForKey:@(task.taskIdentifier)];
        if ([_delegate respondsToSelector:@selector(requestFinished:responseObject:)]) {
            [_delegate requestFinished:self responseObject:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n>>>>>  error  >>>>>\n");
        [self.tasks removeObjectForKey:@(task.taskIdentifier)];
        if ([_delegate respondsToSelector:@selector(requestFailed:error:)]) {
            [_delegate requestFailed:self error:error];
        }
    }];
    
    self.task = task;
    if (task) {
        [self.tasks setObject:task forKey:@(task.taskIdentifier)];
    }
    
}

- (void)startInGroup {
    NSString *tagStr = [NSString stringWithFormat:@"%@", [NSDate date]];

    dispatch_semaphore_t  sema = dispatch_semaphore_create(0);
    NSLog(@"begain: %@", tagStr);

    NSURLSessionDataTask *task = [self.manager GET:[[self action] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@">> success: %@", tagStr);
        
        [self.tasks removeObjectForKey:@(task.taskIdentifier)];
        dispatch_semaphore_signal(sema);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@">> error: %@", tagStr);
        [self.tasks removeObjectForKey:@(task.taskIdentifier)];
        dispatch_semaphore_signal(sema);
    }];
    self.task = task;
    if (task) {
        [self.tasks setObject:task forKey:@(task.taskIdentifier)];
    }
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (void)startWithSemaphore:(dispatch_semaphore_t)semaphore {
    NSString *tagStr = [NSString stringWithFormat:@"%@", [NSDate date]];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"begain: %@", tagStr);
    
    NSURLSessionDataTask *task = [self.manager GET:[[self action] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@">> success: %@", tagStr);
        [self.tasks removeObjectForKey:@(task.taskIdentifier)];
        dispatch_semaphore_signal(semaphore);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@">> error: %@", tagStr);
        [self.tasks removeObjectForKey:@(task.taskIdentifier)];
        dispatch_semaphore_signal(semaphore);
        
    }];
    
    self.task = task;
    if (task) {
        [self.tasks setObject:task forKey:@(task.taskIdentifier)];
    }
}


- (void)cancel {
    for (NSNumber *taskID in self.tasks) {
        [self.tasks[taskID] cancel];
    }
    [self.tasks removeAllObjects];
}


#pragma mark - getter

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseURL]]];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 10;
    }
    return _manager;
    
}

- (NSMutableDictionary *)tasks {
    if (!_tasks) {
        _tasks = [NSMutableDictionary dictionary];
    }
    return _tasks;
}

#pragma mark - pamater

- (NSString *)targetKey {
    return _targetKey;
}

- (ZKBaseRequestType)requestType {
    return _requestType;
}

- (NSString *)baseURL {
    return @"https://www.sojson.com/";
}

- (NSString *)action {
    return @"open/api/weather/json.shtml?city=北京";
}


/*
 #pragma mark - sync
 
 - (void)testSync {
 //创建串行队列
 dispatch_queue_t queue = dispatch_queue_create("ZZNet.Request.Sync.task", DISPATCH_QUEUE_SERIAL);
 //设置信号总量为1，保证只有一个进程执行
 dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
 dispatch_async(queue, ^(){
 //等待信号量
 //请求A
 [self requestSyncWith:@"A" sema:semaphore];
 });
 
 dispatch_async(queue, ^(){
 //请求B
 [self requestSyncWith:@"B" sema:semaphore];
 });
 dispatch_async(queue, ^(){
 //请求C
 [self requestSyncWith:@"C" sema:semaphore];
 
 });
 }
 
 - (void)requestSyncWith:(NSString *)tagStr sema:(dispatch_semaphore_t)sema {
 NSLog(@"join: %@", tagStr);
 dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
 NSLog(@"begain: %@", tagStr);
 
 NSURLSessionDataTask *task = [self.manager GET:[[self action] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 NSLog(@">> success: %@", tagStr);
 [self.tasks removeObjectForKey:@(task.taskIdentifier)];
 dispatch_semaphore_signal(sema);
 
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 NSLog(@">> error: %@", tagStr);
 [self.tasks removeObjectForKey:@(task.taskIdentifier)];
 dispatch_semaphore_signal(sema);
 
 }];
 
 self.task = task;
 if (task) {
 [self.tasks setObject:task forKey:@(task.taskIdentifier)];
 }
 }
 
 
 #pragma mark - sync and total
 
 - (void)testSyncAndTotal {
 dispatch_group_t group = dispatch_group_create();
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 
 dispatch_group_async(group, queue, ^{
 [self requestSyncAndTotalWith:@"A"];
 });
 dispatch_group_async(group, queue, ^{
 [self requestSyncAndTotalWith:@"B"];
 });
 dispatch_group_async(group, queue, ^{
 [self requestSyncAndTotalWith:@"C"];
 });
 dispatch_group_notify(group, dispatch_get_main_queue(), ^{
 //刷新界面
 NSLog(@"刷新界面");
 });
 }
 
 - (void)requestSyncAndTotalWith:(NSString *)tagStr {
 NSLog(@"begain: %@", tagStr);
 
 dispatch_semaphore_t  sema = dispatch_semaphore_create(0);
 
 NSURLSessionDataTask *task = [self.manager GET:[[self action] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 NSLog(@">> success: %@", tagStr);
 
 [self.tasks removeObjectForKey:@(task.taskIdentifier)];
 dispatch_semaphore_signal(sema);
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 NSLog(@">> error: %@", tagStr);
 [self.tasks removeObjectForKey:@(task.taskIdentifier)];
 dispatch_semaphore_signal(sema);
 }];
 self.task = task;
 if (task) {
 [self.tasks setObject:task forKey:@(task.taskIdentifier)];
 }
 dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
 }
 */


@end

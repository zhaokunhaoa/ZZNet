//
//  ZKBaseRequest.h
//  TestAFN
//
//  Created by kobe on 2018/3/8.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZKBaseRequest;

@protocol ZKBaseRequestDelegate <NSObject>

@required
- (void)requestFinished:(ZKBaseRequest *)request responseObject:(id)responseObject;
- (void)requestFailed:(ZKBaseRequest *)request error:(NSError *)error;

@end

typedef NS_ENUM(NSUInteger, ZKBaseRequestType) {
    ZKBaseRequestTypeDefault = 0,
    ZKBaseRequestTypeSerial,
    ZKBaseRequestTypeGroup,
};

@interface ZKBaseRequest : NSObject

@property (nonatomic, weak) id<ZKBaseRequestDelegate> delegate;
@property (nonatomic, assign) ZKBaseRequestType requestType;

@property (nonatomic, readonly, copy) NSString *targetKey;
@property (nonatomic, readonly, copy) NSString *baseURL;
@property (nonatomic, readonly, copy) NSString *action;

- (instancetype)initWithTargetKey:(NSString *)targetKey;
- (instancetype)initWithTargetKey:(NSString *)targetKey requestType:(ZKBaseRequestType)requestType;

- (Class)responseClass;

- (void)start;
- (void)startInGroup;
- (void)startWithSemaphore:(dispatch_semaphore_t)semaphore;

- (void)cancel;

//- (void)requestFinished:(ZKBaseRequest *)request responseObject:(id)responseObject;
//- (void)requestFailed:(ZKBaseRequest *)request error:(NSError *)error;

- (void)testSync;
- (void)testSyncAndTotal;

@end

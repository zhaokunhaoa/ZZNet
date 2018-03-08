//
//  ZKBaseRequest.h
//  TestAFN
//
//  Created by kobe on 2018/3/8.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKBaseRequest : NSObject

- (NSString *)baseURL;
- (NSString *)action;

- (void)start;
- (void)cancel;
- (void)testSync;
- (void)testSyncAndTotal;

@end

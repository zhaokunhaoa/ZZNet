//
//  ZKGroupRequest.h
//  ZZNet
//
//  Created by Zhao Kun on 2018/3/9.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKBaseRequest.h"

@interface ZKGroupRequest : NSObject

@property (nonatomic, strong) NSArray<ZKBaseRequest *> *requests;

- (void)startAndCompletion:(void (^)())completion;
- (void)cancel;

@end



//
//  ZKSerialRequest.h
//  ZZNet
//
//  Created by Zhao Kun on 2018/4/17.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKBaseRequest.h"

@interface ZKSerialRequest : NSObject

@property (nonatomic, strong) NSArray<ZKBaseRequest *> *requests;

- (void)start;
- (void)cancel;

@end

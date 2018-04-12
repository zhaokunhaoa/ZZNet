//
//  ZKGroupRequest.h
//  ZZNet
//
//  Created by Zhao Kun on 2018/3/9.
//  Copyright © 2018年 hanamichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKBaseRequest.h"

@class ZKGroupRequestItem;

@interface ZKGroupRequest : NSObject

- (void)startRequests:(NSArray<ZKGroupRequestItem *> *)requests;

@end



@interface ZKGroupRequestItem : NSObject

@end

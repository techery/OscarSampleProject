//
// Created by Anastasiya Gorban on 8/21/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Oscar/OSActor.h>


@interface OSPTwitterLoginActor : OSActor
@end

/// Message
@interface OSPTwitterLogin: NSObject
@end

/// Result
@interface OSPTwitterUser: NSObject
@property (nonatomic, readonly, copy) NSString *name;
- (instancetype)initWithName:(NSString *)name;
@end

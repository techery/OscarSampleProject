//
// Created by Anastasiya Gorban on 8/21/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OSPUser : NSObject
@property (nonatomic, readonly, copy) NSString *name;
- (instancetype)initWithName:(NSString *)name;
@end
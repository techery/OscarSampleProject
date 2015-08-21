//
// Created by Anastasiya Gorban on 8/21/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import "OSPUser.h"


@implementation OSPUser

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }

    return self;
}

@end
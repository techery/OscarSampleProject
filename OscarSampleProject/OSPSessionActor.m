//
// Created by Anastasiya Gorban on 8/21/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import "OSPSessionActor.h"
#import "OSPTwitterLoginActor.h"
#import "OSPUser.h"
#import <Oscar/OSActors.h>

@interface OSPSessionActor ()

@end

@implementation OSPSessionActor

- (void)setup {
    [self on:[OSPLogin class] doFuture:^RXPromise *(id o) {
        OSActorRef *twitterLoginActor = [self.actorSystem actorOfClass:[OSPTwitterLoginActor class] caller:self];

        RXPromise *result = [twitterLoginActor ask:[OSPTwitterLogin new]];
        result.then(^id(OSPTwitterUser *twitterUser) {
            return [[OSPUser alloc] initWithName:twitterUser.name];
        }, nil);
        
        return result;
    }];
}

@end

@implementation OSPLogin
@end
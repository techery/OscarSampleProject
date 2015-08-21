//
// Created by Anastasiya Gorban on 8/21/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import "OSPSessionActor.h"
#import "OSPTwitterLoginActor.h"
#import <Oscar/OSActors.h>

@interface OSPSessionActor ()

@end

@implementation OSPSessionActor

- (void)setup {
    [self on:[OSPLogin class] doFuture:^RXPromise *(id o) {
        OSActorRef *twitterLoginActor = [self.actorSystem actorOfClass:[OSPTwitterLoginActor class] caller:self];

        return [twitterLoginActor ask:[OSPTwitterLogin new]];
    }];
}

@end

@implementation OSPLogin
@end
//
// Created by Anastasiya Gorban on 8/21/15.
// Copyright (c) 2015 Techery. All rights reserved.
//

#import "OSPTwitterLoginActor.h"
#import "RXPromise.h"
#import <Accounts/Accounts.h>


@implementation OSPTwitterLoginActor

- (void)setup {
    [self on:[OSPTwitterLogin class] doFuture:^RXPromise *(id o) {
        return [self tryAccessAccount];
    }];
}

#pragma mark - Private

- (RXPromise *)tryAccessAccount {
    RXPromise *promise = [RXPromise new];

    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

    ACAccountStoreRequestAccessCompletionHandler accountStoreRequestCompletionHandler = ^(BOOL granted, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{

            if(!granted) {
                [promise rejectWithReason:error];
                return;
            }

            ACAccount *account = [[accountStore accountsWithAccountType:accountType] firstObject];
            OSPTwitterUser *user = [[OSPTwitterUser alloc] initWithName:account.username];
            [promise resolveWithResult:user];
        }];
    };

    [accountStore requestAccessToAccountsWithType:accountType
                                          options:NULL
                                       completion:accountStoreRequestCompletionHandler];

    return promise;
}

@end

@implementation OSPTwitterLogin
@end

@implementation OSPTwitterUser

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }

    return self;
}

@end
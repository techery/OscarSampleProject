//
//  OSPLoginViewController.m
//  OscarSampleProject
//
//  Created by Anastasiya Gorban on 8/21/15.
//  Copyright (c) 2015 Techery. All rights reserved.
//

#import <Oscar/OSActorSystem.h>
#import "OSPLoginViewController.h"
#import "OSPSessionActor.h"
#import <RXPromise/RXPromise.h>

@interface OSPLoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property(nonatomic, strong) OSMainActorSystem *actorSystem;
@end

@implementation OSPLoginViewController
- (instancetype)initWithActorSystem:(OSMainActorSystem *)actorSystem {
    self = [super initWithNibName:@"OSPLoginViewController" bundle:nil];
    if (self) {
        self.actorSystem = actorSystem;
    }

    return self;
}

+ (instancetype)controllerWithActorSystem:(OSMainActorSystem *)actorSystem {
    return [[self alloc] initWithActorSystem:actorSystem];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)login:(id)sender {
    OSActorRef *sessionActor = [self.actorSystem actorOfClass:[OSPSessionActor class] caller:self];
    RXPromise *result = [sessionActor ask:[OSPLogin new]];
    result.thenOnMain(^id(id result){
                return nil;
            },
            ^id(NSError* error){
                self.errorLabel.text = error.localizedDescription;
                return nil;
            });
}

@end

//
//  OSPLoginViewController.h
//  OscarSampleProject
//
//  Created by Anastasiya Gorban on 8/21/15.
//  Copyright (c) 2015 Techery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OSMainActorSystem;

@interface OSPLoginViewController : UIViewController

- (instancetype)initWithActorSystem:(OSMainActorSystem *)actorSystem;
+ (instancetype)controllerWithActorSystem:(OSMainActorSystem *)actorSystem;

@end


//
//  BaseAnimationController.m
//  GateTransition
//
//  Created by ZhaoWei on 15/7/17.
//  Copyright (c) 2015年 csdept. All rights reserved.
//

#import "BaseAnimationController.h"

@implementation BaseAnimationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _reverse = NO;
        _duration = .5f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
}

@end

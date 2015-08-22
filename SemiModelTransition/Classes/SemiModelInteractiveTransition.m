//
//  SemiModelInteractiveTransition.m
//  SemiModelTransition
//
//  Created by ZhaoWei on 15/7/20.
//  Copyright (c) 2015年 csdept. All rights reserved.
//

#import "SemiModelInteractiveTransition.h"

@interface SemiModelInteractiveTransition ()

@property (nonatomic, assign) BOOL shouldCompleteTransition;
@property (nonatomic, weak  ) UIViewController *controller;
@property (nonatomic, assign) CGFloat startScale;

@end

@implementation SemiModelInteractiveTransition

- (void)wireToViewController:(UIViewController *)vc
{
    _controller = vc;
    _distanceFromTop = [UIScreen mainScreen].bounds.size.height/2;
    
    UIPanGestureRecognizer *pinch = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [vc.view addGestureRecognizer:pinch];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:self.controller.view];
    
    switch (gesture.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            self.interactionInProgress = YES;
            [self.controller dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
        
            CGFloat height = self.controller.view.bounds.size.height - self.distanceFromTop;
            CGFloat fraction = point.y/height;
            self.shouldCompleteTransition = (fraction > 0.5);
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            
            self.interactionInProgress = NO;
            if (!self.shouldCompleteTransition || gesture.state == UIGestureRecognizerStateCancelled)
            {
                [self cancelInteractiveTransition];
            }
            else
            {
                [self finishInteractiveTransition];
            }
            break;
        }
            
        default: {
            break;
        }
    }
}

@end

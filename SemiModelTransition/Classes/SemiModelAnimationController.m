//
//  SemiModelAnimation.m
//  SemiModelTransition
//
//  Created by ZhaoWei on 15/7/17.
//  Copyright (c) 2015年 csdept. All rights reserved.
//

#import "SemiModelAnimationController.h"
#import "UIColor+Random.h"

@implementation SemiModelAnimationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _distanceFromTop = [UIScreen mainScreen].bounds.size.height/2;
    }
    return self;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f*M_PI/180.0f, 1, 0, 0);
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = t1.m34;
    CGFloat scale = 0.8;
    t2 = CATransform3DTranslate(t2, 0, -0.07 * fromVC.view.frame.size.height, 0);
    t2 = CATransform3DScale(t2, scale, scale, 1);
    
    if (!self.reverse)
    {
        CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
        CGSize size = [UIScreen mainScreen].bounds.size;
        CGRect initialFrame = CGRectOffset(finalFrame, 0, size.height);
        toVC.view.frame = initialFrame;
        [containerView addSubview:toVC.view];
        
        fromVC.view.layer.zPosition = -1000;
        
        [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
                
                fromVC.view.layer.transform = t1;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                
                fromVC.view.layer.transform = t2;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
                
                toVC.view.frame = CGRectOffset(finalFrame, 0, self.distanceFromTop);
            }];
            
        } completion:^(BOOL finished) {
            
            fromVC.view.layer.zPosition = 0;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    else
    {
        toVC.view.layer.transform = CATransform3DIdentity;
        toVC.view.alpha = 0;
        
        UIView *snapshotView = [toVC.view snapshotViewAfterScreenUpdates:NO];
        [containerView addSubview:snapshotView];
        [containerView sendSubviewToBack:snapshotView];
        snapshotView.layer.zPosition = -1000;
        
        snapshotView.frame  = toVC.view.frame;
        snapshotView.layer.transform = t2;
        
        //toVC.view.backgroundColor = [UIColor randomColor];
        
        [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
                
                snapshotView.layer.transform = t1;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                
                snapshotView.layer.transform = CATransform3DIdentity;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
                
                fromVC.view.frame = CGRectOffset(fromVC.view.frame, 0, fromVC.view.frame.size.height - self.distanceFromTop);
            }];
            
        } completion:^(BOOL finished) {
            [snapshotView removeFromSuperview];
            toVC.view.alpha = 1.0;

            if ([transitionContext transitionWasCancelled])
            {
                toVC.view.layer.transform = t1;
                toVC.view.layer.transform = t2;
            }
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end

//
//  SemiModelPresentationController.m
//  SemiModelTransition
//
//  Created by ZhaoWei on 15/7/20.
//  Copyright (c) 2015年 csdept. All rights reserved.
//

#import "SemiModelPresentationController.h"

@interface SemiModelPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation SemiModelPresentationController


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _dimmingView = [[UIView alloc] init];
        _dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        _dimmingView.alpha = 0.0;
    }
    
    return self;
}


#pragma mark - Overridden Methods

- (void)presentationTransitionWillBegin {
    UIViewController *presentedViewController = self.presentedViewController;
    self.dimmingView.frame = self.containerView.bounds;
    self.dimmingView.alpha = 0.0;
    
    [self.containerView insertSubview:self.dimmingView atIndex:0];
    
    if ([presentedViewController transitionCoordinator]) {
        [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.dimmingView.alpha = 1.0;
        } completion:nil];
    } else {
        self.dimmingView.alpha = 1.0;
    }
}

- (void)dismissalTransitionWillBegin {
    if (self.presentedViewController.transitionCoordinator) {
        
        [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.dimmingView.alpha = 0.0;
        } completion:nil];
        
    } else {
        self.dimmingView.alpha = 0.0;
    }
}

- (void)containerViewWillLayoutSubviews {
    self.dimmingView.frame = self.containerView.bounds;
}

#pragma mark - UIAdaptivePresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyle {
    return UIModalPresentationFullScreen;
}


@end

//
//  ViewController.m
//  SemiModelTransition
//
//  Created by ZhaoWei on 15/7/17.
//  Copyright (c) 2015年 csdept. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "SemiModelAnimationController.h"
#import "SemiModelInteractiveTransition.h"
#import "SemiModelPresentationController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) SemiModelAnimationController *animator;
@property (nonatomic, strong) SemiModelInteractiveTransition *interactiveAnimator;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //Present or dismiss animator
        _animator = [SemiModelAnimationController new];
        _animator.distanceFromTop = 200;
        
        //Pan gesture animator
        _interactiveAnimator = [SemiModelInteractiveTransition new];
        _interactiveAnimator.distanceFromTop = 200;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(150, 100, 100, 100)];
    [button setTitle:@"Present" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClicked
{
    SecondViewController *vc = [SecondViewController new];
    vc.transitioningDelegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    [self.interactiveAnimator wireToViewController:presented];
    self.animator.reverse = NO;
    return self.animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animator.reverse = YES;
    return self.animator;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactiveAnimator.interactionInProgress ? self.interactiveAnimator : nil;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[SemiModelPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end

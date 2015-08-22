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
@property (nonatomic, strong) SemiModelAnimationController *animator1;
@property (nonatomic, strong) SemiModelInteractiveTransition *transition;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _animator = [SemiModelAnimationController new];
    _animator.distanceFromTop = 200;
    
    _animator1 = [SemiModelAnimationController new];
    _animator1.reverse = YES;
    _animator1.distanceFromTop = 200;
    
    _transition = [SemiModelInteractiveTransition new];
    _transition.distanceFromTop = 200;
    
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

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    [self.transition wireToViewController:presented];
    return self.animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.animator1;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.transition.interactionInProgress ? self.transition : nil;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[SemiModelPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end

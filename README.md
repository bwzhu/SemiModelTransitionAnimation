# SemiModelTransitionAnimation

###Screenshot 
![](Demo.gif)

Getting Started
===============
##Installation 
Copy all files in `Classes` directory to your project
##Setup manually
Initialization
```objc
@property (nonatomic, strong) SemiModelAnimationController *animator;
@property (nonatomic, strong) SemiModelInteractiveTransition *interactiveAnimator;

- (instancetype)init
{
    self = [super init];
    if (self) {
        //Present or dismiss animator
        _animator = [SemiModelAnimationController new];
        _animator.distanceFromTop = 200;
        
        //Pan gesture animator
        _interactiveAnimator = [SemiModelInteractiveTransition new];
        _interactiveAnimator.distanceFromTop = 200;
    }
    return self;
}
```

Remember to set the modalPresentationStyle of presentedController to UIModalPresentationCustom
```objc
self.modalPresentationStyle = UIModalPresentationCustom;
```

Implement ```UIViewControllerTransitioningDelegate``` and this delegate method:
```objc
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
```

##Requirements
iOS 8.0+



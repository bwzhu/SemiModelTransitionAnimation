//
//  SemiModelInteractiveTransition.h
//  SemiModelTransition
//
//  Created by ZhaoWei on 15/7/20.
//  Copyright (c) 2015年 csdept. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemiModelInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interactionInProgress;
@property (nonatomic, assign) NSInteger distanceFromTop;

- (void)wireToViewController:(UIViewController *)vc;

@end

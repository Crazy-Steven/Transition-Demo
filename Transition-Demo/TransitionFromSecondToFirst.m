//
//  TransitionFromSecondToFirst.m
//  Transition-Demo
//
//  Created by 郭艾超 on 16/5/31.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "TransitionFromSecondToFirst.h"
#import "QQViewController.h"
#import "QQSecondViewController.h"
@implementation TransitionFromSecondToFirst
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UINavigationController * nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    QQViewController * toViewController = (QQViewController *)nav.topViewController;
    QQSecondViewController * fromViewController = (QQSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView * containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView * cellImageSnapshot = [fromViewController.bigImageView snapshotViewAfterScreenUpdates:YES];
    
    cellImageSnapshot.frame = [containerView convertRect:fromViewController.bigImageView.frame fromView:fromViewController.view];
    fromViewController.bigImageView.hidden = YES;
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.smallImageView.hidden = YES;
    
    [containerView addSubview:nav.view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.alpha = 1.0;
        
        CGRect frame = [containerView convertRect:toViewController.smallImageView.frame fromView:toViewController.containerView];
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        toViewController.smallImageView.hidden = NO;
        fromViewController.bigImageView.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end

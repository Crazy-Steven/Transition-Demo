//
//  TransitionFromFirstToSecond.m
//  Transition-Demo
//
//  Created by 郭艾超 on 16/5/31.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "TransitionFromFirstToSecond.h"
#import "QQViewController.h"
#import "QQSecondViewController.h"
@implementation TransitionFromFirstToSecond
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UINavigationController * nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    QQViewController * fromViewController = (QQViewController *)nav.topViewController;
    QQSecondViewController * toViewController = (QQSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView * cellImageSnapshot = [fromViewController.smallImageView snapshotViewAfterScreenUpdates:YES];
    cellImageSnapshot.frame = [containerView convertRect:fromViewController.smallImageView.frame fromView:fromViewController.containerView];
    fromViewController.smallImageView.hidden = YES;
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.bigImageView.hidden = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.alpha = 1.0;
        
        CGRect frame = [containerView convertRect:toViewController.bigImageView.frame fromView:toViewController.view];
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        toViewController.bigImageView .hidden = NO;
        fromViewController.smallImageView.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end

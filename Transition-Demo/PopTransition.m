//
//  PopTransition.m
//  Transition-Demo
//
//  Created by 郭艾超 on 16/5/29.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "PopTransition.h"
@interface PopTransition()
@property (nonatomic, strong) id transitionContext;
@end

@implementation PopTransition
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    _transitionContext = transitionContext;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [fromViewController.view.layer removeAllAnimations];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:fromViewController.view];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
    fromViewController.view.layer.transform = transform;
    fromViewController.view.layer.anchorPoint = CGPointMake(1, 0.5);
    fromViewController.view.layer.position = CGPointMake(CGRectGetMaxX(toViewController.view.frame), CGRectGetMidY(toViewController.view.frame));
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration = [self transitionDuration:transitionContext];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI_2);
    animation.delegate = self;
    [fromViewController.view.layer addAnimation:animation forKey:@"rotateAnimation"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        
        [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
    }
}


@end

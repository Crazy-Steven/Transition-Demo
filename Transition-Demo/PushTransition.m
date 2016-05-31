//
//  PushTransition.m
//  Transition-Demo
//
//  Created by 郭艾超 on 16/5/29.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "PushTransition.h"
@interface PushTransition()
@property (nonatomic, strong) id transitionContext;

@end

@implementation PushTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    _transitionContext = transitionContext;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:toViewController.view];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration = [self transitionDuration:transitionContext];
    animation.fromValue = @(M_PI_2);
    animation.toValue = @(0);
    animation.delegate = self;
    [toViewController.view.layer addAnimation:animation forKey:@"rotateAnimation"];
    
    toViewController.view.layer.anchorPoint = CGPointMake(1, 0.5);
    toViewController.view.layer.position = CGPointMake(CGRectGetMaxX(fromViewController.view.frame), CGRectGetMidY(toViewController.view.frame));
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
    toViewController.view.layer.transform = transform;
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        
        [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
        
    }
}

@end

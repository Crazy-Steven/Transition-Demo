//
//  SecondViewController.m
//  Transition-Demo
//
//  Created by 郭艾超 on 16/5/29.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "SecondViewController.h"
#import "PopTransition.h"
@interface SecondViewController ()<UINavigationControllerDelegate>
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition * interaction;
@property (strong, nonatomic) UIScreenEdgePanGestureRecognizer * pan;
@end

@implementation SecondViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlEdgeScreenPanGesture:)];
    _pan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UINavigationController delegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return [[PopTransition alloc] init];
    }
    return nil;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return _interaction;
}

- (void)handlEdgeScreenPanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    CGFloat progress = ([recognizer translationInView:self.view].x)/CGRectGetWidth(self.view.frame);
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            _interaction = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [_interaction updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (progress >= 0.5) {
                [_interaction finishInteractiveTransition];
            }else {
                [_interaction cancelInteractiveTransition];
            }
            _interaction = nil;
        }
        default:
            break;
    }
}
@end

//
//  ViewController.m
//  Transition-Demo
//
//  Created by 郭艾超 on 16/5/29.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "ViewController.h"
#import "PushTransition.h"

@interface ViewController ()<UINavigationControllerDelegate>
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition * interaction;
@property (strong, nonatomic) UIScreenEdgePanGestureRecognizer * pan;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if  (self.navigationController.delegate != self) {
        self.navigationController.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlEdgeScreenPanGesture:)];
    _pan.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:_pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)pushToSecondVC:(id)sender {
    [self performSegueWithIdentifier:@"gPushToSecond" sender:nil];
}

#pragma mark - UINavigationController delegate
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return _interaction;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [[PushTransition alloc] init];
    }
    return nil;
}

- (void)handlEdgeScreenPanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    CGFloat progress = fabs([recognizer translationInView:self.view].x)/CGRectGetWidth(self.view.frame);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            _interaction = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self performSegueWithIdentifier:@"gPushToSecond" sender:nil];
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

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    
//    if (viewController == self.navigationController.pushingViewController) {
//        self.supportPan2Pop = YES;
//        self.navigationController.pushingViewController = nil;
//    }
}
@end

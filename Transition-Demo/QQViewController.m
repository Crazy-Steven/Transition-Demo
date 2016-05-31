//
//  QQViewController.m
//  Transition-Demo
//
//  Created by 郭艾超 on 16/5/31.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "QQViewController.h"
#import "QQSecondViewController.h"
#import "TransitionFromFirstToSecond.h"
#import "TransitionFromSecondToFirst.h"

static NSString * const gQQSecondViewController = @"gQQSecondViewController";
@interface QQViewController ()<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

@end
@implementation QQViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _smallImageView.layer.cornerRadius = self.view.bounds.size.height * 0.1 * 0.9 * 0.5;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentSecond:(UIButton *)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QQSecondViewController *sec = [story instantiateViewControllerWithIdentifier:gQQSecondViewController];
    sec.transitioningDelegate = self;
    [self presentViewController:sec animated:YES completion:nil];

}

#pragma mark - navigationController delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[TransitionFromFirstToSecond alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    return [[TransitionFromSecondToFirst alloc] init];
}
@end

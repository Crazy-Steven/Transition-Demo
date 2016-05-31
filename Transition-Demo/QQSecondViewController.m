//
//  QQSecondViewController.m
//  Transition-Demo
//
//  Created by 郭艾超 on 16/5/31.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "QQSecondViewController.h"

@implementation QQSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bigImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"naruto2.jpg"]];
    self.bigImageView.frame = CGRectMake(0, 0, self.view.bounds.size.width-50, self.view.bounds.size.width-50);
    self.bigImageView.center = self.view.center;
    self.bigImageView.layer.masksToBounds = YES;
    self.bigImageView.layer.cornerRadius = (self.view.bounds.size.width-50)*0.5;
    self.bigImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_bigImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)dismissFirst:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

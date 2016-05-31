//
//  ListTableViewController.m
//  Transition-Demo
//
//  Created by 郭艾超 on 16/5/29.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "ListTableViewController.h"

static NSString * const gPushQQ = @"gPushQQ";
static NSString * const gPushRotating = @"gPushRotating";

@interface ListTableViewController ()

@property (strong, nonatomic)NSArray * titleArr;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _titleArr = @[@"Rotating转场",@"QQMusicTransition"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _titleArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:gPushRotating sender:nil];
            break;
            
        case 1:
            [self performSegueWithIdentifier:gPushQQ sender:nil];
            break;
    }
}
@end

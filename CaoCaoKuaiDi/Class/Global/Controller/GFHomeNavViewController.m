//
//  GFHomeNavViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/13.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "GFHomeNavViewController.h"
#import "REFrostedViewController.h"
#import "HomeViewController.h"
#import "UIBarButtonItem+GFBarButtonItem.h"

@interface GFHomeNavViewController ()

@end

@implementation GFHomeNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
       
}

- (void)showMenu
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"%s",__func__);
    if (self.viewControllers.count != 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] highImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] target:self action:@selector(backToMainMenu) forControlEvents:UIControlEventTouchDown];
        
    }
    [super pushViewController:viewController animated:animated];
}

-(void)backToMainMenu {
    [self popToRootViewControllerAnimated:YES];
}


-(void)popToRoot {
    [self pushViewController:[HomeViewController new] animated:YES];
}
@end

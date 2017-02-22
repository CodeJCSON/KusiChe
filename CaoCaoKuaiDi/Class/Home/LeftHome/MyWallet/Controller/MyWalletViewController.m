//
//  MyWalletViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/2/27.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "MyWalletViewController.h"
#import "MyCouponCollectionViewController.h"
#import "UIBarButtonItem+GFBarButtonItem.h"
#import "GFHomeNavViewController.h"

@interface MyWalletViewController ()

@property (nonatomic,strong) UIButton *payHistoryButton;

@property (nonatomic,strong) UIButton *myDollarButton;

@property (nonatomic,strong) UIButton *myIntegral;

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:241.0/255.0 blue:235.0/255.0 alpha:1];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -initView
- (void) initView {
    self.title = @"我的钱包";
    self.payHistoryButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 84, SCRE_WIDTH - 40, 50)];
    [_payHistoryButton setImage:[UIImage imageNamed:@"pay_history_button"] forState:UIControlStateNormal];
    [_payHistoryButton addTarget:self action:@selector(payHistoryAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_payHistoryButton];
    
    self.myDollarButton = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_payHistoryButton.frame) + 10, SCRE_WIDTH - 40, 50)];
    [_myDollarButton setImage:[UIImage imageNamed:@"myCoupon_button"] forState:UIControlStateNormal];
    [_myDollarButton addTarget:self action:@selector(myDollarAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_myDollarButton];
    
    self.myIntegral = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_myDollarButton.frame) + 10, SCRE_WIDTH - 40, 50)];
    [_myIntegral setImage:[UIImage imageNamed:@"myIntegral_button"] forState:UIControlStateNormal];
    [_myIntegral addTarget:self action:@selector(myIntegralAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_myIntegral];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] highImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] target:(GFHomeNavViewController *)self.navigationController action:@selector(popToRoot) forControlEvents:UIControlEventTouchDown];
}


- (void)payHistoryAction {
    
}

- (void)myDollarAction {
    [self.navigationController pushViewController:[[MyCouponCollectionViewController alloc] init] animated:YES];
}

- (void)myIntegralAction {
    
}


@end

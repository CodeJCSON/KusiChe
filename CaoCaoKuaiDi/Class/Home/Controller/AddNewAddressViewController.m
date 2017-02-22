//
//  AddNewAddressViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/7.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "AddNewAddressViewController.h"

@interface AddNewAddressViewController ()

@end

@implementation AddNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark initView
- (void)initView {
    self.title = @"新增地址";
    self.view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:241.0/255.0 blue:235.0/255.0 alpha:1];
}

@end

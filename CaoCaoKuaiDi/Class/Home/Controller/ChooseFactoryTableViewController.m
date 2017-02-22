//
//  ChooseFactoryTableViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/4.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "ChooseFactoryTableViewController.h"

@interface ChooseFactoryTableViewController ()

@end

@implementation ChooseFactoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark initView 
- (void)initView {
    self.title = @"选择公司";
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}



@end

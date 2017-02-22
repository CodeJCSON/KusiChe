//
//  RecentOrdersViewController.m
//  CaoCaoKD
//
//  Created by goofygao on 16/2/26.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "RecentOrdersViewController.h"
#import "OrdersTableViewCell.h"

@interface RecentOrdersViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myOrdersTableView;



@end

@implementation RecentOrdersViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --init
- (void)initView {
    self.title = @"我的订单";
    self.myOrdersTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCRE_WIDTH, SCRE_HEIGHT)];
    _myOrdersTableView.delegate = self;
    _myOrdersTableView.dataSource = self;
    [self.view addSubview:_myOrdersTableView];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}


#pragma mark -action

- (void)rightButtonAction {
    
}

#pragma mark UITableViewDataSource,UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([OrdersTableViewCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }
    OrdersTableViewCell *cell = (OrdersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"近一个月订单";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCRE_WIDTH, 20)];
    headerLabel.text = @"近一个月订单";
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textColor = [UIColor grayColor];
    headerLabel.font = [UIFont systemFontOfSize:12];
    headerLabel.backgroundColor = [UIColor colorWithRed:250.0/255 green:244.0/255.0 blue:239.0/255.0 alpha:1];
    return headerLabel;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



@end
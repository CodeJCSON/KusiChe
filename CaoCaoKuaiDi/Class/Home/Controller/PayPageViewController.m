//
//  PayPageViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/8.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "PayPageViewController.h"
#import "ExpressOfUpDoorView.h"
#import "CostTotalView.h"
#import "ExpressSimpleTableViewCell.h"
#import "CouiserDetailViewController.h"
#import "EvaluateForCouieriewController.h"

@interface PayPageViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
/**
 *  快递上门view
 */
@property (nonatomic,strong) ExpressOfUpDoorView *expressOfUpDoorView;
/**
 *  消费总金额view
 */
@property (nonatomic,strong) CostTotalView *costTotalView;
/**
 *  支付背景
 */
@property (nonatomic,strong) UIView *payTypeBGView;
/**
 *  支付宝支付
 */
@property (nonatomic,strong) UIButton *payByZhiFuBaoButton;
/**
 *  微信支付
 */
@property (nonatomic,strong) UIButton *payByWeiXinBaoButton;
/**
 *  快递单列表
 */
@property (nonatomic,strong) UITableView *expressListTableView;
/**
 *  确认提交
 */
@property (nonatomic,strong) UIButton *submitButton;
@end

@implementation PayPageViewController
#define CELL_IDENFITY @"cell"

- (ExpressOfUpDoorView*)expressOfUpDoorView {
    if (!_expressOfUpDoorView) {
        _expressOfUpDoorView = [[[NSBundle mainBundle]loadNibNamed:@"ExpressOfUpDoorView" owner:self options:nil]objectAtIndex:0];
        _expressOfUpDoorView.frame = CGRectMake(5, 68, SCRE_WIDTH - 10, 65);
        _expressOfUpDoorView.layer.cornerRadius = 5;
        _expressOfUpDoorView.layer.masksToBounds = YES;
        [_expressOfUpDoorView.callCouierBtn addTarget:self action:@selector(callCouierAction) forControlEvents:UIControlEventTouchDown];
        [_expressOfUpDoorView.couierHistoryOrders addTarget:self action:@selector(couierHistoryOrdersAction) forControlEvents:UIControlEventTouchDown];
    }
    return _expressOfUpDoorView;
}

-(CostTotalView *)costTotalView {
    if (!_costTotalView) {
        _costTotalView = [[[NSBundle mainBundle]loadNibNamed:@"CostTotalView" owner:self options:nil]objectAtIndex:0];
        _costTotalView.frame = CGRectMake(5, CGRectGetMaxY(self.expressOfUpDoorView.frame) + 5, SCRE_WIDTH - 10, 100);
        _costTotalView.layer.cornerRadius = 5;
        _costTotalView.layer.masksToBounds = YES;
    }
    return _costTotalView;
}

- (UIView *)payTypeBGView {
    if (!_payTypeBGView) {
        _payTypeBGView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.costTotalView.frame) + 5, SCRE_WIDTH - 10, 120)];
        UILabel *payTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCRE_WIDTH, 20)];
        payTypeLabel.textColor = [UIColor grayColor];
        payTypeLabel.text = @"支付方式";
        payTypeLabel.font = [UIFont systemFontOfSize:14];
        payTypeLabel.textAlignment = NSTextAlignmentCenter;
        [_payTypeBGView addSubview:payTypeLabel];
        [self initPayTypeButton];
    }
    return _payTypeBGView;
}

- (UITableView *)expressListTableView {
    if (!_expressListTableView) {
        _expressListTableView = [[UITableView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.payTypeBGView.frame) + 10, SCRE_WIDTH - 10, SCRE_HEIGHT - CGRectGetMaxY(self.payTypeBGView.frame) - 50)];
        _expressListTableView.layer.cornerRadius = 5;
        _expressListTableView.layer.masksToBounds = YES;
        
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([ExpressSimpleTableViewCell class]) bundle:nil];
        [_expressListTableView registerNib:nib forCellReuseIdentifier:CELL_IDENFITY];
        _expressListTableView.delegate = self;
        _expressListTableView.dataSource = self;
    }
    return _expressListTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self.view addSubview:self.expressOfUpDoorView];
    [self.view addSubview:self.costTotalView];
    [self.view addSubview:self.payTypeBGView];
    
    [self.view addSubview:self.expressListTableView];
    [self initSubmitButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark initView
- (void)initView {
    self.title = @"支付收银台";
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
    
}

- (void)initPayTypeButton {
    self.payByWeiXinBaoButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 50, 50)];
    [_payByWeiXinBaoButton setBackgroundColor:[UIColor redColor]];
    [_payByWeiXinBaoButton addTarget:self action:@selector(weixinAction:) forControlEvents:UIControlEventTouchDown];
    [_payTypeBGView addSubview:_payByWeiXinBaoButton];
    
    self.payByZhiFuBaoButton = [[UIButton alloc] initWithFrame:CGRectMake(SCRE_WIDTH - 90, 40, 50, 50)];
    [_payByZhiFuBaoButton setBackgroundColor:[UIColor redColor]];
    [_payByZhiFuBaoButton addTarget:self action:@selector(zhifubaoAction:) forControlEvents:UIControlEventTouchDown];
    [_payTypeBGView addSubview:_payByZhiFuBaoButton];
}

- (void)initSubmitButton {
    self.submitButton = [[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.expressListTableView.frame) + 5, SCRE_WIDTH - 80,30)];
    _submitButton.layer.cornerRadius = 5;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton setBackgroundColor:[UIColor orangeColor]];
    [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_submitButton];
    
}

#pragma mark 事件响应 action 

- (void)weixinAction:(UIButton *)sender {
    
}


- (void)zhifubaoAction:(UIButton *)sender {
    
}

#warning 此处暂定跳转 默认支付
- (void)submitAction {
    [self.navigationController pushViewController:[EvaluateForCouieriewController new] animated:YES];
}

- (void)callCouierAction {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要打电话给\n18814184180" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alertView show];
}

- (void)couierHistoryOrdersAction {
    [self.navigationController pushViewController:[CouiserDetailViewController new] animated:YES];
}

#pragma mark UITableViewDataSource,UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([ExpressSimpleTableViewCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CELL_IDENFITY];
        nibsRegistered = YES;
    }
    ExpressSimpleTableViewCell *cell = (ExpressSimpleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CELL_IDENFITY];
    cell.expressNumberString = @"3122345";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}


#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18814184180"]];
    } else {
        
    }
}
@end

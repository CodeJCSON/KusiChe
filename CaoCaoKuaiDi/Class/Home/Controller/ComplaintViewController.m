//
//  ComplaintViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/11.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "ComplaintViewController.h"

@interface ComplaintViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *complainTableView;

@property (nonatomic,strong) NSMutableArray *compliaintArray;

@property (nonatomic,strong) UIButton *complainButton;

@property (nonatomic,strong) UITextField *otherWordsTextField;

@property (nonatomic,strong) UIButton * submitButton;

@end

@implementation ComplaintViewController
#define CELL_IDENFITY @"cell"

#pragma mark lazy load
-(UITableView *)complainTableView {
    if (!_complainTableView) {
        _complainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, SCRE_WIDTH, SCRE_HEIGHT - 160)];
        [_complainTableView registerClass:[UITableViewCell self] forCellReuseIdentifier:CELL_IDENFITY];
        _complainTableView.backgroundColor = [UIColor clearColor];
        _complainTableView.scrollEnabled = NO;
        _complainTableView.delegate= self;
        _complainTableView.dataSource = self;
    }
    return _complainTableView;
}

-(NSMutableArray *)compliaintArray {
    if (!_compliaintArray) {
        _compliaintArray = [NSMutableArray array];
        _compliaintArray = [@[
                               @"服务态度十分恶略",
                               @"未寄出快递产生费用",
                               @"快递员爽约",
                               @"快递员严重迟到",
                               @"骚扰客户",
                               @"快递员原因导致没有寄出快递",
                               @"不是显示的快递员",
                               ] mutableCopy];
    }
    return _compliaintArray;
}
-(UITextField *)otherWordsTextField {
    if (!_otherWordsTextField) {
        NSLog(@"___________%s   %f",__func__,CGRectGetMaxY(self.complainTableView.frame));
        _otherWordsTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.complainTableView.bounds) + 50 , SCRE_WIDTH - 40, 40)];
        _otherWordsTextField.delegate = self;
        _otherWordsTextField.layer.cornerRadius = 5;
        _otherWordsTextField.layer.masksToBounds = YES;
        _otherWordsTextField.placeholder = @"还有什么想说的?";
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
        leftView.backgroundColor = [UIColor clearColor];
        _otherWordsTextField.leftView = leftView;
        _otherWordsTextField.leftViewMode = UITextFieldViewModeAlways;
        _otherWordsTextField.textColor = [UIColor grayColor];
        _otherWordsTextField.font = [UIFont systemFontOfSize:15];
        _otherWordsTextField.backgroundColor = [UIColor whiteColor];
    }
    return _otherWordsTextField;
}

-(UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(10, SCRE_HEIGHT - 50, SCRE_WIDTH - 20, 35)];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchDown];
        [_submitButton setBackgroundColor:[UIColor grayColor]];
        _submitButton.layer.cornerRadius = 5;
        _submitButton.layer.masksToBounds = YES;
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _submitButton;
}
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
    self.title = @"投诉";
    self.view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:241.0/255.0 blue:235.0/255.0 alpha:1];
    UIButton *callServicePhone = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    callServicePhone.titleLabel.font =[UIFont systemFontOfSize:17];
    [callServicePhone setTitle:@"客服电话" forState:UIControlStateNormal];
    [callServicePhone setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [callServicePhone addTarget:self action:@selector(collectCouierAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:callServicePhone];
    
    UILabel *promptWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 64 + 10, SCRE_WIDTH - 10, 20)];
    promptWordLabel.text = @"寄快递的过程中遇到什么问题呢?";
    promptWordLabel.textColor = [UIColor grayColor];
    promptWordLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:promptWordLabel];
    
    [self.view addSubview:self.complainTableView];
    
    [self.view addSubview:self.otherWordsTextField];
    
    [self.view addSubview:self.submitButton];
}

//- (void)initComplainButton {
//    self.complainButton = [UIButton ALL]
//}

#pragma mark action事件响应

- (void)collectCouierAction {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18814184180"]];
}

- (void)submitAction:(UIButton *)sender {
    
}

#pragma mark UITableViewDataSource,UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellAccessoryNone;
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
         [_complainTableView registerClass:[UITableViewCell self] forCellReuseIdentifier:CELL_IDENFITY];
        nibsRegistered = YES;
    }
    UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(20,5, SCRE_WIDTH - 40, 40)];
    maskView.backgroundColor = [UIColor whiteColor];
    maskView.layer.borderColor = [UIColor grayColor].CGColor;
    maskView.layer.borderWidth = 1.0f;
    maskView.layer.cornerRadius = 5;
    maskView.layer.masksToBounds = YES;
//
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CELL_IDENFITY];
    [cell.contentView addSubview:maskView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, SCRE_WIDTH - 40, 30)];
    label.textColor = [UIColor grayColor];
    label.text = self.compliaintArray[indexPath.row];
    label.font = [UIFont systemFontOfSize:15];
    [maskView addSubview:label];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.compliaintArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

#pragma mark UITEXTFIELD

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

@end

//
//  EvaluateForCouieriewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/10.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "EvaluateForCouieriewController.h"
#import "ExpressOfUpDoorView.h"
#import "CouiserDetailViewController.h"
#import "PaySuccessAndCommentView.h"
#import "ExpressSimpleTableViewCell.h"
#import "UIBarButtonItem+GFBarButtonItem.h"
#import "ComplaintViewController.h"
#import "CourierCollectionViewController.h"

@interface EvaluateForCouieriewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) ExpressOfUpDoorView *expressOfUpDoorView;

@property (nonatomic,strong) PaySuccessAndCommentView *paySuccessAndCommentView;

@property (nonatomic,strong) UITableView *expressListTableView;
/**
 *  投诉
 */
@property (nonatomic,strong) UIButton *complaintButton;
/**
 *  分享优惠劵
 */
@property (nonatomic,strong) UIButton *shareCouponButton;

@end

@implementation EvaluateForCouieriewController

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

-(PaySuccessAndCommentView *)paySuccessAndCommentView {
    if (!_paySuccessAndCommentView) {
        _paySuccessAndCommentView = [[[NSBundle mainBundle]loadNibNamed:@"PaySuccessAndCommentView" owner:self options:nil]objectAtIndex:0];
        _paySuccessAndCommentView.frame = CGRectMake(5, CGRectGetMaxY(self.expressOfUpDoorView.frame) + 5, SCRE_WIDTH - 10, 130);
        [_paySuccessAndCommentView.expressDetailButton addTarget:self action:@selector(expressDetailAction) forControlEvents:UIControlEventTouchDown];
        [_paySuccessAndCommentView.starFirstButton addTarget:self action:@selector(firstSelectStarAction) forControlEvents:UIControlEventTouchDown];
        [_paySuccessAndCommentView.starSecondButton addTarget:self action:@selector(secondSelectStarAction) forControlEvents:UIControlEventTouchDown];
        [_paySuccessAndCommentView.starThirdButton addTarget:self action:@selector(thirdSelectStarAction) forControlEvents:UIControlEventTouchDown];
        [_paySuccessAndCommentView.starForthButton addTarget:self action:@selector(forthSelectStarAction) forControlEvents:UIControlEventTouchDown];
        [_paySuccessAndCommentView.starFiveButton addTarget:self action:@selector(fiveSelectStarAction) forControlEvents:UIControlEventTouchDown];
    }
    return _paySuccessAndCommentView;
}

- (UITableView *)expressListTableView {
    if (!_expressListTableView) {
        _expressListTableView = [[UITableView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.paySuccessAndCommentView.frame) + 10, SCRE_WIDTH - 10, SCRE_HEIGHT - CGRectGetMaxY(self.paySuccessAndCommentView.frame) - 50)];
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    self.title = @"评价";
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    UIButton *collectionCouierButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    collectionCouierButton.titleLabel.font =[UIFont systemFontOfSize:17];
    [collectionCouierButton setTitle:@"收藏快递员" forState:UIControlStateNormal];
    [collectionCouierButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [collectionCouierButton addTarget:self action:@selector(collectCouierAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:collectionCouierButton];
    
    UIButton *cancleMainMenu = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    cancleMainMenu.titleLabel.font =[UIFont systemFontOfSize:17];
    [cancleMainMenu setTitle:@"返回主菜单" forState:UIControlStateNormal];
    [cancleMainMenu setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [cancleMainMenu addTarget:self action:@selector(canleMainMenuAction) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancleMainMenu];

    
    [self.view addSubview:self.expressOfUpDoorView];
    [self.view addSubview:self.paySuccessAndCommentView];
    [self.view addSubview:self.expressListTableView];
    UIView *bottomMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_expressListTableView.frame) + 5, SCRE_WIDTH, SCRE_HEIGHT - CGRectGetMaxY(_expressListTableView.frame) - 5)];
    bottomMaskView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomMaskView];
    
    self.complaintButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 50, 30)];
    [_complaintButton setImage:[UIImage imageNamed:@"comment_complaint"] forState:UIControlStateNormal];
    [_complaintButton addTarget:self action:@selector(complaintAction) forControlEvents:UIControlEventTouchDown];
    [bottomMaskView addSubview:_complaintButton];
    
    self.shareCouponButton = [[UIButton alloc]initWithFrame:CGRectMake(SCRE_WIDTH - 90, 5, 80, 25)];
    [_shareCouponButton setImage:[UIImage imageNamed:@"comment_share-cop"] forState:UIControlStateNormal];
    [_complaintButton addTarget:self action:@selector(shareCouponButtonAction) forControlEvents:UIControlEventTouchDown];
    [bottomMaskView addSubview:_shareCouponButton];
}


#pragma mark action 事件响应
- (void)callCouierAction {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要打电话给\n18814184180" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alertView show];
}

- (void)couierHistoryOrdersAction {
    [self.navigationController pushViewController:[CouiserDetailViewController new] animated:YES];
}

//点击支付成功明细
- (void)expressDetailAction {
    
}

- (void)firstSelectStarAction {
    _paySuccessAndCommentView.starFirstButton.selected = YES;
    _paySuccessAndCommentView.starSecondButton.selected = NO;
    _paySuccessAndCommentView.starThirdButton.selected = NO;
    _paySuccessAndCommentView.starForthButton.selected = NO;
    _paySuccessAndCommentView.starFiveButton.selected = NO;
}

- (void)secondSelectStarAction {
    _paySuccessAndCommentView.starFirstButton.selected = YES;
    _paySuccessAndCommentView.starSecondButton.selected = YES;
    _paySuccessAndCommentView.starThirdButton.selected = NO;
    _paySuccessAndCommentView.starForthButton.selected = NO;
    _paySuccessAndCommentView.starFiveButton.selected = NO;
}

- (void)thirdSelectStarAction {
    _paySuccessAndCommentView.starFirstButton.selected = YES;
    _paySuccessAndCommentView.starSecondButton.selected = YES;
    _paySuccessAndCommentView.starThirdButton.selected = YES;
    _paySuccessAndCommentView.starForthButton.selected = NO;
    _paySuccessAndCommentView.starFiveButton.selected = NO;
}


- (void)forthSelectStarAction {
    _paySuccessAndCommentView.starFirstButton.selected = YES;
    _paySuccessAndCommentView.starSecondButton.selected = YES;
    _paySuccessAndCommentView.starThirdButton.selected = YES;
    _paySuccessAndCommentView.starForthButton.selected = YES;
    _paySuccessAndCommentView.starFiveButton.selected = NO;
}

- (void)fiveSelectStarAction {
    _paySuccessAndCommentView.starFirstButton.selected = YES;
    _paySuccessAndCommentView.starSecondButton.selected = YES;
    _paySuccessAndCommentView.starThirdButton.selected = YES;
    _paySuccessAndCommentView.starForthButton.selected = YES;
    _paySuccessAndCommentView.starFiveButton.selected = YES;
}
/**
 *  投诉快递员
 */
- (void)complaintAction {
    [self.navigationController pushViewController:[ComplaintViewController new] animated:YES];
}

- (void)shareCouponButtonAction {
    
}

- (void)collectCouierAction {
    [self.navigationController pushViewController:[CourierCollectionViewController new] animated:YES];
}

//返回主菜单
- (void)canleMainMenuAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
@end

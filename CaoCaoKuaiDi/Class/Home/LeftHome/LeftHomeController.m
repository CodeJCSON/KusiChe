//
//  LeftHomeController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/2/27.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "LeftHomeController.h"
#import "HomeViewController.h"
#import "GlobalNavigationController.h"
#import "MyWalletViewController.h"
#import "PersonalnfoTabViewController.h"
#import "RecommendViewController.h"
#import "SettingTabViewController.h"
#import "MessageViewController.h"
#import "MyOrdersViewController.h"
#import "OftenAdressViewController.h"
#import "REFrostedViewController.h"
#import "GFHomeNavViewController.h"
#import "UIView+Extend.h"

@interface LeftHomeController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *LeftTableView;

@property (nonatomic,strong) UIView *headView;

@property (nonatomic,strong) HomeViewController *PushDelegate;

@property (nonatomic,strong) NSArray *controllArr;

@property (nonatomic,strong) UIWindow *window;

@property (nonatomic,strong) UIImageView *userImageView;

@property (nonatomic,strong) UILabel *userNameLabel;

@property (nonatomic,strong) UILabel *userPhoneNumberLabel;

@end

@implementation LeftHomeController

- (NSArray *)controllArr
{
    if (!_controllArr) {
        _controllArr  = @[
                          [[MyWalletViewController alloc]init],
                          [[MyOrdersViewController alloc]init],
                          [[MessageViewController alloc]init],
                          [[RecommendViewController alloc]init],
                          [[OftenAdressViewController alloc]init],
                          [[SettingTabViewController alloc]init],
                          ];
    }
    return _controllArr;
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MOVE_X, 140)];
        
        UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, SCRE_WIDTH * 4/5, 100)];
        [_headView addSubview:imageView];
        UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTapClick)];
        [imageView addGestureRecognizer:headTap];

        self.userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 80, 80)];
        _userImageView.image = [UIImage imageNamed:@"touxiang"];
        _userImageView.layer.cornerRadius = _userImageView.width/2;
        _userImageView.layer.borderWidth = 5;
        _userImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _userImageView.layer.masksToBounds = YES;
        [imageView addSubview:_userImageView];
        
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userImageView.frame) + 10, CGRectGetMinY(_userImageView.frame) + 15, SCRE_WIDTH/2, 20)];
        _userNameLabel.text = @"Goofyy";
        _userNameLabel.font = [UIFont systemFontOfSize:13];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        [imageView addSubview:_userNameLabel];
        
        
        self.userPhoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(_userNameLabel.frame) + 5, 100, 20)];
        _userPhoneNumberLabel.text = @"188****4180";
        _userPhoneNumberLabel.font = [UIFont systemFontOfSize:13];
        _userPhoneNumberLabel.textAlignment = NSTextAlignmentLeft;
        [imageView addSubview:_userPhoneNumberLabel];
        
        UIImageView *imageViewMak = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(imageView.frame) - 40, 20, 10, 20)];
        imageViewMak.image = [UIImage imageNamed:@"header_view_right"];
        [imageView addSubview:imageViewMak];
    }
    return _headView;
}

- (UITableView *)LeftTableView
{
    if (!_LeftTableView) {
        _LeftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MOVE_X, SCRE_HEIGHT)];
       _LeftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _LeftTableView.backgroundColor = [UIColor clearColor];
        _LeftTableView.dataSource = self;
        _LeftTableView.delegate = self;
        _LeftTableView.scrollEnabled = NO;
    }
    return _LeftTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.LeftTableView];
    self.LeftTableView.tableHeaderView = self.headView;
    
}

#pragma mark 事件响应

-(void)headTapClick {
    PersonalnfoTabViewController *persinalInfo = [[PersonalnfoTabViewController alloc]init];

    GlobalNavigationController *navigationController = [[GlobalNavigationController alloc] initWithRootViewController:persinalInfo];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -tableview 设置数据源和代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
// 设置数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *Leftcell = [tableView dequeueReusableCellWithIdentifier:@"Leftcell"];
    if (!Leftcell) {
        Leftcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Leftcell"];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, Leftcell.frame.size.height-1, MOVE_X, 1)];
        [Leftcell.contentView addSubview:line];
        Leftcell.contentView.backgroundColor = [UIColor clearColor];
        Leftcell.backgroundColor = [UIColor clearColor];
        
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Leftcell.textLabel.text = @"我的钱包";
            Leftcell.imageView.image = [UIImage imageNamed:@"leftHome_wallet"];
            
            UIImageView *accessImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 40, 20)];
            accessImageView.image = [UIImage imageNamed:@"left_home_cell_score"];
            [accessImageView sizeToFit];
            Leftcell.accessoryView = accessImageView;
            
        }else if (indexPath.row == 1)
        {
            Leftcell.textLabel.text = @"我的订单";
            Leftcell.imageView.image = [UIImage imageNamed:@"leftHome_orders"];
        } else if (indexPath.row == 2)
        {
            Leftcell.textLabel.text = @"消息中心";
            Leftcell.imageView.image = [UIImage imageNamed:@"leftHome_message"];
        }
    } else if(indexPath.section == 1)  {
         if (indexPath.row == 0)
        {
            Leftcell.textLabel.text = @"推荐有奖";
            Leftcell.imageView.image = [UIImage imageNamed:@"leftHome_recommend"];
        }else if (indexPath.row == 1)
        {
            Leftcell.textLabel.text = @"常用地址";
            Leftcell.imageView.image = [UIImage imageNamed:@"leftHome_usual_address"];
        }else if (indexPath.row == 2) {
            Leftcell.textLabel.text = @"设置";
            Leftcell.imageView.image = [UIImage imageNamed:@"leftHome_setting"];
        }

    }
    return Leftcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
         UIViewController *vc = self.controllArr[indexPath.row];
        GlobalNavigationController *navigationController = [[GlobalNavigationController alloc] initWithRootViewController:vc];
        self.frostedViewController.contentViewController = navigationController;
        
        [self.frostedViewController hideMenuViewController];
    }else if (indexPath.section == 1) {
        UIViewController *vc = self.controllArr[indexPath.row + 3];
        GlobalNavigationController *navigationController = [[GlobalNavigationController alloc] initWithRootViewController:vc];
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *heightView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 200, 1)];
//    if (section == 0) {
    
        heightView.backgroundColor = [UIColor grayColor];
        return heightView;
//    }
//    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
#pragma mark touch代理
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    
//    CGPoint touchPoint = [touch locationInView:self.view];
//    if (touchPoint.x > SCRE_WIDTH * 4/5) {
//
//    }
//}


@end


//
//  RecommendViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/2/27.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "RecommendViewController.h"
#import "GFHomeNavViewController.h"
#import "UIBarButtonItem+GFBarButtonItem.h"
#import "UIView+Extend.h"

@interface RecommendViewController ()

@property (nonatomic,strong) UIButton *invitationButton;

@property (nonatomic,strong) UIButton *shareButton;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  推荐有奖
- (void)initView {
    self.title = @"推荐有奖";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bottomBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(-5, SCRE_HEIGHT * 2/5, SCRE_WIDTH + 10, SCRE_HEIGHT * 3/5)];
    bottomBGImageView.image = [UIImage imageNamed:@"recommend_bg"];
    [self.view addSubview:bottomBGImageView];
    
    UIImageView *avaImageView = [[UIImageView alloc]init];
    avaImageView.width = 70.0;
    avaImageView.height = 90.0;
    avaImageView.center = CGPointMake(SCRE_WIDTH/2, CGRectGetMinY(bottomBGImageView.frame) - 60);
    avaImageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    avaImageView.layer.shadowOffset = CGSizeMake(20, 20);
    avaImageView.layer.shadowRadius = 50.0;
    avaImageView.image = [UIImage imageNamed:@"recommend_Ava"];
    [self.view addSubview:avaImageView];
    
    self.invitationButton = [[UIButton alloc]init];
    _invitationButton.frame = CGRectMake(50, SCRE_HEIGHT/4, SCRE_WIDTH - 100, 40);
    _invitationButton.layer.cornerRadius = 5;
    _invitationButton.layer.masksToBounds = YES;
    [_invitationButton setBackgroundImage:[UIImage imageNamed:@"recommend_button_bg"] forState:UIControlStateNormal];
    [_invitationButton setTitle:@"邀请联系人" forState:UIControlStateNormal];
    [bottomBGImageView addSubview:_invitationButton];
    
    self.shareButton = [[UIButton alloc]init];
    _shareButton.frame = CGRectMake(50, SCRE_HEIGHT/4 + 50, SCRE_WIDTH - 100, 40);
    _shareButton.layer.cornerRadius = 5;
    _shareButton.layer.masksToBounds = YES;
    _shareButton.layer.borderWidth = 1;
    _shareButton.layer.borderColor = [[UIColor orangeColor] CGColor];
    [_shareButton setBackgroundColor:[UIColor whiteColor]];
    _shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_shareButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_shareButton setTitle:@"分享到社交媒体" forState:UIControlStateNormal];
    [bottomBGImageView addSubview:_shareButton];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] highImage:[UIImage imageNamed:@"iconfont-dianjicichufanhui"] target:(GFHomeNavViewController *)self.navigationController action:@selector(popToRoot) forControlEvents:UIControlEventTouchDown];
    
}

@end

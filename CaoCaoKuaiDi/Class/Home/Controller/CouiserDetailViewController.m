//
//  CouiserDetailViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/10.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "CouiserDetailViewController.h"
#import "CouierProfileDetailView.h"


@interface CouiserDetailViewController ()

@property (nonatomic,strong) UIImageView *couierAvaterImageView;

@property (nonatomic,strong) CouierProfileDetailView *couierProfileView;

@end

@implementation CouiserDetailViewController

- (CouierProfileDetailView*)couierProfileView {
    if (!_couierProfileView) {
        _couierProfileView = [[[NSBundle mainBundle]loadNibNamed:@"CouierProfileDetailView" owner:self options:nil]objectAtIndex:0];
        _couierProfileView.frame = CGRectMake(5, CGRectGetMaxY(self.couierAvaterImageView.frame) - 20, SCRE_WIDTH - 10, 135);
        _couierProfileView.layer.cornerRadius = 2;
        _couierProfileView.layer.masksToBounds = YES;
        _couierProfileView.layer.shadowColor = [UIColor grayColor].CGColor;
        _couierProfileView.layer.shadowOffset = CGSizeMake(5, 5);
        _couierProfileView.layer.shadowRadius = 10;
        _couierProfileView.layer.shadowOpacity = 0.6;
        _couierProfileView.layer.borderColor = [UIColor grayColor].CGColor;
        _couierProfileView.layer.borderWidth = 1.0;
        
    }
    return _couierProfileView;
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
    self.title = @"快递员主页";
    self.view.backgroundColor = [UIColor whiteColor];
    self.couierAvaterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCRE_WIDTH, 120)];
    _couierAvaterImageView.image = [UIImage imageNamed:@"touxiang"];
//    [_couierAvaterImageView sizeToFit];
    [self.view addSubview:_couierAvaterImageView];
    
    UIView *viewL = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_couierAvaterImageView.frame), SCRE_WIDTH, 5)];
    viewL.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:76.0/255.0 blue:27.0/255.0 alpha:1];
    [self.view addSubview:viewL];
    [self.view addSubview:self.couierProfileView];
}


@end

//
//  SearchExpressViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/1.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "SearchExpressViewController.h"
#import "LBXScanView.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"
#import "ScanBarCodeViewController.h"
#import "UIScanTextField.h"
#import "ChooseFactoryTableViewController.h"

@interface SearchExpressViewController () <UITextFieldDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIScanTextField *expressNumberTextField;

@property (nonatomic,strong)UITextField *chooseExpressType;

@property (nonatomic,strong) UIButton *submitButton;
@end

@implementation SearchExpressViewController


#pragma mark lazy load
-(UIScanTextField *)expressNumberTextField {
    if (!_expressNumberTextField) {
        _expressNumberTextField = [[UIScanTextField alloc]initWithFrame:CGRectMake(20, 100, SCRE_WIDTH - 40, 40)];
        [_expressNumberTextField.cameraScanButton addTarget:self action:@selector(cameraScanAction) forControlEvents:UIControlEventTouchDown];
        _expressNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_expressNumberTextField setBackground:[UIImage imageNamed:@"ver_phone_phone_text"]];
        _expressNumberTextField.delegate = self;
        _expressNumberTextField.tag = 10;
        [[UITextField appearance] setTintColor:[UIColor orangeColor]];
    }
    return _expressNumberTextField;
}

-(UITextField *)chooseExpressType {
    if (!_chooseExpressType) {
        _chooseExpressType = [[UITextField alloc]init];
        _chooseExpressType.frame = CGRectMake(20, 150, SCRE_WIDTH - 40, 40);
        [_chooseExpressType setBackground:[UIImage imageNamed:@"ver_phone_phone_text"]];
        _chooseExpressType.delegate = self;
        _chooseExpressType.tag = 20;
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        rightView.backgroundColor = [UIColor clearColor];
        UIImageView *chooseExLeftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 5, 10, 20)];
        [rightView addSubview:chooseExLeftImageView];
        [[UITextField appearance] setTintColor:[UIColor orangeColor]];
        chooseExLeftImageView.image = [UIImage imageNamed:@"iconfont-gengduo"];
        _chooseExpressType.rightViewMode = UITextFieldViewModeAlways;
        _chooseExpressType.rightView = rightView;
        _chooseExpressType.font = [UIFont systemFontOfSize:13];
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        leftView.backgroundColor = [UIColor clearColor];
        UIImageView *chooseExRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 40, 20)];
        [leftView addSubview:chooseExRightImageView];
        chooseExRightImageView.image = [UIImage imageNamed:@"iconfont-kuaidi"];
        [chooseExRightImageView sizeToFit];
        _chooseExpressType.leftView = leftView;
        _chooseExpressType.leftViewMode = UITextFieldViewModeAlways;
        
        _chooseExpressType.placeholder = @"请选择快递公司";
    }
    return _chooseExpressType;
}

#pragma mark 系统加载项
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark init初始化
- (void)initView {
    self.view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:241.0/255.0 blue:235.0/255.0 alpha:1];
    self.title = @"查快递";
    [self.view addSubview:self.expressNumberTextField];
    if (_strScan) {
        _expressNumberTextField.text = _strScan;
    }
    [self.view addSubview:self.chooseExpressType];
    
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 74, SCRE_WIDTH, 20)];
    promptLabel.text = @"手动输入单号更精准查快递";
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont systemFontOfSize:12];
    promptLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.8];
    [self.view addSubview:promptLabel];
    
    self.submitButton = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_chooseExpressType.frame) + 10, SCRE_WIDTH - 40, 40)];//43 167 13
    [_submitButton setBackgroundColor:[UIColor colorWithRed:43.0/255.0 green:167.0/255.0 blue:13/255.0 alpha:1]];
    _submitButton.layer.cornerRadius = 5;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_submitButton];
    self.navigationController.delegate = self;
}


#pragma mark - custom function
- (void)notSquare
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 4;
    style.photoframeAngleW = 28;
    style.photoframeAngleH = 16;
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_LineStill;
    
    
    style.animationImage = [self createImageWithColor:[UIColor redColor]];
    //非正方形
    //设置矩形宽高比
    style.whRatio = 4.3/2.18;
    
    //离左边和右边距离
    style.xScanRetangleOffset = 30;
    
    
    
    [self openScanVCWithStyle:style];
}


- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    ScanBarCodeViewController *vc = [ScanBarCodeViewController new];
    vc.style = style;
    //vc.isOpenInterestRect = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 事件响应 action
//相机扫描按钮
- (void)cameraScanAction {
    [self notSquare];
    
}

//确定
- (void)submitAction {
    
}

#pragma mark  UITextFieldDelegate 输入框代理
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField setBackground:[UIImage imageNamed:@"ver_phone_phone_text_hight"]];
    if (textField.tag == 10) {
        
        
    } else if (textField.tag == 20) {
        [self.navigationController pushViewController:[[ChooseFactoryTableViewController alloc] init] animated:YES];
    }
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField setBackground:[UIImage imageNamed:@"ver_phone_phone_text"]];
    return YES;
}

#pragma mark  UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //注销选择快递公司为第一响应者
    [_chooseExpressType resignFirstResponder];
}

@end

//
//  LogiHomeViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/3.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "LoginHomeViewController.h"
#import "UIBarButtonItem+GFBarButtonItem.h"
#import "UIView+Extend.h"

@interface LoginHomeViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *phoneNumberTextField;

@property (nonatomic,strong) UITextField *verificationCodeTextField;

@property (nonatomic,strong) UIButton *getVerificationCodeButton;

@property (nonatomic,strong) UIButton *okayButton;

/**
 *  法律声明
 */
@property (nonatomic,strong) UIButton *legalNoticesButton;

@end

@implementation LoginHomeViewController


#pragma mark lazy load

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initView {
    self.title = @"验证手机";
    
    UILabel *hintUserVerifyLabel = [[UILabel alloc]init];
    hintUserVerifyLabel.text = @"为方便快递员联系您,请验证手机";
    hintUserVerifyLabel.textAlignment = NSTextAlignmentCenter;
    hintUserVerifyLabel.font = [UIFont systemFontOfSize:12];
    hintUserVerifyLabel.textColor = [UIColor colorWithWhite:0 alpha:0.5];
    hintUserVerifyLabel.size = CGSizeMake(SCRE_WIDTH, 20);
    hintUserVerifyLabel.x = 0;
    hintUserVerifyLabel.y = 84;
    [self.view addSubview:hintUserVerifyLabel];
    
    self.phoneNumberTextField = [[UITextField alloc]init];
    _phoneNumberTextField.frame = CGRectMake(20.0, CGRectGetMaxY(hintUserVerifyLabel.frame) + 10, SCRE_WIDTH - 120, 40);
    _phoneNumberTextField.placeholder = @" 手机号";
    _phoneNumberTextField.background = [UIImage imageNamed:@"ver_phone_phone_text"];
    _phoneNumberTextField.tag = 10;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 50)];
    leftView.backgroundColor = [UIColor clearColor];
    _phoneNumberTextField.leftView = leftView;
    _phoneNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumberTextField.delegate = self;
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    [[UITextField appearance] setTintColor:[UIColor orangeColor]];
    [self.view addSubview:_phoneNumberTextField];
    
    self.getVerificationCodeButton = [[UIButton alloc]init];
    _getVerificationCodeButton.frame = CGRectMake(CGRectGetMaxX(_phoneNumberTextField.frame) + 10, CGRectGetMinY(_phoneNumberTextField.frame), 70, 40);
    _getVerificationCodeButton.layer.cornerRadius = 5;
    _getVerificationCodeButton.layer.masksToBounds = YES;
    [_getVerificationCodeButton setTitle:@"验证" forState:UIControlStateNormal];
    [_getVerificationCodeButton setBackgroundImage:[UIImage imageNamed:@"ver_get_ver_button_hight"] forState:UIControlStateSelected];
    [_getVerificationCodeButton setBackgroundImage:[UIImage imageNamed:@"ver_get_ver_button"] forState:UIControlStateNormal];
    [_getVerificationCodeButton addTarget:self action:@selector(getVerificationCodeAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_getVerificationCodeButton];
    
    self.verificationCodeTextField = [[UITextField alloc]init];
    _verificationCodeTextField.frame = CGRectMake(20.0, CGRectGetMaxY(_phoneNumberTextField.frame) + 10, SCRE_WIDTH - 40, 40);
    _verificationCodeTextField.placeholder = @" 验证码";
    _verificationCodeTextField.background = [UIImage imageNamed:@"ver_phone_phone_text"];
    _verificationCodeTextField.tag = 10;
    _verificationCodeTextField.delegate = self;
     _verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    UIView *verLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 50)];
    leftView.backgroundColor = [UIColor clearColor];
    _verificationCodeTextField.leftView = verLeftView;
    _verificationCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_verificationCodeTextField];
    
    self.okayButton = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_verificationCodeTextField.frame) + 10, SCRE_WIDTH - 40, 40)];
    [_okayButton setTitle:@"确定" forState:UIControlStateNormal];
    _okayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _okayButton.layer.cornerRadius = 5;
    _okayButton.layer.masksToBounds = YES;
    [_okayButton setBackgroundImage:[UIImage imageNamed:@"ver_get_ver_button"] forState:UIControlStateNormal];
    [_okayButton setBackgroundImage:[UIImage imageNamed:@"ver_get_ver_button_hight"] forState:UIControlStateDisabled];
    [_okayButton setBackgroundImage:[UIImage imageNamed:@"ver_get_ver_button_hight"] forState:UIControlStateSelected];
    [_okayButton addTarget:self action:@selector(okayForLoginAction) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:_okayButton];
    [self initLegalNotices];
}




#pragma mark -function自定义函数

- (void)friendsearch {
    
}

//设置法律声明和隐私政策
- (void)initLegalNotices {
    UILabel *noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.okayButton.frame) + 10, 140, 20)];
    noticeLabel.textAlignment = NSTextAlignmentLeft;
    noticeLabel.text = @"点击-确定,即表示您接受";
    noticeLabel.font = [UIFont systemFontOfSize:13];
    noticeLabel.textColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:noticeLabel];
    
    self.legalNoticesButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noticeLabel.frame) , CGRectGetMinY(noticeLabel.frame), 140, 20)];
    _legalNoticesButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_legalNoticesButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_legalNoticesButton setTitle: @"《法律声明及隐私政策》" forState:UIControlStateNormal];
    [_legalNoticesButton addTarget:self action:@selector(pushToLegalNoticesPage) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_legalNoticesButton];
    
}


#pragma mark action - 事件响应
- (void)getVerificationCodeAction:(UIButton*)sender {
    
}

- (void)okayForLoginAction {
    
}

- (void)pushToLegalNoticesPage {
    
}


#pragma mark - UITextFieldDelegate delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.background = [UIImage imageNamed:@"ver_phone_phone_text_hight"];
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    textField.background = [UIImage imageNamed:@"ver_phone_phone_text"];
}
@end

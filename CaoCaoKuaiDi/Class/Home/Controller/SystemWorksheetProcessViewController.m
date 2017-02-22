//
//  SystemWorksheetProcessViewController.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/7.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "SystemWorksheetProcessViewController.h"
#import "ExpressOfUpDoorView.h"
#import "UIView+Extend.h"
#import "PayPageViewController.h"
#import "CouiserDetailViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface SystemWorksheetProcessViewController ()<MAMapViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) MAMapView *mapView;

@property (nonatomic,strong) ExpressOfUpDoorView *expressOfUpDoorView;

@property (nonatomic,strong) UIView *remarksView;

@property (nonatomic,strong) UIButton* remarksInfoButton;

@property (nonatomic,strong) NSMutableArray *remarkTitleArray;

@property (nonatomic,strong) UIButton *submitButton;

@property (nonatomic,strong) UITextField *supplementRemarksTextField;
/**
 *  备注button
 */
@property (nonatomic,strong) UIButton *remarkButton;
/**
 *  催单
 */
@property (nonatomic,strong) UIButton *reminderButton;

@end

@implementation SystemWorksheetProcessViewController

-(MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, SCRE_WIDTH, SCRE_HEIGHT - 64)];
        _mapView.delegate = self;
        _mapView.mapType = MAMapTypeStandard;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.showsCompass = NO;
        _mapView.showsScale = NO;
    }
    return _mapView;
}

- (ExpressOfUpDoorView*)expressOfUpDoorView {
    if (!_expressOfUpDoorView) {
        _expressOfUpDoorView = [[[NSBundle mainBundle]loadNibNamed:@"ExpressOfUpDoorView" owner:self options:nil]objectAtIndex:0];
        _expressOfUpDoorView.frame = CGRectMake(0, 64, SCRE_WIDTH, 110);
        //备注和催单的蒙版
        UIView *remarkAndReminMarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCRE_WIDTH, 45)];
        remarkAndReminMarkView.backgroundColor = [UIColor grayColor];
        [_expressOfUpDoorView addSubview:remarkAndReminMarkView];
        self.remarkButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCRE_WIDTH/2 - 1, 45)];
        [_remarkButton setBackgroundColor:[UIColor whiteColor]];
        [_remarkButton setImage:[UIImage imageNamed:@"up_door_beizhu_button"] forState:UIControlStateNormal];
        [_remarkButton addTarget:self action:@selector(remarksAction:) forControlEvents:UIControlEventTouchDown];
        [remarkAndReminMarkView addSubview:_remarkButton];
        
        self.reminderButton = [[UIButton alloc] initWithFrame:CGRectMake(SCRE_WIDTH/2, 0, SCRE_WIDTH/2, 45)];
        [_reminderButton setBackgroundColor:[UIColor whiteColor]];
        [_reminderButton setImage:[UIImage imageNamed:@"up_door_cuidan_button"] forState:UIControlStateNormal];
        [_reminderButton addTarget:self action:@selector(reminderAction:) forControlEvents:UIControlEventTouchDown];
        [remarkAndReminMarkView addSubview:_reminderButton];
        
        [_expressOfUpDoorView.callCouierBtn addTarget:self action:@selector(callCouierAction) forControlEvents:UIControlEventTouchDown];
         [_expressOfUpDoorView.couierHistoryOrders addTarget:self action:@selector(couierHistoryOrdersAction) forControlEvents:UIControlEventTouchDown];
        self.remarksView.frame = CGRectMake(0, -40, SCRE_WIDTH, 100);
        [self.view addSubview:_remarksView];
        [self initRemarksView];
    }
    return _expressOfUpDoorView;
}

-(UIView *)remarksView {
    if (!_remarksView) {
        _remarksView = [[UIView alloc]init];
        _remarksView.backgroundColor = [UIColor whiteColor];
    }
    return _remarksView;
}

-(NSMutableArray *)remarkTitleArray {
    if (!_remarkTitleArray) {
        _remarkTitleArray = [NSMutableArray array];
        _remarkTitleArray = [@[
                               @"大件物品",
                               @"比较多件",
                               @"需要打包",
                               @"易碎品",
                               @"液体类",
                               @"数码类",
                               @"食品类",
                               @"更多",
                               ] mutableCopy];
    }
    return _remarkTitleArray;
}

-(UITextField *)supplementRemarksTextField {
    if (!_supplementRemarksTextField) {
        _supplementRemarksTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, -30, SCRE_WIDTH - 60, 30)];
        [_supplementRemarksTextField setBackground:[UIImage imageNamed:@"ver_phone_phone_text"]];
        _supplementRemarksTextField.layer.cornerRadius = 5.0f;
        _supplementRemarksTextField.layer.masksToBounds = YES;
        _supplementRemarksTextField.delegate = self;
        _supplementRemarksTextField.placeholder = @"请补充备注";
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
        leftView.backgroundColor = [UIColor clearColor];
        _supplementRemarksTextField.leftView = leftView;
        _supplementRemarksTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [[UITextField appearance]setTintColor:[UIColor orangeColor]];
        _supplementRemarksTextField.font  = [UIFont systemFontOfSize:14];
        
        
    }
    return _supplementRemarksTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
   
    [self.view addSubview:self.expressOfUpDoorView];
    // Do any additional setup after loading the view.
}



#pragma mark -initView
- (void)initView {
    self.title = @"系统派单中";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mapView];
}

- (void)initRemarksView {
    
    for (int i = 0; i < 4; i++) {
        self.remarksInfoButton = [[UIButton alloc]init];
        _remarksInfoButton.frame = CGRectMake( (SCRE_WIDTH - 240) * (i + 1)/5 +60 * i , 15, 60, 15);
        _remarksInfoButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _remarksInfoButton.tag = 10 + i;
        _remarksInfoButton.layer.cornerRadius = 8;
        _remarksInfoButton.layer.borderWidth = 0.5;
        _remarksInfoButton.layer.borderColor = [UIColor grayColor].CGColor;
        [_remarksInfoButton setTitle:self.remarkTitleArray[i] forState:UIControlStateNormal];
        [_remarksInfoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _remarksInfoButton.layer.masksToBounds = YES;
        [_remarksInfoButton addTarget:self action:@selector(remarksInfoAction:) forControlEvents:UIControlEventTouchDown];
        [_remarksView addSubview:_remarksInfoButton];
    }
    
    for (int i = 0; i < 4; i++) {
        self.remarksInfoButton = [[UIButton alloc]init];
        _remarksInfoButton.frame = CGRectMake( (SCRE_WIDTH - 240) * (i + 1)/5 +60 * i , 40, 60, 15);
        _remarksInfoButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _remarksInfoButton.tag = 20 + i;
        _remarksInfoButton.layer.borderWidth = 0.5;
        _remarksInfoButton.layer.borderColor = [UIColor grayColor].CGColor;
        _remarksInfoButton.layer.cornerRadius = 8;
        [_remarksInfoButton setTitle:self.remarkTitleArray[i + 4] forState:UIControlStateNormal];
        [_remarksInfoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _remarksInfoButton.layer.masksToBounds = YES;
        [_remarksInfoButton addTarget:self action:@selector(remarksInfoAction:) forControlEvents:UIControlEventTouchDown];
        [_remarksView addSubview:_remarksInfoButton];
    }
    self.submitButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 65, SCRE_WIDTH - 100, 30)];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _submitButton.layer.cornerRadius = 5.0f;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchDown];
    [_submitButton setBackgroundColor:[UIColor colorWithRed:43.0/255 green:167.0/255.0 blue:13.0/255.0 alpha:1]];
    [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [_remarksView addSubview:_submitButton];
    [_remarksView addSubview:self.supplementRemarksTextField];
}
#pragma mark custom function 

//有快递员接单时。弹窗
- (void)couierGetTheOrder {
    
}


#pragma mark action事件响应
//点击备注时
- (void)remarksAction:(UIButton *)sender {
    sender.selected = YES;
    sender.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:246.0/255.0 blue:1 alpha:1 ];
    if (sender.height == 45 ) {
        sender.height -= 1;
    }
    if (_reminderButton.selected) {
        _reminderButton.backgroundColor = [UIColor whiteColor];
        if (sender.height == 44 ) {
            sender.height += 1;
        }
    }
    if (_remarksView.height == 100) {
        [UIView animateWithDuration:0.7 animations:^{
            _remarksView.frame = CGRectMake(0, 164, SCRE_WIDTH, 100);
        }];
    } else if(_remarksView.height == 140) {
        [UIView animateWithDuration:0.7 animations:^{
            _remarksView.frame = CGRectMake(0, 164, SCRE_WIDTH, 140);
        }];
    }
    
}


- (void)callCouierAction {

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要打电话给\n18814184180" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alertView show];
}

//点击催单时
- (void)reminderAction:(UIButton *)sender {
    sender.selected = YES;
    if (sender.height == 45 ) {
        sender.height -= 1;
    }
    
    sender.backgroundColor = [UIColor orangeColor];
    
    if (_remarkButton.selected) {
        _remarkButton.backgroundColor = [UIColor whiteColor];
        if (sender.height == 44 ) {
            sender.height += 1;
        }
    }
}

- (void)remarksInfoAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.tag == 23) {
        if (sender.selected) {
            [UIView animateWithDuration:0.5 animations:^{
                _submitButton.y += 40;
               _remarksView.height += 40;
                _supplementRemarksTextField.y += 100;
            }];
            
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                _remarksView.height -= 40;
                _submitButton.y -= 40;
                _supplementRemarksTextField.y -= 100;
            }];
        }
        
    } else {
        if (sender.selected) {
            sender.backgroundColor = [UIColor orangeColor];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }

}

- (void)submitAction:(UIButton *)sender {
    [UIView animateWithDuration:0.7 animations:^{
        _remarksView.y -= 140;
    }];
    [self.navigationController pushViewController:[PayPageViewController new] animated:YES];
}
//进入快递员首页
- (void)couierHistoryOrdersAction {
    [self.navigationController pushViewController:[CouiserDetailViewController new] animated:YES];
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField setBackground:[UIImage imageNamed:@"ver_phone_phone_text_hight"]];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField setBackground:[UIImage imageNamed:@"ver_phone_phone_text"]];
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18814184180"]];
    } else {
        
    }
}
@end









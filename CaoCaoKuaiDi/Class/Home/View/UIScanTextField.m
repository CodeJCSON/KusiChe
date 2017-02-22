//
//  UIScanTextField.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/1.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "UIScanTextField.h"
#import "UIImage+GFImage.h"
#import "ScanBarCodeViewController.h"

@implementation UIScanTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        UITextField *searchBarTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 35)];
        self.placeholder = @"请输入单号";
        self.font = [UIFont systemFontOfSize:13];
        self.alpha = 0.8;
        [self setBackground:[UIImage imageWithStretchableName:@"searchbar_textfield_background"]];
        
        self.cameraScanButton = [[UIButton alloc]init];
        _cameraScanButton.frame = CGRectMake(0, 0, 30, 25);
        _cameraScanButton.contentMode = UIViewContentModeCenter;
        [_cameraScanButton setImage:[UIImage imageNamed:@"iconfont-xiangji"] forState:UIControlStateNormal];
        UIView *expressTextLeftView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 40, 40)];
        expressTextLeftView.backgroundColor = [UIColor clearColor];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = expressTextLeftView;
        
        self.rightView = _cameraScanButton;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

#pragma mark action


@end

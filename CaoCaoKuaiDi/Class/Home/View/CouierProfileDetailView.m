//
//  CouierProfileDetailView.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/10.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "CouierProfileDetailView.h"

@interface CouierProfileDetailView()
/**
 *  快递类型 和 快递姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *expressTypeCouierName;
/**
 *  认证与否
 */
@property (weak, nonatomic) IBOutlet UILabel *AuthenticationLabel;
/**
 *  星级view
 */
@property (weak, nonatomic) IBOutlet UIView *starLevelvIEW;
/**
 *  星级level number
 */
@property (weak, nonatomic) IBOutlet UILabel *starLevelNumberLabel;
/**
 *  快递员工号
 */
@property (weak, nonatomic) IBOutlet UILabel *jobNumberLabel;
/**
 *  快递员身份证
 */
@property (weak, nonatomic) IBOutlet UILabel *couierIDcard;
/**
 *  快递类型imageview
 */
@property (weak, nonatomic) IBOutlet UIImageView *expressTypeImageView;

/**
 *  成交量
 */
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;

/**
 *  服务次数
 */
@property (weak, nonatomic) IBOutlet UILabel *searviceTimes;

@end


@implementation CouierProfileDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)layoutSubviews {
    _AuthenticationLabel.layer.cornerRadius = 5;
    _AuthenticationLabel.layer.masksToBounds = YES;
    /**
     *  判断认证
     */
    if ([self.authenticationOrNo  isEqual: @"0"]) {
        _AuthenticationLabel.text = @"认证";
        
    } else {
        _AuthenticationLabel.text = @"未认证";
    }
    _starLevelNumberLabel.text = [NSString stringWithFormat:@"%f",self.starLevelNumber];
    _expressTypeCouierName.text = [NSString stringWithFormat:@"%@  %@",self.couierName,self.expressTypeName];
    _couierIDcard.text = self.couierIDcardString;
    _jobNumberLabel.text = self.jobNumberString;
}

@end

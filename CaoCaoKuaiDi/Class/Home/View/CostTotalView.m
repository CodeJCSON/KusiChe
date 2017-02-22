//
//  CostTotalView.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/9.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "CostTotalView.h"


@implementation CostTotalView

@synthesize discountJuanLabel;

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
        self.discountJuanLabel.text = [NSString stringWithFormat:@"已使用优惠劵抵扣%@元",self.deductionMoey];
        self.expressTotalMoneyLabel.text = @"0";
    }
    return self;
}

@end

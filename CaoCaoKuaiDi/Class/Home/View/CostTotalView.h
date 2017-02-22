//
//  CostTotalView.h
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/9.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostTotalView : UIView
/**
 *  优惠券抵扣label
 */
@property (weak, nonatomic) IBOutlet UILabel *discountJuanLabel;

/**
 *  快递总金额
 */
@property (weak, nonatomic) IBOutlet UILabel *expressTotalMoneyLabel;
/**
 *  抵扣金额
 */
@property (nonatomic,copy) NSString *deductionMoey;
@end

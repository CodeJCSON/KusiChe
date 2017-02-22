//
//  CouierProfileDetailView.h
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/10.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouierProfileDetailView : UIView
/**
 *  快递类型名starLevelNumber
 */
@property (nonatomic,copy) NSString *expressTypeName;
/**
 *  快递员名称
 */
@property (nonatomic,copy) NSString *couierName;
/**
 *  认证与否 0 - 已认证 1 - 未认证
 */
@property (nonatomic,copy) NSString *authenticationOrNo;
/**
 *  星级number（cgfloat）
 */
@property (nonatomic,assign) CGFloat starLevelNumber;
/**
 *  快递员工号
 */
@property (nonatomic,copy) NSString *jobNumberString;
/**
 *  快递员身份证
 */
@property (nonatomic,copy) NSString *couierIDcardString;
/**
 *  成交量次数
 */
@property (nonatomic,copy) NSString *volumeNumber;
/**
 *  服务次数
 */
@property (nonatomic,copy) NSString *serviceTimesNumber;


@end

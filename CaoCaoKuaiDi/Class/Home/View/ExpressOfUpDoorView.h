//
//  ExpressOfUpDoorView.h
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/8.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressOfUpDoorView : UIView

/**
 *  快递员头像
 */
@property (nonatomic,strong) UIImage *couierImage;
/**
 *  快递类型 string
 */
@property (nonatomic,strong) NSString *expressTypeString;
/**
 *  快递员名称
 */
@property (nonatomic,strong) NSString *couierName;
/**
 *  认证与否
 */
@property (nonatomic,copy) NSString *AuthenticationOrNo;
/**
 *  快递员星级number
 */
@property (nonatomic,assign) CGFloat couiserStarNumber;
/**
 *  快递员接单量 string
 */
@property (nonatomic,copy)NSString *couierVolumeOfOrders;

/**
 *  呼叫快递员button
 */
@property (weak, nonatomic) IBOutlet UIButton *callCouierBtn;
/**
 *  快递员接单量 button
 */
@property (weak, nonatomic) IBOutlet UIButton *couierHistoryOrders;

@end

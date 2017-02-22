//
//  PaySuccessAndCommentView.h
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/10.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaySuccessAndCommentView : UIView
/**
 *   快递明细button
 */
@property (weak, nonatomic) IBOutlet UIButton *expressDetailButton;
/**
 *  支付金额label
 */
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;
/**
 *  第一个星星按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *starFirstButton;
/**
 *  第2个星星按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *starSecondButton;
/**
 *  第3个星星按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *starThirdButton;
/**
 *  第4个星星按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *starForthButton;
/**
 *  第5个星星按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *starFiveButton;

@end

//
//  ExpressSimpleTableViewCell.h
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/9.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressSimpleTableViewCell : UITableViewCell
/**
 *  快递号码
 */
@property (nonatomic,copy) NSString *expressNumberString;
/**
 *  快递号码label
 */
@property (weak, nonatomic) IBOutlet UILabel *expressNumberLabel;

@end

//
//  ExpressOfUpDoorView.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/8.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "ExpressOfUpDoorView.h"

@interface ExpressOfUpDoorView()
/**
 *  快递员头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *epressAvaterImageView;
/**
 *  快递员积分
 */
@property (weak, nonatomic) IBOutlet UILabel *expressScore;
/**
 *  快递员用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *expresNameLabel;
/**
 *  快递类型label
 */
@property (weak, nonatomic) IBOutlet UILabel *expressTypeLabel;

/**
 *  快递员类型图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *expressTypeImageView;

/**
 *  快递员认证图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *couierAuthenticationImageView;
/**
 *  快递员历史接单量
 */

@property (weak, nonatomic) IBOutlet UILabel *couierHistoryNumber;
/**
 *  快递员星级
 */

@property (weak, nonatomic) IBOutlet UIView *couierStarLevelView;

@end

@implementation ExpressOfUpDoorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(void)layoutSubviews {
//    self.backgroundColor = [UIColor redColor];
}

@end

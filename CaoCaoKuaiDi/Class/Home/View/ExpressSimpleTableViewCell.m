//
//  ExpressSimpleTableViewCell.m
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/9.
//  Copyright © 2016年 goofyy. All rights reserved.
//

#import "ExpressSimpleTableViewCell.h"

@implementation ExpressSimpleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.expressNumberLabel.text = self.expressNumberString;
    // Configure the view for the selected state
}

@end

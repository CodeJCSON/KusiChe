//
//  CustomCalloutView.m
//  HelloAmap
//
//  Created by xiaoming han on 14-10-21.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "CustomCalloutView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Extend.h"

#define kArrorHeight        10

#define kPortraitMargin     5
#define kPortraitWidth      70
#define kPortraitHeight     50

#define kTitleWidth         120
#define kTitleHeight        20


@interface CustomCalloutView ()

@end

@implementation CustomCalloutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    
    UILabel *labelFirst = [[UILabel alloc]initWithFrame:CGRectMake(2, 5, 20, 30)];
    labelFirst.text = @"从";
    labelFirst.font = [UIFont systemFontOfSize:15];
    labelFirst.textColor = [UIColor grayColor];
    [self addSubview:labelFirst];
    
    self.completeAdressBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelFirst.frame) - 5, 5, 70, 30)];
    _completeAdressBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_completeAdressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [_completeAdressBtn setTitleColor:[UIColor colorWithRed:67.0/255.0 green:161.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
    [self addSubview:_completeAdressBtn];
    
    UILabel *labelSecond = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_completeAdressBtn.frame), 5, 30, 30)];
    labelSecond.text = @"收件";
    labelSecond.font = [UIFont systemFontOfSize:15];
    labelSecond.textColor = [UIColor grayColor];
    [self addSubview:labelSecond];
    
    UIBezierPath *straightLineBe = [UIBezierPath bezierPath];
    [straightLineBe moveToPoint:CGPointMake(CGRectGetMaxX(labelSecond.frame) + 5, 5)];
    [straightLineBe addLineToPoint:CGPointMake(CGRectGetMaxX(labelSecond.frame) + 5, 35)];
    
    CAShapeLayer *shaperLayer = [[CAShapeLayer alloc]init];
    shaperLayer.strokeColor = [[UIColor blackColor]CGColor];
    shaperLayer.lineWidth = 0.2f;
    shaperLayer.path = straightLineBe.CGPath;
    [self.layer addSublayer:shaperLayer];
    
    self.recommendExpressLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetMaxX(labelSecond.frame) + 10), 5, 80, 30)];
    _recommendExpressLabel.textColor = [UIColor grayColor];
    _recommendExpressLabel.text = @"推荐圆通";
    _recommendExpressLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_recommendExpressLabel];
    
    self.tuanORkuanBtn = [[UIButton alloc]initWithFrame:CGRectMake(250 - 40, -5, 50, 50)];
    [_tuanORkuanBtn setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    _tuanORkuanBtn.layer.cornerRadius = _tuanORkuanBtn.width/2;
    _tuanORkuanBtn.layer.masksToBounds = YES;
    [self addSubview:_tuanORkuanBtn];
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end

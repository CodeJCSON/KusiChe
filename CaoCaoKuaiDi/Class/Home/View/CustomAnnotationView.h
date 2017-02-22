//
//  CustomAnnotationView.h
//  CaoCaoKuaiDi
//
//  Created by goofygao on 16/3/1.
//  Copyright © 2016年 goofyy. All rights reserved.
//


#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, strong) CustomCalloutView *calloutView;

@end

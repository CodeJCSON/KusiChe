//
//  UIColor+GFImage.h
//  GFSinaWeiBo
//
//  Created by goofygao on 15/12/15.
//  Copyright © 2015年 goofyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GFImage)

+(instancetype)imageWithOriginImage:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end

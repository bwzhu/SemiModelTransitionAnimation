//
//  UIColor+Random.m
//  SemiModelTransition
//
//  Created by ZhaoWei on 15/7/22.
//  Copyright (c) 2015年 csdept. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)randomColor
{
    NSInteger red, green, blue;
    red = arc4random() % 256;
    green = arc4random() % 256;
    blue = arc4random() % 256;
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0  alpha:1];
}
@end

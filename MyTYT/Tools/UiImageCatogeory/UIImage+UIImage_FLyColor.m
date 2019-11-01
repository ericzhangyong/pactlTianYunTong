//
//  UIImage+UIImage_FLyColor.m
//  HWZYBZT
//
//  Created by 张飞飞 on 2017/5/24.
//  Copyright © 2017年 张飞飞. All rights reserved.
//

#import "UIImage+UIImage_FLyColor.h"

@implementation UIImage (UIImage_FLyColor)

+ (UIImage *)imageWithColor:(UIColor *)color{
 
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;

}

@end

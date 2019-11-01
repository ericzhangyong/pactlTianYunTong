//
//  MBProgressHUD+FLyHUD.h
//  线程
//
//  Created by 张飞飞 on 17/3/24.
//  Copyright © 2017年 张飞飞. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (FLyHUD)

///展示加载图
+ (void)showLoadView:(UIView *)view;
///展示加载图带有字
+ (void)showLoadView:(UIView *)view loadTitle:(NSString *)loadtitle;
///展示文字失败
+ (void)showErrorView:(UIView *)view errorTitle:(NSString *)errortitle;
///直接隐藏
+ (void)showSuccessView:(UIView *)view;
///直接隐藏
+ (void)showErrorView:(UIView *)view;
///展示成功有对号图片
+ (void)showSuccessView:(UIView *)view SuccessTitle:(NSString *)successTitle;
///展示文字自动隐藏
+ (void)showTextView:(UIView *)view textTitle:(NSString *)textTitle;
//／展示图片文字
+ (void)showImageView:(UIView *)view textTitle:(NSString *)textTitle;
//／展示图片文字
+ (void)showImageView:(UIView *)view textTitle:(NSString *)textTitle imagename:(NSString *)imagename;
//注册成功返回，view为nil展示在window上
///直接展示文字然后删

//展示时间长
+ (void)showMoreLongtext:(UIView *)view title:(NSString *)title;

//展示成功text颜色绿色
+ (void)showSuccessText:(UIView *)view title:(NSString *)title;

@end

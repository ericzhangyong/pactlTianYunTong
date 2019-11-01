//
//  MBProgressHUD+FLyHUD.m
//  线程
//
//  Created by 张飞飞 on 17/3/24.
//  Copyright © 2017年 张飞飞. All rights reserved.
//

#import "MBProgressHUD+FLyHUD.h"

@implementation MBProgressHUD (FLyHUD)

//单个加载图使用
+ (void)showLoadView:(UIView *)view{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    
}

//登陆带有文字指示图使用
+ (void)showLoadView:(UIView *)view loadTitle:(NSString *)loadtitle{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = loadtitle;
}

//网络加载失败文字提醒使用
+ (void)showErrorView:(UIView *)view errorTitle:(NSString *)errortitle{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    
    hud.bezelView.backgroundColor = [UIColor redColor];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.label.text = errortitle;
    
    [hud hideAnimated:YES afterDelay:2.5];
}

//登录成功直接隐藏
+ (void)showSuccessView:(UIView *)view{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    
    [hud hideAnimated:YES];
}
+ (void)showErrorView:(UIView *)view{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    
    [hud hideAnimated:YES];
    
}
//修改成功给予提示
+ (void)showSuccessView:(UIView *)view SuccessTitle:(NSString *)successTitle{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];

    hud.mode = MBProgressHUDModeCustomView;
    
    hud.bezelView.backgroundColor =[UIColor colorWithRed:0.235 green:0.463 blue:0.239 alpha:1.00];
    
    UIImage *image = [[UIImage imageNamed:@"MBProgress.bundle/Checkmark.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    
    hud.customView =imageview;
    
    hud.label.text = successTitle;
    
    [hud hideAnimated:YES afterDelay:2];
}

///直接展示文字然后删除
+ (void)showTextView:(UIView *)view textTitle:(NSString *)textTitle{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
 
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.bezelView.backgroundColor = [UIColor redColor];
    
    hud.label.text = textTitle;
    
    [hud hideAnimated:YES afterDelay:2];
}

//展示成功text颜色绿色
+ (void)showSuccessText:(UIView *)view title:(NSString *)title{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0.235 green:0.463 blue:0.239 alpha:1.00];
    
    hud.label.text = title;
    
    [hud hideAnimated:YES afterDelay:2];
}


+ (void)showImageView:(UIView *)view textTitle:(NSString *)textTitle{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"cacheimage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    
    hud.customView =imageview;
    
    hud.label.text = textTitle;
    
    [hud hideAnimated:YES afterDelay:1];

}


+ (void)showImageView:(UIView *)view textTitle:(NSString *)textTitle imagename:(NSString *)imagename{
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [[UIImage imageNamed:imagename] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    
    hud.customView =imageview;
    
    hud.label.text = textTitle;
    
    [hud hideAnimated:YES afterDelay:1.5];
    
}
#pragma mark------------------------------------------------------------------------------------
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
//       hud.square =YES;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0.235 green:0.463 blue:0.239 alpha:1.00];

    [hud hideAnimated:YES afterDelay:2.5];
    
    return hud;
}


+ (void)showMoreLongtext:(UIView *)view title:(NSString *)title{
    
    
    if (view==nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0.235 green:0.463 blue:0.239 alpha:1.00];
    hud.label.text = title;
    
    [hud hideAnimated:YES afterDelay:4];
}


@end

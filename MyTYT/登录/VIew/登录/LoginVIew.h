//
//  LoginVIew.h
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVIew : UIView

//上海图片
@property (nonatomic) UIImageView *imageview;

//天运通logo
@property (nonatomic) UIImageView *loginimageview;


//登录页面
@property (nonatomic) UIView *backView;

@property (nonatomic) UITextField *accountTextField;

@property (nonatomic) UITextField *passWordTextfiled;

@property (nonatomic) UIButton *loginBtn;


//验证码页面
@property (nonatomic) UIView *YZMBackView;

@property (nonatomic) UITextField *YzmTextFiled;

@property (nonatomic) UIButton *YZMBtn;


//选择类型页面
@property (nonatomic) UIView *selectView;

@property (nonatomic) UISegmentedControl *control;

//加载验证码
- (void)loadYZMImageWith:(UIImage *)image;

//改变验证码
- (void)changeYZMWithImage:(UIImage *)image;

@end

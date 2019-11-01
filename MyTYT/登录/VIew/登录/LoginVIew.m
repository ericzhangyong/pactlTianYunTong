//
//  LoginVIew.m
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LoginVIew.h"
#import "Masonry.h"
#import "UIImage+UIImage_FLyColor.h"

@implementation LoginVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self creatUI];
        
        [self layout];
    }
    return self;
}

- (void)loadYZMImageWith:(UIImage *)image{
    
    [self.YZMBackView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
    }];
    
    [self.YZMBtn setImage:image forState:UIControlStateNormal];
    
    [self setNeedsUpdateConstraints];
    
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

//改变验证码
- (void)changeYZMWithImage:(UIImage *)image{
    [self.YZMBtn setImage:image forState:UIControlStateNormal];
    
}

- (void)creatUI{
    
    
    
    [self addSubview:self.imageview];
    
    [self addSubview:self.loginimageview];
    
    [self addSubview:self.YZMBackView];
    
    [self addSubview:self.backView];
    
    [self.backView addSubview:self.accountTextField];
    
    [self.backView addSubview:self.passWordTextfiled];
    
    [self.backView addSubview:self.loginBtn];
    
    if (testInteacher ==1) {
        [self addSubview:self.selectView];
    }
    
}

- (void)layout{
    
    CGFloat leftPad = self.frame.size.width *0.25;
    
    [_YZMBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-50);
        make.width.equalTo(self).multipliedBy(0.5);
        make.left.equalTo(self).offset(leftPad);
        make.height.equalTo(@0);
    }];
    
    [_YzmTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountTextField);
        make.right.equalTo(self.accountTextField.mas_centerX);
        make.top.equalTo(self.YZMBackView);
        make.height.greaterThanOrEqualTo(@40).priorityLow();
        make.height.lessThanOrEqualTo(self.YZMBackView.mas_height);
    }];
    
    [_YZMBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passWordTextfiled);
        make.top.bottom.equalTo(self.YzmTextFiled);
        make.right.equalTo(self.passWordTextfiled.mas_centerX);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.YZMBackView);
        make.bottom.equalTo(self.YZMBackView.mas_top);
        make.height.equalTo(@90);
    }];
    
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(30);
        make.right.equalTo(self.passWordTextfiled.mas_left).offset(-15);
        make.width.equalTo(self.passWordTextfiled);
        make.top.equalTo(self.backView.mas_top).offset(20);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-20);
    }];
    
    [_passWordTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.accountTextField);
        make.right.equalTo(self.loginBtn.mas_left).offset(-20);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.passWordTextfiled);
        make.right.equalTo(self.backView).offset(-20);
        make.width.equalTo(@50);
    }];
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_loginimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-100);
        make.top.equalTo(self).offset(60);
        make.height.equalTo(@54);
        make.width.equalTo(@291);
    }];
    
    if (testInteacher == 1) {
        [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.backView.mas_top).offset(-20);
            make.height.equalTo(@50);
            make.width.equalTo(self).multipliedBy(0.4);
        }];
        
        [_control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.selectView);
        }];
    }
   
}

#pragma mark------------------------------------------------------------------------------------

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor =  loginColor;
    }
    return _backView;
}

- (UITextField *)accountTextField{
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.backgroundColor = [UIColor whiteColor];
        _accountTextField.placeholder = @"用户名";
        _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _accountTextField;
}

- (UITextField *)passWordTextfiled{
    if (!_passWordTextfiled) {
        _passWordTextfiled = [[UITextField alloc] init];
        _passWordTextfiled.backgroundColor = [UIColor whiteColor];
        _passWordTextfiled.borderStyle = UITextBorderStyleRoundedRect;
        _passWordTextfiled.secureTextEntry = YES;
        _passWordTextfiled.placeholder = @"密码";
    }
    return _passWordTextfiled;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
        _loginBtn.backgroundColor =[UIColor colorWithRed:0.816 green:0.906 blue:0.965 alpha:1.00];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 25;
        
    }
    return _loginBtn;
}

- (UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginimage"]];
    }
    return _imageview;
}

- (UIImageView *)loginimageview{
    if (!_loginimageview) {
        _loginimageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tytlogo"]];
    }
    return _loginimageview;
}

- (UIView *)YZMBackView{
    if (!_YZMBackView) {
        _YZMBackView = [[UIView alloc] init];
        _YZMBackView.backgroundColor =  loginColor;
        [_YZMBackView addSubview:self.YzmTextFiled];
        [_YZMBackView addSubview:self.YZMBtn];
        _YZMBackView.layer.masksToBounds = YES;
    }
    return _YZMBackView;
}


- (UITextField *)YzmTextFiled{
    if (!_YzmTextFiled) {
        _YzmTextFiled = [[UITextField alloc] init];
        _YzmTextFiled.backgroundColor = [UIColor whiteColor];
        _YzmTextFiled.placeholder = @"验证码";
        _YzmTextFiled.borderStyle = UITextBorderStyleRoundedRect;
        _YzmTextFiled.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return _YzmTextFiled;
}

- (UIButton *)YZMBtn{
    if (!_YZMBtn) {
        _YZMBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _YZMBtn.layer.cornerRadius = 6;
        _YZMBtn.layer.masksToBounds = YES;
    }
    return _YZMBtn;
}

- (UIView *)selectView{
    if (!_selectView) {
        _selectView = [[UIView alloc] init];
        _selectView.backgroundColor = [UIColor clearColor];
        [_selectView addSubview:self.control];
    }
    return _selectView;
}

- (UISegmentedControl *)control{
    if (!_control) {
        _control = [[UISegmentedControl alloc] initWithItems:@[@"测试外网",@"测试内网",@"生产外网",@"生产内网"]];
        [_control setSelectedSegmentIndex:0];
        _control.layer.masksToBounds = YES;
        _control.layer.cornerRadius = 5;
        [_control addTarget:self action:@selector(seleControlEvent:) forControlEvents:UIControlEventValueChanged];
        [_control setTitleTextAttributes:@{
                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                                           NSForegroundColorAttributeName:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00]

                                           } forState:UIControlStateNormal];
        
        [_control setTitleTextAttributes:@{
                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                           } forState:UIControlStateSelected];
  
        [_control setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
         [_control setBackgroundImage:[UIImage imageWithColor:NavColor] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [_control setDividerImage:[UIImage imageWithColor:NavColor] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    }
    return _control;
}

- (void)seleControlEvent:(UISegmentedControl *)conrole{
    
    switch (conrole.selectedSegmentIndex) {
        case 0://测试外网
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"http://chendejun00.gicp.net" forKey:BaseUrlPath];
        }
            break;
        case 1://测试内网
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"http://192.168.30.121" forKey:BaseUrlPath];

        }
            break;
        case 2://生产外网
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"https://www.easy-cargo.cn" forKey:BaseUrlPath];
        }
            break;
        case 3://生产内网
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"http://10.10.9.160" forKey:BaseUrlPath];
            
        }
            break;
            
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end


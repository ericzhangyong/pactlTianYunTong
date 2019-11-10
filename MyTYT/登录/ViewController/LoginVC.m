//
//  LoginVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LoginVC.h"
#import "LoginVIew.h"
#import "LoginNetViewModel.h"
#import "ShowUserAgreeVIew.h"
#import "SelectCheckTypeView.h"
#import "BaseNav.h"
#import "FirstVC.h"
#import "TwentyFourVC.h"
#import "BaseVC.h"
#import "MBProgressHUD+FLyHUD.h"
#import "AllModel.h"
#import "ProtocolModel.h"
#import "PerssionModel.h"
#import "MYTimer.h"
#import "LoginNeedNetViewModel.h"
#import "Masonry.h"
#import "NSString+JM.h"
#import "FLyAleartView.h"
#import "CheckVerSonModel.h"
#import "LoginModel.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic) LoginVIew *loginview;

@property (nonatomic) LoginNetViewModel *NetViewModle;

@property (nonatomic) LoginNeedNetViewModel *NeedNetViewModel;

@property (nonatomic) AllModel *allmodel;

@end

@implementation LoginVC

- (void)dealloc{
    FlyLog(@"登录页面delloc");
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self creatUI];
    
    FlyLog(@"%@",NSStringFromCGRect(self.view.bounds));
}

#pragma mark------------------------------------Event------------------------------------
//失败
- (void)ShowFailStr:(NSString *)str{
    [MBProgressHUD showErrorView:self.view errorTitle:str];
}

//展示UUID
- (void)showUUID:(NSString *)UUID{
    [MBProgressHUD showSuccessView:self.view];
    
    UIAlertController *aleart = [UIAlertController alertControllerWithTitle:@"此设备未注册设备UUID" message:[NSString stringWithFormat:@"%@",UUID] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    
    [aleart addAction:ok];
    
    [self presentViewController:aleart animated:YES completion:nil];
}

#pragma mark------------------------------------------------------------------------------------

//获取验证码
- (void)getYZMEVent{
    
    NSString *username = [self.loginview.accountTextField.text whiteSpace];
    
    if ([username isEqualToString:@""]) {
        [MBProgressHUD showTextView:self.view textTitle:@"用户名不能为空"];
        return;
    }
    
    [self.NetViewModle YZMWithUsernName:self.loginview.accountTextField.text start:^{
        
    } success:^(UIImage *image) {
        [self.loginview changeYZMWithImage:image];
    } fail:^(NSString *failStr) {
        [MBProgressHUD showTextView:self.view textTitle:failStr];
    }];
}

//1.登录
- (void)loginEvent{
    
    [self.view endEditing:YES];
    
    if (MyCountText == 1) {
        
        if (![self.loginview.accountTextField.text isEqualToString:@""] && ![self.loginview.passWordTextfiled.text isEqualToString:@""]) {//自己输入
            
        }else{
            self.loginview.accountTextField.text = @"XAJ003";
            self.loginview.passWordTextfiled.text = @"123456";
        }
        
    }
    
    [self.NetViewModle loginEventWith:self.loginview.accountTextField.text
                             password:self.loginview.passWordTextfiled.text
                                  YZM:self.loginview.YzmTextFiled.text
                            condition:^(NSString *str) {
                                [MBProgressHUD showTextView:self.view textTitle:str];
                            } startLogin:^{
                                [MBProgressHUD showLoadView:self.view loadTitle:@"正在登录"];
                            } success:^(LoginModel *model) {
                                
                                self.allmodel.loginmdoel = model;
                                [self getdeviceID];
                                
                            } fail:^(NSString *failNetStr) {
                                [self ShowFailStr:failNetStr];
                            } failreson:^(NSString *failStr,UIImage *image) {
                                [self ShowFailStr:failStr];
                                [self.loginview loadYZMImageWith:image];
                            }];
    
    
}

//检查更新
- (void)CheckUpdateVerson{
    
    [self.NetViewModle updateSuccessBlock:^(CheckVerSonModel *verSonModel) {
        
        NSDictionary *infodic = [[NSBundle mainBundle] infoDictionary];
        
        if (![infodic[@"CFBundleShortVersionString"] isEqualToString:verSonModel.versionCode] && ![verSonModel.versionCode isEqualToString:@""]) {//版本不为空，而且版本号不相同
            
            [MBProgressHUD showSuccessView:self.view];
            
            [FLyAleartView showAleartViewWithtitle:@"-您有新版本要升级-" subtitle:@"点击安装后,请点击Home键,回到桌面查看安装情况" imageName:@"updateImage" suretitle:@"好的" sure:^{
                
                NSString *NeedLoadUrl = [[NSString alloc] initWithFormat:@"itms-services://?action=download-manifest&url=%@",verSonModel.manefest];
                          
                FlyLog(@"url---%@",NeedLoadUrl);
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:NeedLoadUrl] options:@{} completionHandler:^(BOOL success) {
                    
                }];
                
            }];
            
        }else{
            [self getdeviceID];
        }
        
    } fail:^(NSString *failStr) {
        
        [self ShowFailStr:failStr];
        
    }];
    
    
}

//2.获取设备有没有注册
- (void)getdeviceID{
    
    [self.NetViewModle GetDeviceIDSuccess:^(DeviceModel *mdoel) {
        self.allmodel.deviceModel = mdoel;
        [self getPesssion];
    } fail:^(NSString *failNetStr) {
        [self ShowFailStr:failNetStr];
    } failreson:^(NSString *failStr) {
        [self showUUID:failStr];
    }];
    
}

//3.获取权限
- (void)getPesssion{
    
    [self.NetViewModle perssionWithModel:self.allmodel success:^(PerssionModel *model) {
        self.allmodel.perssioModel = model;
        [self getAJIsVaild];
    } fail:^(NSString *failNetStr) {
        [self ShowFailStr:failNetStr];
        
    } failreson:^(NSString *failStr) {
        [self ShowFailStr:failStr];
        
    }];
    
}

//4.获取安检是否可用
- (void)getAJIsVaild{
    
    [self.NetViewModle AJisVaildsuccess:^(AJModel *mdoel) {
        self.allmodel.ajModel = mdoel;
        [self getProtocol];
    } fail:^(NSString *failNetStr) {
        [self ShowFailStr:failNetStr];
    } failReason:^(NSString *failStr) {
        [self ShowFailStr:failStr];
    }];
}

//5.获取协议
- (void)getProtocol{
    
    [self.NetViewModle protocolSuccess:^(ProtocolModel *model) {
        
        self.allmodel.protocolModel = model;
        [self getLastLoginTime];
        
    } fail:^(NSString *failNetStr) {
        [self ShowFailStr:failNetStr];
        
    } failReson:^(NSString *failStr) {
        [self ShowFailStr:failStr];
    }];
}


//6.获取首页需要的allmodel
- (void)getLastLoginTime{
    
    [self.NeedNetViewModel loadWithAllModel:self.allmodel success:^(AllModel *allmodel) {
        
        self.allmodel = allmodel;
        [self requestNetSuccess];
        
    } fail:^(NSString *fail) {
        [self ShowFailStr:fail];
    }];
    
    
}


//请求成功
- (void)requestNetSuccess{
    
    [MBProgressHUD showSuccessView:self.view];
    
    [self selectType];

    
//    if ([self.allmodel.protocolModel.protocolContrnt isEqualToString:@""]) {//没有协议内容
//
//        [self selectType];
//
//    }else{
//
//        [ShowUserAgreeVIew showUserTitle:@"操作说明" content:self.allmodel.protocolModel.protocolContrnt type:SelectOpertionType agree:^{
//            [self selectType];
//
//        } dontAgree:^{
//
//        }];
//
//
//    }
}



//进行权限判断
- (void)selectType{
    
    
    if (![BaseVerifyUtils isNullOrSpaceStr:self.allmodel.perssioModel.xinPermissions]) {
       
        if (self.allmodel.perssioModel.xinPermissions.length>1) {
            [SelectCheckTypeView showCheckTypeViewContainStr:self.allmodel.perssioModel.xinPermissions SelectType:^(SelectCheckType checkType) {
               if (checkType == FirstCheck){//安检
                   
                   [self IntoFirstCheck];
                   
               }else if (checkType == twenty_fourHourCheck){//24小时检测
                   
                   [self IntotwentyFourHourCehck];
               }else if (checkType == Check9610){
                   [self Into9610SysCheck];
               }
            }];
        }
        else if ([self.allmodel.perssioModel.xinPermissions isEqualToString:@"1"]){//首检
            
            [self IntoFirstCheck];
            
        }else if ([self.allmodel.perssioModel.xinPermissions isEqualToString:@"2"]){//24小时
            [self IntotwentyFourHourCehck];
            
        }else if ([self.allmodel.perssioModel.xinPermissions isEqualToString:@"3"]){//9610
            [self Into9610SysCheck];
        }
    }else{
        if ([self.allmodel.perssioModel.Permissions isEqualToString:@"0"]) {//都有权限
            
            [SelectCheckTypeView showCheckTypeViewContainStr:@"1,2" SelectType:^(SelectCheckType checkType) {
               
                if (checkType == FirstCheck){//安检
                    
                    [self IntoFirstCheck];
                    
                }else if (checkType == twenty_fourHourCheck){//24小时检测
                    
                    [self IntotwentyFourHourCehck];
                }else if (checkType == Check9610){
                    [self Into9610SysCheck];
                }
            }];
            
        }else if ([self.allmodel.perssioModel.Permissions isEqualToString:@"1"]){//首检
            
            [self IntoFirstCheck];
            
        }else if ([self.allmodel.perssioModel.Permissions isEqualToString:@"2"]){//24小时
            [self IntotwentyFourHourCehck];
            
        }else if ([self.allmodel.perssioModel.Permissions isEqualToString:@"3"]){//9610
            [self Into9610SysCheck];
        }
    }
    
    
}

//首检
- (void)IntoFirstCheck{
    
    FirstVC *vc = [[FirstVC alloc] initWithFullName:self.allmodel.loginmdoel.FullName];

    vc.allmodel = self.allmodel;
    
    //设置定时器
    [self setTimerWithType:FirstNeedNotificationType];
    
    [self setrootVC:vc];
    
}
//9610
- (void)Into9610SysCheck{
    FirstVC *vc = [[FirstVC alloc] initWithFullName:self.allmodel.loginmdoel.FullName];

    vc.allmodel = self.allmodel;
    vc.detectionType = DetectionType9610System;
    //设置定时器
    [self setTimerWithType:FirstNeedNotificationType];
    
    [self setrootVC:vc];
}

//24小时
- (void)IntotwentyFourHourCehck{
    
    TwentyFourVC *vc = [[TwentyFourVC alloc] initWithFullName:self.allmodel.loginmdoel.FullName];
    
    vc.allmodel = self.allmodel;
    
    //设置定时器
    [self setTimerWithType:TwentyType];
    
    [self setrootVC:vc];
}

//设置跟控制器
- (void)setrootVC:(UIViewController *)vc{
    
    BaseNav *nav = [[BaseNav alloc] initWithRootViewController:vc];
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    
    CATransition *animation = [CATransition animation];
    
    animation.duration = 1.0;
    
    //    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    animation.type = @"rippleEffect";
    
    //    animation.type = kCATransitionReveal;
    
    //    animation.subtype = kCATransitionFromRight;
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    keywindow.rootViewController = nav;
    
}

//设置倒计时
- (void)setTimerWithType:(ComingType)type{
    
    [MYTimer shareINstace].deviceModel = self.allmodel.deviceModel;
    [[MYTimer shareINstace] startTimerWithType:type];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.loginview.passWordTextfiled]) {
        [self loginEvent];
    }else if ([textField isEqual:self.loginview.YzmTextFiled]){
        [self loginEvent];
    }
    
    return YES;
}

#pragma mark------------------------------------------------------------------------------------
- (void)creatUI{
    [self.view addSubview:self.loginview];
    
}

- (AllModel *)allmodel{
    if (!_allmodel) {
        _allmodel = [[AllModel alloc] init];
    }
    return _allmodel;
}

- (LoginVIew *)loginview{
    
    if (!_loginview) {
        _loginview = [[LoginVIew alloc] initWithFrame:self.view.bounds];
        _loginview.backgroundColor = [UIColor whiteColor];
        [_loginview.loginBtn addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
        [_loginview.YZMBtn addTarget:self action:@selector(getYZMEVent) forControlEvents:UIControlEventTouchUpInside];
        _loginview.passWordTextfiled.delegate = self;
        _loginview.YzmTextFiled.delegate = self;
    }
    return _loginview;
}

- (LoginNetViewModel *)NetViewModle{
    if (!_NetViewModle) {
        _NetViewModle = [[LoginNetViewModel alloc] init];
    }
    return _NetViewModle;
}

- (LoginNeedNetViewModel *)NeedNetViewModel{
    if (!_NeedNetViewModel) {
        _NeedNetViewModel = [[LoginNeedNetViewModel alloc] init];
    }
    return _NeedNetViewModel;
}


@end

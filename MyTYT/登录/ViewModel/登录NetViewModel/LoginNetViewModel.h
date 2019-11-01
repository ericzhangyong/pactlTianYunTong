//
//  LoginNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LoginModel;
@class DeviceModel;
@class ProtocolModel;
@class PerssionModel;
@class AJModel;
@class  AllModel;
@class CheckVerSonModel;


typedef void(^LoginSuccessBlock)(LoginModel *model);
typedef void(^LoginCoditionBlock)(NSString *str);
typedef void(^LoginNetFailBlock)(NSString *failNetStr);
typedef void(^LoginFailBlock)(NSString *failStr,UIImage *image);
typedef void(^LoginStartBlock)(void);

typedef void(^DevicBlockSuccess)(DeviceModel *mdoel);
typedef void(^DevicNetFaiBlockl)(NSString *failNetStr);
typedef void(^DeviceFailBlock)(NSString *failStr);

typedef void(^PesssionSuccessBlock)(PerssionModel *model);
typedef void(^PesssionNetFailBlock)(NSString *failNetStr);
typedef void(^PesssionFailBlock)(NSString *failStr);

typedef void(^AJSuccessBlock)(AJModel *mdoel);
typedef void(^AJNetFailBlock)(NSString *failNetStr);
typedef void(^AJFailBlock)(NSString *failStr);

typedef void(^ProTocolSuccessBlock)(ProtocolModel *model);
typedef void(^ProTocolNetFailBlock)(NSString *failNetStr);
typedef void(^ProTocolFailBlock)(NSString *failStr);

typedef void(^YZMStartBlock)(void);
typedef void(^YZMSuccessBlock)(UIImage *image);
typedef void(^YZMFailBlock)(NSString *failStr);

typedef void(^UpdateSuccessBlock)(CheckVerSonModel *verSonModel);
typedef void(^UpdateFailBlock)(NSString *failStr);

@interface LoginNetViewModel : NSObject

//登录
- (void)loginEventWith:(NSString *)username
              password:(NSString *)password
                   YZM:(NSString *)YZM
             condition:(LoginCoditionBlock )condition
            startLogin:(LoginStartBlock)startLogin
               success:(LoginSuccessBlock )success
                  fail:(LoginNetFailBlock)fail
             failreson:(LoginFailBlock)failreson;

//验证码
- (void)YZMWithUsernName:(NSString *)username
              start:(YZMStartBlock)start
                 success:(YZMSuccessBlock )success
                    fail:(YZMFailBlock)fail;

//版本更新
- (void)updateSuccessBlock:(UpdateSuccessBlock)success
                      fail:(UpdateFailBlock)fail;

//获取设备ID<判断设备有没有注册>
- (void)GetDeviceIDSuccess:(DevicBlockSuccess)success fail:(DevicNetFaiBlockl)fail failreson:(DeviceFailBlock)failreson;

//获取权限
- (void)perssionWithModel:(AllModel *)allmodel success:(PesssionSuccessBlock)succes fail:(PesssionNetFailBlock)fail failreson:(PesssionFailBlock)failreson;

//用户安检分队信息是否有效
- (void)AJisVaildsuccess:(AJSuccessBlock)success fail:(AJNetFailBlock)fail failReason:(AJFailBlock)failreson;

//用户协议
- (void)protocolSuccess:(ProTocolSuccessBlock)success fail:(ProTocolNetFailBlock)fail failReson:(ProTocolFailBlock)failReson;

@end

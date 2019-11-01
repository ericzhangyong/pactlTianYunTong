//
//  LoginNetViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LoginNetViewModel.h"
#import "FlyHttpTools.h"
#import "NSString+JM.h"
#import "MyNeedInfo.h"
#import "GSKeyChainDataManager.h"
#import "LoginModel.h"
#import "DeviceModel.h"
#import "MyCooke.h"
#import "PerssionModel.h"
#import "AJModel.h"
#import "ProtocolModel.h"
#import "AllModel.h"
#import "CheckVerSonModel.h"
#import "UpdateModel.h"

@implementation LoginNetViewModel

- (void)dealloc{
    FlyLog(@"登录-viewmodel-delloc");
}

#pragma mark------------------------------------------------------------------------------------
//登录
- (void)loginEventWith:(NSString *)username
              password:(NSString *)password
                   YZM:(NSString *)YZM
             condition:(LoginCoditionBlock )condition
            startLogin:(LoginStartBlock)startLogin
               success:(LoginSuccessBlock )success
                  fail:(LoginNetFailBlock)fail
             failreson:(LoginFailBlock)failreson{
    
    if ([self username:username  password:password condition:condition]) {
        
        startLogin();
        
        username = [username whiteSpace];
        
        password =  [password whiteSpace];
        
        YZM = [YZM whiteSpace];
        
        NSDictionary *updic = @{
                                @"username":username,
                                @"password":password,
                                @"checkCode":YZM
                                };
        

        [FlyHttpTools postLoginWithjsonDic:updic interface:@"/api/sso/login" success:^(NSDictionary *dic) {
            
            FlyLog(@"%@",dic);
            
            if ([dic[@"ok"] intValue] == 1) {
                NSData *data = [[[NSString alloc] initWithFormat:@"%@",dic[@"data"]] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                
                LoginModel *model = [[LoginModel alloc] initWithDic:mydic];
                
                [self saveInfoWithModel:model];
                success(model);
                FlyLog(@"---%@",mydic);
            }else{
                
                if (dic[@"data"] !=Nil && [dic[@"data"] length]>0) {
                    NSData *data = [[NSData alloc] initWithBase64EncodedString:dic[@"data"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    UIImage *image = [UIImage imageWithData:data];
                    failreson(dic[@"msg"],image);
                    
                }else{
                    fail(dic[@"msg"]);
                }
                
            }
            
            
        } failure:^(NSString *NetFailReason) {
            fail(NetFailReason);
        }];
        
    }
    
}


//登录条件
- (BOOL)username:(NSString *)username password:(NSString *)password condition:(LoginCoditionBlock)condition{
    
    if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
        condition(@"用户名密码不能为空");
        return NO;
    }
    
    return YES;
}

//保存信息
- (void)saveInfoWithModel:(LoginModel *)model{
    
    NSHTTPCookie *tokencook = [[MyCooke shareInstance] addCookename:@"token" value:model.token];
    
    NSHTTPCookie *is_login = [[MyCooke shareInstance] addCookename:@"is_login" value:@"1"];
    
    NSHTTPCookie *unit = [[MyCooke shareInstance] addCookename:@"unit" value:[[NSString alloc] initWithFormat:@"%ld",(long)model.dept_id]];
    
    
    NSArray *mycookes = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString: [[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath]]];
    
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObjectsFromArray:mycookes];
    
    [array addObject:tokencook];
    [array addObject:is_login];
    [array addObject:unit];
    
    NSDictionary *cookdic = [NSHTTPCookie requestHeaderFieldsWithCookies:array];
    
    FlyLog(@"cookdic---%@",cookdic);
    
    NSMutableString *str  = [NSMutableString stringWithString: [cookdic valueForKey:@"Cookie"]];
    
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:model.user options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString * vale = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    vale = [vale stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    vale = [[NSString alloc] initWithFormat:@"; user=%@",vale];
    
    [str appendString:vale];
    FlyLog(@"%@",str);
    
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:MYCOOKE];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}


#pragma mark------------------------------------------------------------------------------------

//版本更新
- (void)updateSuccessBlock:(UpdateSuccessBlock)success
                      fail:(UpdateFailBlock)fail{
    
    NSDictionary *updic = @{
                            
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/appversion/getCurrentVersion" success:^(NSDictionary *dic) {
        
        FlyLog(@"updic返回---%@",dic);
        
        UpdateModel *mdoel = [[UpdateModel alloc] initWithDic:dic];
        
        if (mdoel.ok == 1) {
            success(mdoel.verSonModel);
        }else{
            fail(mdoel.msg);
        }
        
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
    
}
//获取设备ID
- (void)GetDeviceIDSuccess:(DevicBlockSuccess)success fail:(DevicNetFaiBlockl)fail failreson:(DeviceFailBlock)failreson{
    
    NSString *uuid ;
  
    uuid =  [GSKeyChainDataManager readUUID];
    
    FlyLog(@"%@",uuid);
    
    NSDictionary *updic = @{
                            @"page":@"1",
                            @"rows":@"3",
                            @"mac":uuid
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/scheck/getEquipments" success:^(NSDictionary *dic) {
        
        FlyLog(@"%@",dic);
        if ([dic[@"total"] intValue] == 0) {
            failreson([GSKeyChainDataManager readUUID]);
        }else{
            
            NSArray *array = dic[@"rows"];
            NSDictionary *temdic = [array firstObject];
            DeviceModel *model = [[DeviceModel alloc] initWithDic:temdic];
            success(model);
        }
        
    }  failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}


#pragma mark------------------------------------------------------------------------------------
//获取权限
- (void)perssionWithModel:(AllModel *)allmodel success:(PesssionSuccessBlock)succes fail:(PesssionNetFailBlock)fail failreson:(PesssionFailBlock)failreson{
    
    NSNumber *personID = [NSNumber numberWithInteger:allmodel.loginmdoel.PersonID];
    
    NSNumber *dept_id =[NSNumber numberWithInteger: allmodel.loginmdoel.dept_id];
    
    NSString *machinID = allmodel.deviceModel.machinID;
    
    NSDictionary *updic = @{
                            @"personId": personID,
                            @"dept_id":dept_id,
                            @"machineId":machinID
                            };
    
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/getPermissions" success:^(NSDictionary *dic) {
        FlyLog(@"%@",dic);
        
        if ([dic[@"ok"] integerValue] ==1 ) {
            PerssionModel *model = [[PerssionModel alloc] initWithDic:dic[@"data"]];
            
            succes(model);
        }else{
            failreson(dic[@"msg"]);
        }
        
    }  failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}


#pragma mark------------------------------------------------------------------------------------
//用户安检分队信息是否有效
- (void)AJisVaildsuccess:(AJSuccessBlock)success fail:(AJNetFailBlock)fail failReason:(AJFailBlock)failreson{
    
    NSDictionary *updic = @{
                            
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/scheck/queryUnitIsValid" success:^(NSDictionary *dic) {
        
        FlyLog(@"%@",dic);
        if ([dic[@"ok"] integerValue] ==1 && dic[@"data"]) {
            
            AJModel *model = [[AJModel alloc] initWithDic:dic[@"data"]];
            if ([model.isValid isEqualToString:@"1"]) {
                success(model);
            }else{
                failreson(@"当前用户安检分队信息无效,请联系管理员处理");
            }
        }else{
            NSString *str = [[NSString alloc] initWithFormat:@"获取分队信息失败,请联系管理员:%@",dic[@"msg"]];
            
            failreson(str);
        }
        
    }  failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
    
}

//用户协议
- (void)protocolSuccess:(ProTocolSuccessBlock)success fail:(ProTocolNetFailBlock)fail failReson:(ProTocolFailBlock)failReson{
    
    [FlyHttpTools postWithStr:@"agreeBook" interface:@"/api/pactl/comm/item" success:^(NSDictionary *dic) {
        
        FlyLog(@"%@",dic);
        if ([dic[@"ok"] integerValue] ==1) {
            
            ProtocolModel *model = [[ProtocolModel alloc] initWithDic:dic[@"data"]];
            success(model);
        }else{
            
            failReson(dic[@"msg"]);
        }
        
    }  failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
    
    
    
}

#pragma mark------------------------------------------------------------------------------------
//验证码
- (void)YZMWithUsernName:(NSString *)username
                   start:(YZMStartBlock)start
                 success:(YZMSuccessBlock )success
                    fail:(YZMFailBlock)fail{
    start();
    
    [FlyHttpTools postYZMWithStr:username interface:@"/api/sso/imageCode" success:^(NSDictionary *dic) {
        
        if ([dic[@"ok"] intValue] == 1 && dic[@"data"] != Nil && [dic[@"data"] length]>0) {
            NSData *data = [[NSData alloc] initWithBase64EncodedString:dic[@"data"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *image = [UIImage imageWithData:data];
            success(image);
            
        }else{
            fail(dic[@"msg"]);
        }
        
    }  failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}

@end

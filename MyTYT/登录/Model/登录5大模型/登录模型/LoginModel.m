//
//  LoginModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LoginModel.h"
#import "NSDictionary+Judge.h"

@implementation LoginModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.token = dic[@"token"];
        
        self.user = dic[@"user"];
        
        self.PersonID = [self.user[@"id"] integerValue];
        
        self.dept_id = [self.user[@"dept_id"] integerValue];
        
        self.FullName = self.user[@"fullname"];
        
    }
    return self;
}


//token = "ef0d7ae5-b824-4f40-8bf1-c5a1de59adb6";
//user = {
//    id = 17476;
//    roles =             (
//    );
//    ismanager = 0;
//    type = "security";
//    dept_id = 14191;
//    avatar = {
//        system = 0;
//        handler = {
//        };
//        deleted = 0;
//        id = 17475;
//        last_update = "2017-08-25 22:51:27";
//        hibernate_lazy_initializer = {
//        };
//        created = "2017-08-25 22:51:27";
//        file_name = "/group1/M00/04/B5/wKgeeVmgOW-AVVIqAAAqnJqNJ9s772.jpg";
//        type = "UNIT";
//    };
//    deleted = 0;
//    last_update = "2018-04-22 16:37:13";
//    user_properties =             (
//                                   {
//                                       id = 64086;
//                                       created = "2018-04-22 16:37:12";
//                                       last_update = "2018-04-22 16:37:12";
//                                       deleted = 0;
//                                       prop_value = "72f98f843b8b465c94b0dd3c3055ccd9";
//                                       prop_name = "unit";
//                                   },
//                                   {
//                                       id = 64085;
//                                       created = "2018-04-22 16:37:12";
//                                       last_update = "2018-04-22 16:37:12";
//                                       deleted = 0;
//                                       prop_value = "XAJ03";
//                                       prop_name = "unitcode";
//                                   }
//                                   );
//    created = "2017-08-25 22:51:28";
//    user_groups =             (
//    );
//    fullname = "XAJ03";
//    account = "XAJ03";
//    status = "正常";
//};

@end

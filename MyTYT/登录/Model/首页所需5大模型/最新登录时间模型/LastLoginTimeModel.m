//
//  LastLoginTimeModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LastLoginTimeModel.h"

@implementation LastLoginTimeModel


- (instancetype)initWirhDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.ok = [dic[@"ok"] intValue];
        
        self.msg = dic[@"msg"];
        
        if (self.ok == 1) {
            
            NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:([dic[@"data"] doubleValue]/1000)];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            self.lastLoginTime = [dateFormatter stringFromDate: detailDate];
   
        }
        
    }
    return self;
}


@end

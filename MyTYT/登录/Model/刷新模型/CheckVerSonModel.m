//
//  CheckVerSonModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CheckVerSonModel.h"
#import "NSDictionary+Judge.h"

@implementation CheckVerSonModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        if ([dic judgekeyAndValueWithKey:@"versionCode"]) {
            self.versionCode = dic[@"versionCode"];
        }else{
            self.versionCode = @"";
        }
        
        if ([dic judgekeyAndValueWithKey:@"manefest"]) {
            self.manefest = dic[@"manefest"];
        }else{
            self.manefest = @"";
        }
        
        
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manefest = @"";
        self.versionCode = @"";
    }
    return self;
}
@end

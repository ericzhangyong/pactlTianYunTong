//
//  NewBZModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "NewBZModel.h"
#import "BZCerModel.h"

@implementation NewBZModel

- (instancetype)initWIthDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.waybill_no = dic[@"waybill_no"];
        
        self.goods_desc = dic[@"goods_desc"];
        
        self.goods_desc = [[self.goods_desc componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]] componentsJoinedByString:@""];
        
        self.count_remark = dic[@"count_remark"];
        
        self.awId = dic[@"awId"];
        
        self.type = dic[@"type"];

        if (dic[@"eli_flag"]!=Nil) {
            self.eli_flag = dic[@"eli_flag"];
        }else{
            self.eli_flag = @"";
        }
        
        if (dic[@"elm_flag"]!=Nil) {
            self.elm_flag = dic[@"elm_flag"];
        }else{
            self.elm_flag = @"";
        }
        
    
        if (dic[@"wb_ele"] == Nil) {
            self.wb_ele = @"";
        }else{
            self.wb_ele = dic[@"wb_ele"];
        }
        

        
        if ([self.type isEqualToString:@"0"]) {//显示证书条件
            
            
            NSMutableArray *array = [NSMutableArray array];
            NSMutableArray *userarray = [NSMutableArray array];
            
            if ([dic[@"books"] isKindOfClass:[NSArray class]] && [dic[@"books"] count]>0) {//保证有数据
                
                for (NSDictionary *temdic in dic[@"books"]) {
                    
                    BZCerModel *mdoel = [[BZCerModel alloc] initWithDic:temdic];//所有证书
                    [array addObject:mdoel];
                    
                    if ([mdoel.checkVisual isEqualToString:@"1"] && [mdoel.bookCheckType isEqualToString:@"book"]) {//可显示证书
                        [userarray addObject:mdoel];
                    }
                }
                
            }
           
            self.ZSArray = [NSArray arrayWithArray:array];
            self.CanUseCerArray = [NSArray arrayWithArray:userarray];
        }
        
       if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"securityCheckResultColor"]]) {
           self.securityCheckResultColor =dic[@"securityCheckResultColor"];
       }else{
           self.securityCheckResultColor = @"000000";
       }
       if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"securityCheckResult"]]) {
           self.securityCheckResult =dic[@"securityCheckResult"];
       }else{
           self.securityCheckResult = @"";
       }
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"refResult"]]) {
            self.securityCheckResult =dic[@"refResult"];
        }else{
            self.securityCheckResult = @"";
        }

        
    }
    return self;
}

@end

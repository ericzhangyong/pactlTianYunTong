//
//  CheckModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CheckModel.h"

@implementation CheckModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        if (dic[@"goods_class"] !=Nil) {
            self.goods_class = dic[@"goods_class"];
        }else{
            self.goods_class = @"";
        }
        
        if (dic[@"personid"] !=Nil) {
            self.personid = dic[@"personid"];
        }else{
            self.personid = @"";
        }
        
        if (dic[@"operatdate"] !=Nil) {
            self.operatdate = dic[@"operatdate"];
        }else{
            self.operatdate = @"";
        }
        
        if (dic[@"a_status"] !=Nil) {
            self.a_status = dic[@"a_status"];
        }else{
            self.a_status = @"";
        }
        
        if (dic[@"machine"] !=Nil) {
            self.machine = dic[@"machine"];
        }else{
            self.machine = @"";
        }
        
//        if ([self.goods_class isEqualToString:@"0"]) {
//            self.goods_class = @"普通货物";
//        }else if ([self.goods_class isEqualToString:@"1"]){
//            self.goods_class = @"危险品";
//        }else if ([self.goods_class isEqualToString:@"2"]){
//            self.goods_class = @"24小时货物";
//        }
        
    }
    return self;
}

@end

//
//  WayBillModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "WayBillModel.h"

@implementation WayBillModel

- (instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        
        //分单主键
        if (dic[@"awId"] !=Nil) {
            self.awId = dic[@"awId"];
        }else{
            self.awId = @"";
        }
        
        //分单号
        if (dic[@"waybill_no"] !=Nil) {
            self.waybill_no = dic[@"waybill_no"];
        }else{
            self.waybill_no = @"";
        }
        
       //❎表示
        if (dic[@"ref_status"] !=Nil) {
            self.ref_status = dic[@"ref_status"];
        }else{
            self.ref_status = @"";
        }

        //电子运单
        if (dic[@"wb_ele"] !=Nil) {
            self.wb_ele = dic[@"wb_ele"];
        }else{
            self.wb_ele = @"";
        }

        
    
        //件数
        if (dic[@"total_count"] !=Nil) {
            self.total_count = dic[@"total_count"];
        }else{
            self.total_count = @0;
        }
        
        //重量
        if (dic[@"gross_weight"] !=Nil) {
            self.gross_weight = dic[@"gross_weight"];
        }else{
            self.gross_weight = @0;
        }
        //目的港
        if (dic[@"dest1"] !=Nil) {
            self.dest1 = dic[@"dest1"];
        }else{
            self.dest1 = @"";
        }
        
        //品名
        if (dic[@"goods_desc"] !=Nil) {
            self.goods_desc = dic[@"goods_desc"];
        }else{
            self.goods_desc = @"";
        }
        

        //eli
        if (dic[@"eli_flag"] !=Nil) {
            self.eli_flag = dic[@"eli_flag"];
        }else{
            self.eli_flag = @"";
        }
        
        //elm
        if (dic[@"elm_flag"] !=Nil) {
            self.elm_flag = dic[@"elm_flag"];
        }else{
            self.elm_flag = @"";
        }
        
        //备注数量
        if (dic[@"count_remark"] !=Nil) {
            self.count_remark = dic[@"count_remark"];
        }else{
            self.count_remark = @"";
        }
        //备注数量
        if (dic[@"goods_name_cn"] !=Nil) {
            self.goods_name_cn = dic[@"goods_name_cn"];
        }else{
            self.goods_name_cn = @"";
        }
    }
    return self;
}

@end

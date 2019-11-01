//
//  TwentyModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TwentyModel.h"
#import "SelectStateModel.h"
#import "RoadModel.h"
#import "BooksModel.h"
#import "TwentyMachineModel.h"
#import "TwentyLocalInfoModel.h"
#import "NSDictionary+Judge.h"

@implementation TwentyModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        
        /*
         备注
         */
        if (dic[@"count_remark"] !=Nil) {
            self.count_remark = dic[@"count_remark"];
        }else{
            self.count_remark = @"";
        }
        
        
        /*
         新消息
         */
        if (dic[@"isnew"] !=Nil) {
            self.isnew = dic[@"isnew"];
        }else{
            self.isnew = @"";
        }
        
        /*
         操作代理
         */
        if (dic[@"agent_oprn"] !=Nil) {
            self.agent_oprn = dic[@"agent_oprn"];
        }else{
            self.agent_oprn = @"";
        }
        
        /*
         操作代理简称
         */
        
        if ([dic judgekeyAndValueWithKey:@"agent_short_name"]) {
            
            self.agent_short_name = dic[@"agent_short_name"];

        }else{
            self.agent_short_name = @"";
        }
        
        
        /*
         操作代理ID
         */
        if (dic[@"agent_oprn_id"] !=Nil) {
            self.agent_oprn_id = dic[@"agent_oprn_id"];
        }else{
            self.agent_oprn_id = @"";
        }
        
        /*
         总单号
         */
        [self setNumberWtihDic:dic];
        
        /*
         目的港
         */
        if (dic[@"dest1"] !=Nil) {
            self.dest1 = dic[@"dest1"];
        }else{
            self.dest1 = @"";
        }
        
        /*
         件数
         */
        if (dic[@"total_count"] !=Nil) {
            self.total_count = dic[@"total_count"];
        }else{
            self.total_count = @0;
        }
        
        /*
         重量
         */
        if (dic[@"gross_weight"] !=Nil) {
            self.gross_weight = dic[@"gross_weight"];
        }else{
            self.gross_weight = @0;
        }

        /*
         证书数量
         */
        if (dic[@"count_books"] !=Nil) {
            self.count_books = dic[@"count_books"];
        }else{
            self.count_books = @"";
        }
        
        /*
         证书数组
         */
        [self setBookWithDic:dic];
        
        /*
          通过待定
         */
        if (dic[@"fstatus"] !=Nil) {
            self.fstatus = dic[@"fstatus"];
        }else{
            self.fstatus = @"";
        }
        
        /*
         货物类别
         */
        if (dic[@"goods_class"] !=Nil) {
            self.goods_class = dic[@"goods_class"];
        }else{
            self.goods_class = @"";
        }
        
        /*
         24小时通道ID
         */
        if (dic[@"aisle24"] !=Nil) {
            self.aisle24 = dic[@"aisle24"];
        }else{
            self.aisle24 = @"";
        }
        
        /*
          通道货物数量
         */
        if (dic[@"aislecount"] !=Nil) {
            self.aislecount = dic[@"aislecount"];
        }else{
            self.aislecount = @"";
        }
        
      
        /*
         24小时待过安检机
         */
        if (dic[@"machine24"] !=Nil) {
            self.machine24 = dic[@"machine24"];
        }else{
            self.machine24 = @"";
        }

        /*
          安检机
         */
        if (dic[@"mcid"] !=Nil) {
            self.mcid = dic[@"mcid"];
        }else{
            self.mcid = @"";
        }

        /*
         ELI
         */
        if (dic[@"eli_flag"] !=Nil) {
            self.eli_flag = dic[@"eli_flag"];
        }else{
            self.eli_flag = @"";
        }
        
        /*
         ELM
         */
        if (dic[@"elm_flag"] !=Nil) {
            self.elm_flag = dic[@"elm_flag"];
        }else{
            self.elm_flag = @"";
        }
        
        
        /*
         是否正式
         */
        if (dic[@"is_formal"] !=Nil) {
            self.is_formal = dic[@"is_formal"];
        }else{
            self.is_formal = @"";
        }

        /*
         正式的字
         */
        if (dic[@"show_word"] !=Nil) {
            self.show_word = dic[@"show_word"];
        }else{
            self.show_word = @"";
        }


        /*
         测试字
         */
        self.testWord = @"";

        /*
         电子运单
         */
        if (dic[@"wb_ele"] !=Nil) {
            self.wb_ele = dic[@"wb_ele"];
        }else{
            self.wb_ele = @"";
        }
        
        /*
         航空二字代码
         */
        if (dic[@"airCode"] !=Nil) {
            self.airCode = dic[@"airCode"];
        }else{
            self.airCode = @"";
        }

        /*
         运单主键
         */
        if (dic[@"awId"] !=Nil) {
            self.awId = dic[@"awId"];
        }else{
            self.awId = @"";
        }

        /*
         本地选择模型
         */

        [self setLocalState];
        

        /*
         本地信息模型
         */
        [self setlocalInfoModel];
        
    
        /*
         控
         */
        if ([dic judgekeyAndValueWithKey:@"isSc"]) {
            
            if ([dic[@"isSc"] isEqualToString:@"1"]) {
                self.iscontrol = YES;
            }else{
                self.iscontrol = NO;
            }
            
        }else{
            self.iscontrol = NO;
        }
        
        //安保布控
        if ([dic judgekeyAndValueWithKey:@"isTc"]) {
            
            if ([dic[@"isTc"] isEqualToString:@"1"]) {
                self.isABControl = YES;
                
            }else{
                self.isABControl = NO;
            }
            
        }else{
            self.isABControl = NO;
        }
        
    }
    return self;
}

//本地信息模型
- (void)setlocalInfoModel{
    
    self.infoModel = [[TwentyLocalInfoModel alloc] init];
    
    self.infoModel.aislecount = self.aislecount;
    
    self.infoModel.machine24 = self.machine24;
    
    self.infoModel.roadModel = [[RoadModel alloc] init];
    
    self.infoModel.machineModel = [[TwentyMachineModel alloc] init];
    
}


//设置本地操作记录
- (void)setLocalState{
    
    self.LocalstateModel = [[SelectStateModel alloc] init];
}


//设置单号
- (void)setNumberWtihDic:(NSDictionary *)dic{
    
    
    if (dic[@"waybill_no"]!=Nil) {
        
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",dic[@"waybill_no"]];
    
        if ([str length] >3) {
            
            [str insertString:@"-" atIndex:3];
            self.waybill_no = [NSString stringWithString:str];

        }else{
            self.waybill_no = dic[@"waybill_no"];
        }
    
    }else{
        self.waybill_no = @"";
    }
}

//设置证书
- (void)setBookWithDic:(NSDictionary *)dic{
    
    NSMutableArray *array = [NSMutableArray array];
    
    if ([dic[@"books"] isKindOfClass:[NSArray class]] && [dic[@"books"] count] > 0) {
        
        for (NSDictionary *temdic in dic[@"books"]) {
            BooksModel *mdoel = [[BooksModel alloc] initWithDic:temdic];
            [array addObject:mdoel];
        }
        
        self.booksArray = [NSArray arrayWithArray:array];
    }
    
}

@end

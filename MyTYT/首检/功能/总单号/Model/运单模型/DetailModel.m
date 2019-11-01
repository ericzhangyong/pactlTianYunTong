//
//  DetailModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailModel.h"
#import "infoModel.h"
#import "DetailBook.h"
#import "CheckModel.h"
#import "WayBillModel.h"
#import "DeatilTstModel.h"
#import "FDAllModel.h"
#import "NSDictionary+Judge.h"

@implementation DetailModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.ok = [dic[@"ok"] intValue];
        
        self.msg = dic[@"msg"];
        
      
        
        
        if (self.ok == 1 && [dic[@"data"] isKindOfClass:[NSDictionary class]]>0) {
            
            NSDictionary *temdic = dic[@"data"];
            
            [self InfoRemarCountWithDic:temdic];
            
            [self detailWithDic:temdic];
            
            [self wayBillWithDic:temdic];
            
            [self bookWithDic:temdic];
            
            [self checkWithdic:temdic];
            
            [self textWithDic:temdic];
            
            [self AgentShartname:temdic];
            
            [self ControlWithDic:temdic];
            
            [self ABControlWithDic:temdic];
            
        }
        
    }
    
    return self;
}

//安检布控
- (void)ControlWithDic:(NSDictionary *)dic{
    
    if ([dic judgekeyAndValueWithKey:@"isSc"]) {
        
        if ([dic[@"isSc"] isEqualToString:@"1"]) {
            
            self.iscontrol = YES;
            
        }else{
            
            self.iscontrol = NO;
        }
        
    }else{
        self.iscontrol = NO;
    }
}

//安保布控
- (void)ABControlWithDic:(NSDictionary *)dic{
    
    if ([dic judgekeyAndValueWithKey:@"isTc"]) {
        
        if ([dic[@"isTc"] isEqualToString:@"1"]) {
            
            self.isABcontrol = YES;
            
        }else{
            
            self.isABcontrol = NO;
        }
        
    }else{
        self.isABcontrol = NO;
    }
}


//代理中文
- (void)AgentShartname:(NSDictionary *)dic{
    
    if ([dic judgekeyAndValueWithKey:@"agentShortName"]) {
        self.agentShortName = dic[@"agentShortName"];
    }else{
        self.agentShortName = @"";
    }
}

//详情
- (void)detailWithDic:(NSDictionary *)dic{
    
    
    if (dic[@"airwaybill"] !=Nil) {
        self.infomdel = [[infoModel alloc] initWithDic:dic[@"airwaybill"]];
    }else{
        self.infomdel = [[infoModel alloc] init];
    }
}

//分单
- (void)wayBillWithDic:(NSDictionary *)dic{
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *fdAllArray = [NSMutableArray array];

    
    if (dic[@"waybill"]!=Nil && [dic[@"waybill"] isKindOfClass:[NSArray class]] && [dic[@"waybill"] count] >0) {
        
        for (NSDictionary *temdic in dic[@"waybill"]) {
            WayBillModel *mdoel = [[WayBillModel alloc] initWithDic:temdic];
            [array addObject:mdoel];
        }
        
    }
    
    
    if (array.count>0) {//分单个数大于0添加总计
        //分单总计
     FDAllModel * allmdoel = [[FDAllModel alloc] initWithArray:array];
        
        [fdAllArray addObject:allmdoel];
    }
   
    self.waybillArray = [NSArray arrayWithArray:array];
    self.wayAllArray =  [NSArray arrayWithArray:fdAllArray];
    
}



//安检
- (void)checkWithdic:(NSDictionary *)dic{
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (dic[@"check"]!=Nil && [dic[@"check"] isKindOfClass:[NSArray class]] && [dic[@"check"] count] >0) {
        
        for (NSDictionary *temdic in dic[@"check"]) {
            CheckModel *mdoel = [[CheckModel alloc] initWithDic:temdic];
            [array addObject:mdoel];
        }
        
    }
    
    self.checkArray = [NSArray arrayWithArray:array];
    
    
}

//证书
- (void)bookWithDic:(NSDictionary *)dic{
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *canuserarray = [NSMutableArray array];
    
    if (dic[@"books"]!=Nil && [dic[@"books"] isKindOfClass:[NSArray class]] && [dic[@"books"] count] >0) {
        
        for (NSDictionary *temdic in dic[@"books"]) {
            DetailBook *mdoel = [[DetailBook alloc] initWithDic:temdic];
            
            [array addObject:mdoel];

            if([mdoel.checkVisual isEqualToString:@"1"] && [mdoel.bookCheckType isEqualToString:@"book"]) {//可显示证书
                [canuserarray addObject:mdoel];
            }
        }
        
    }
    
    self.bookArray = [NSArray arrayWithArray:array];
    self.canUseBookArray = [NSArray arrayWithArray:canuserarray];
    
    
}

#pragma mark------------------------------------------------------------------------------------

//测字
- (void)textWithDic:(NSDictionary *)dic{
    
    if (dic[@"waybillStatus"] !=Nil) {
        
        self.testModel = [[DeatilTstModel alloc] initWithDic:dic[@"waybillStatus"]];
        
    }else{
        self.testModel = [[DeatilTstModel alloc] init];
    }
    
    
}

//信息count
- (void)InfoRemarCountWithDic:(NSDictionary *)dic{
    
    if (dic[@"count"]!=Nil) {
        self.count = [dic[@"count"] integerValue];
    }else{
        self.count = 0;
    }
}


@end

//
//  ScanNetViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanNetViewModel.h"
#import "ScanModel.h"
#import "FlyHttpTools.h"

@implementation ScanNetViewModel

//扫描请求数据状态
- (void)loaddataWithMachID:(NSString *)machID
                    number:(NSString *)number
                   TypeStr:(NSString *)typeStr
                     start:(ScanStartBlock)start
                   success:(ScanSuccessModelBlock)success
                      fail:(ScanFailBlock)fail{
    
    start();
    
    NSDictionary *updic = @{
                            @"waybillno":number,
                            @"machineId":machID
                            };
    
    NSString *interface;
    
    if ([typeStr isEqualToString:@"0"]) {//首检
        interface = @"/api/pactl/check/checkStatus";
    }else if ([typeStr isEqualToString:@"1"]){//24小时
        interface = @"/api/pactl/checks/checkStatus";
    }else if ([typeStr isEqualToString:@"2"]){
        interface = @"/api/pactl/check/9610/checkStatus";
    }
    
    [FlyHttpTools postWithJsonDic:updic interface:interface success:^(NSDictionary *dic) {
        
        if ([dic[@"ok"] integerValue] == 1) {
            
            ScanModel *model = [[ScanModel alloc] initWithDic:dic[@"data"]];
            ScanBillModel *billModel = [ScanBillModel new];
            billModel.waybill = model;
            success(billModel);
        
        }else{
            fail(dic[@"msg"]);
        }
        
      
        FlyLog(@"%@",dic);
        
    } failure:^(NSString *NetFailReason) {
        
        fail(NetFailReason);
    }];

}

/// 查验单
- (void)loaddataWitNumber:(NSString *)number
                      start:(ScanStartBlock)start
                    success:(ScanCheckSuccessModelBlock)success
                     fail:(ScanFailBlock)fail{
    start();
    
    NSDictionary *updic = @{
                            @"waybillno":number
                            };
    NSString *interface = @"/api/pactl/check/9610/getWaybillINfoBySubNo";
    [FlyHttpTools postWithJsonDic:updic interface:interface success:^(NSDictionary *dic) {
        
        if ([dic[@"ok"] integerValue] == 1) {
            NSArray *dataArr = [ScanBillModel convertModelWithJsonArr:dic[@"data"]];
            success(dataArr);
        }else{
            fail(dic[@"msg"]);
        }
        FlyLog(@"%@",dic);
        
    } failure:^(NSString *NetFailReason) {
        
        fail(NetFailReason);
    }];
}


//保存
- (void)saveEventWithMachID:(NSString *)machID
                  listArray:(NSArray *)listarray
                    TypeStr:(NSString *)typeStr
                      start:(SaveScanStartBlock)start
                    success:(SaveScanSuccessModelBlock)success
                       fail:(SaveScanFailBlock)fail{
    
   
    start();
    NSDictionary *updic;
    NSString *interface;
    
    if ([typeStr isEqualToString:@"0"]) {//首检
        updic  = @{
                   @"machine":machID,
                   @"mac":machID,
                   @"list":listarray
                   };
        
        interface = @"/api/pactl/check/checkMsg";
        
    }else if ([typeStr isEqualToString:@"1"]){//24小时
        updic  = @{
                   @"machineId":machID,
                   @"mac":machID,
                   @"list":listarray
                   };
        interface = @"/api/pactl/checks/checkmsg";

    }else if ([typeStr isEqualToString:@"2"]){//9610系统
        updic  = @{
        @"machine":machID,
        @"mac":machID,
        @"list":listarray
        };
        interface = @"/api/pactl/check/9610/checkMsg";
    }
    
 
    
    [FlyHttpTools postWithJsonDic:updic interface:interface success:^(NSDictionary *dic) {
        
        if ([dic[@"ok"] intValue] == 1) {
            
            NSDictionary *temdic = dic[@"data"];
            NSString *numStr = [temdic[@"num"] stringValue];
            success(numStr);
            
        }else{
            fail(dic[@"msg"]);
        }
        FlyLog(@"%@",dic);
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}


-(void)saveCheckActionWithAwId:(NSString *)AwId
                    refResult:(NSString *)refResult
                        start:(SaveScanStartBlock)start
                      success:(ScanCheckSuccessModelBlock)success
                        fail:(SaveScanFailBlock)fail{
    
    start();
    NSMutableDictionary *updic = [NSMutableDictionary dictionary];
    if (![BaseVerifyUtils isNullOrSpaceStr:refResult] ) {
        [updic setValue:refResult forKey:@"refResult"];
    }
    if (![BaseVerifyUtils isNullOrSpaceStr:AwId] ) {
        [updic setValue:AwId forKey:@"awId"];
    }
    NSString *interface = @"/api/pactl/check/9610/updateSubRefResult";
       
    [FlyHttpTools postWithJsonDic:updic interface:interface success:^(NSDictionary *dic) {
           
           if ([dic[@"ok"] intValue] == 1) {
               
//               NSDictionary *temdic = dic[@"data"];
               success(@"");
               
           }else{
               fail(dic[@"msg"]);
           }
           FlyLog(@"%@",dic);
    } failure:^(NSString *NetFailReason) {
           fail(NetFailReason);
    }];
    
}
@end

//
//  AddCerNetViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/13.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddCerNetViewModel.h"
#import "FlyHttpTools.h"
#import "SelctCerAllModel.h"
#import "FirstModel.h"
#import "SelectCerModel.h"

@implementation AddCerNetViewModel

- (void)loadDataWithBookNo:(NSString *)BookNo
                      aWID:(NSString *)aWID
               agentOprnId:(NSString *)agentOprnId
                   airCode:(NSString *)airCode
                     start:(AddCerStartBlock)start
                   success:(AddCerSuccessBlock)success
                      fail:(AddCerFailBlock)fail{
    
    start();
    
    NSDictionary *updic = @{
                            @"bookNo":BookNo,
                            @"agentOprnId":agentOprnId,
                            @"airCode":airCode,
                            @"awId":aWID,
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/getBook" success:^(NSDictionary *dic) {
        
        SelctCerAllModel *allmdoel = [[SelctCerAllModel alloc] initWithdic:dic];
        success(allmdoel);
        FlyLog(@"%@",dic);
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}



- (void)saveDataWithaWID:(NSString *)aWID
                SelectCerModel:(SelectCerModel *)model
                         start:(SaveCerStartBlock)start
                       success:(SaveCerSuccessBlock)success
                          fail:(SaveCerfailBlock)fail{
    
    
    start();
    NSDictionary *upneedDIc;
    
    if (model.ID == nil) {
        
        upneedDIc = @{
                      
                      @"awId":aWID,
                      @"bookCheckType":model.bookCheckType,
                      @"bookId":model.bookId,
                      @"bookNo":model.bookNo,
                      @"bookType":model.booktype,
                      @"deviceId":model.deviceID,
                      @"ocId":model.ocId,
                      @"officeCode":model.officeCode,
                      @"officeName":model.officeName,
                      };
    }else{
        upneedDIc = @{
                      
                      @"awId":aWID,
                      @"bookCheckType":model.bookCheckType,
                      @"bookId":model.bookId,
                      @"bookNo":model.bookNo,
                      @"bookType":model.booktype,
                      @"deviceId":model.deviceID,
                      @"ocId":model.ocId,
                      @"officeCode":model.officeCode,
                      @"officeName":model.officeName,
                      @"id":model.ID
                      };
    }
    
    NSDictionary *updic = @{
                            @"book":upneedDIc
                            
                            };
    
    NSArray *array = @[updic];
    
    [FlyHttpTools postWithArray:array interface:@"/api/pactl/check/addbook" success:^(NSDictionary *dic) {

        if ([dic[@"ok"] integerValue] == 1) {
            success();
        }else{
            fail(dic[@"msg"]);
        }
        
        FlyLog(@"%@",dic);
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}
@end

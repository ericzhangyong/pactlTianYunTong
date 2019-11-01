//
//  FirstNetViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/4/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "FirstNetViewModel.h"
#import "FirstAllModel.h"
#import "FlyHttpTools.h"
#import "FlyView.h"
#import "LoadDataFailView.h"
#import "FirstModel.h"
#import "SelectStateModel.h"
#import "ClickControlAllModel.h"

@implementation FirstNetViewModel

- (void)loadDataWithView:(UIView *)view MachId:(NSString *)machId agentName:(NSString *)agentname success:(FirstSuccessBLock)success failStr:(FirstFailBlock)failStr{

    [FlyView showFlyViewFromSuperView:view];
    
    NSDictionary *updic = @{
                            @"machine":machId,
                            @"agentOprn":agentname
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/checkMsg" success:^(NSDictionary *dic) {
        
        FirstAllModel *allmodel = [[FirstAllModel alloc] initWIthDic:dic];
        
        [FlyView removeFlyViewFromSuperView:view];

        success(allmodel);
        FlyLog(@"%@",updic);
        
    } failure:^(NSString *NetFailReason) {
        
        [FlyView removeFlyViewFromSuperView:view];
        
        failStr(NetFailReason);
    }];
    
}


#pragma mark------------------------------------------------------------------------------------
//保存点击状态
- (void)updateCheckWithArray:(NSMutableArray *)array machineID:(NSString *)machinID start:(FirstOperationStartBlock)start success:(FirstOperationSuceessBlock)success fail:(FirstOperationFailBlcok)fail Failreason:(FirstOperationNetFailBlock)FailReason{
    
    start();
    
    
    NSMutableArray *Uparray = [NSMutableArray array];
    
    if (array.count >0) {
        
        for ( FirstModel *model in array) {
            
            NSDictionary *dic = @{
                                  @"awId":model.awId,
                                  @"fstatus":model.LocalstateModel.state,
                                  @"machine":machinID,
                                  @"id":model.ID
                                  };
            
            [Uparray addObject:dic];
            
        }
        
    }
    
    NSArray *needUparray = [NSArray arrayWithArray:Uparray];
    
    [FlyHttpTools postWithArray:needUparray interface:@"/api/pactl/check/updateByWaybillList" success:^(NSDictionary *dic) {
        
        FlyLog(@"保存----%@",dic);
        
        if ([dic[@"ok"] integerValue] == 1) {
            
            NSDictionary *dataDic = dic[@"data"];
            if ([dataDic[@"falseNo"] isEqualToString:@""]) {
                success();

            }else{
                FailReason(dataDic[@"falseNo"]);

            }
            
        }else{
            FailReason(dic[@"msg"]);
        }
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
    
    
    
}


#pragma mark------------------------------------------------------------------------------------
//刷新列表
- (void)FreshDataListWitMachId:(NSString *)machId agentName:(NSString *)agentname success:(FirstSuccessBLock)success failStr:(FirstFailBlock)failStr{
    
    NSDictionary *updic = @{
                            @"machine":machId,
                            @"agentOprn":agentname
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/checkMsg" success:^(NSDictionary *dic) {
        
        FirstAllModel *allmodel = [[FirstAllModel alloc] initWIthDic:dic];
        
        success(allmodel);
        FlyLog(@"%@",dic);
        
    } failure:^(NSString *NetFailReason) {
        
        failStr(NetFailReason);
        
    }];
    
}


#pragma mark------------------------------------------------------------------------------------
//取消
- (void)CanCelStateWithModel:(FirstModel *)model  machineID:(NSString *)machinID start:(FirstOperationStartBlock)start success:(FirstOperationSuceessBlock)success fail:(FirstOperationFailBlcok)fail  Failreason:(FirstOperationNetFailBlock)FailReason{
    
    start();
    
    NSDictionary *updic = @{
                          @"awId":model.awId,
                          @"machineId":machinID,
                          @"id":model.ID
                          };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/delCheckStatus" success:^(NSDictionary *dic) {
        
        if ([dic[@"ok"] integerValue] == 1) {
            
            success();
            
        }else{
            FailReason(dic[@"msg"]);
        }
        
        FlyLog(@"取消状态---%@",dic);
        
    } failure:^(NSString *NetFailReason) {
        
        fail(NetFailReason);
    }];
}

#pragma mark------------------------------------------------------------------------------------
//删除订单
- (void)deleteDataWithModel:(FirstModel *)model
                   machinID:(NSString *)machID
                      start:(FirstOperationStartBlock)start
                    success:(FirsDeleteSuccess)success
                       fail:(FirsDeleteFail)fail{
    
    
    start();
    
    NSDictionary *updic = @{
                            @"awId":model.awId,
                            @"machine":machID,
                            @"id":model.ID
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/checkmsgr" success:^(NSDictionary *dic) {
        
        FlyLog(@"%@",dic);
        
        if ([dic[@"ok"] integerValue] == 1) {

            success(dic[@"data"]);
        }else{
            
            fail(dic[@"msg"]);
            
        }
        
    } failure:^(NSString *NetFailReason) {
        
        fail(NetFailReason);
    }];
}

//点击通过
- (void)clickAgreeWithArray:(NSArray *)Array
                      start:(FirstClickAgreeStartBlock)start
                    Success:(FirstClickAgreeSuccessBlock)success
                       fail:(FirstClickAgreeFailBlock)fail{
    start();
    
    NSMutableArray *datarray = [NSMutableArray array];
    
    for (FirstModel *model in Array) {
        [datarray addObject:model.awId];
    }
    
    NSArray *uparray = [NSArray arrayWithArray:datarray];
    
    [FlyHttpTools postWithArray:uparray interface:@"/api/pactl/scheck/contol" success:^(NSDictionary *dic) {
        
        ClickControlAllModel *allmodel = [[ClickControlAllModel alloc] initWithDic:dic];
        
        if (allmodel.ok == 1) {
            success(allmodel.array);
        }else{
            fail(allmodel.msg);
        }
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}

@end

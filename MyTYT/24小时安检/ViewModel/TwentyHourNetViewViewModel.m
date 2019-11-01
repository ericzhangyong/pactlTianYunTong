//
//  TwentyHourNetViewViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TwentyHourNetViewViewModel.h"
#import "FlyHttpTools.h"
#import "FlyView.h"
#import "TwentyAllModel.h"
#import "TwentyModel.h"
#import "TwentyLocalInfoModel.h"
#import "SelectStateModel.h"
#import "RoadModel.h"
#import "TwentyMachineModel.h"
#import "ClickControlAllModel.h"

@implementation TwentyHourNetViewViewModel

//加载数据
- (void)loadDataWithView:(UIView *)view
                  MachId:(NSString *)machId
               agentName:(NSString *)agentname
                 success:(TwentySuccessBlock)success
                 failStr:(TwentyFailBlock)failStr{
    
    
    [FlyView showFlyViewFromSuperView:view];
    
    NSDictionary *updic = @{
                            @"machineId":machId,
                            @"mac": machId,
                            @"agentOprn":agentname
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/checks/checkmsg" success:^(NSDictionary *dic) {
        
        TwentyAllModel *allmodel = [[TwentyAllModel alloc] initWIthDic:dic];
        
        [FlyView removeFlyViewFromSuperView:view];
        
        FlyLog(@"%@",updic);
        
        success(allmodel);
        
    } failure:^(NSString *NetFailReason) {
        
        [FlyView removeFlyViewFromSuperView:view];
        
        failStr(NetFailReason);
    }];
    
}

//取消网络状态
- (void)CanCelStateWithaWID:(NSString *)aWID
                  machineID:(NSString *)machinID
                      start:(TwentyOperationStartBlock)start
                    success:(TwentyOperationSuceessBlock)success
                       fail:(TwentyOperationFailBlcok)fail{
    
    
    start();
    
    NSDictionary *updic = @{
                            @"awId":aWID,
                            @"machineId":machinID
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/checks/delCheckStatus" success:^(NSDictionary *dic) {
        
        if ([dic[@"ok"] integerValue] == 1) {
            
            success();
            
        }else{
            fail(dic[@"msg"]);
        }
        
        FlyLog(@"取消状态---%@",dic);
        
    } failure:^(NSString *NetFailReason) {
        
        fail(NetFailReason);
    }];
}

//保存数据
- (void)updateCheckWithArray:(NSMutableArray *)array
                   machineID:(NSString *)machinID
                       start:(TwentyOperationStartBlock)start
                     success:(TwentyOperationSuceessBlock)success
                        fail:(TwentyOperationFailBlcok)fail
               SpecilFailMsg:(TwentySaveSpecilFailmsgBlock)failMsg{
    
    start();
    
    
    NSMutableArray *Uparray = [NSMutableArray array];
    
    if (array.count >0) {
        
        for (TwentyModel *model in array) {
            
            NSDictionary *dic = @{
                                  @"awId":model.awId,
                                  @"fstatus":[model.LocalstateModel.state isEqualToString:@""] ? model.fstatus : model.LocalstateModel.state,
                                  @"machine":machinID,
                                  @"aislecount":model.infoModel.aislecount,
                                  @"machine24":model.infoModel.machine24,
                                  @"aisle24":model.infoModel.roadModel.ID,
                                  @"mcid":model.infoModel.machineModel.ID
                                  };
            
            [Uparray addObject:dic];
            
        }
        
    }
    
    NSArray *needUparray = [NSArray arrayWithArray:Uparray];
    
    
    
    [FlyHttpTools postWithArray:needUparray interface:@"/api/pactl/checks/updateByWaybillList" success:^(NSDictionary *dic) {
        
        FlyLog(@"保存----%@",dic);
        
        if ([dic[@"ok"] integerValue] == 1) {
            
            if (![dic[@"msg"] isEqualToString:@"ok"]) {
                
                failMsg(dic[@"msg"]);
                
            }else{
                
                NSDictionary *dataDic = dic[@"data"];
                
                if ([dataDic[@"falseNo"] isEqualToString:@""]) {
                    
                    success();
                    
                }else{
                
                fail(dataDic[@"falseNo"]);
                
                     }

        }
            
        }else{
            failMsg(dic[@"msg"]);
        }
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
    
}

//刷新列表
- (void)FreshDataListWitMachId:(NSString *)machId
                     agentName:(NSString *)agentname
                       success:(TwentySuccessBlock)success
                       failStr:(TwentyFailBlock)failStr{
    
    NSDictionary *updic = @{
                            @"machineId":machId,
                            @"mac": machId,
                            @"agentOprn":agentname
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/checks/checkmsg" success:^(NSDictionary *dic) {
        
        TwentyAllModel *allmodel = [[TwentyAllModel alloc] initWIthDic:dic];
        
        FlyLog(@"%@",updic);
        
        success(allmodel);
        
    } failure:^(NSString *NetFailReason) {
        
        failStr(NetFailReason);
    }];
    
}


//删除订单
- (void)deleteDataWithaWID:(NSString *)aWID
                  machinID:(NSString *)machID
                     start:(TwentyOperationStartBlock)start
                   Success:(TwentyDeleteSuccess)success
                      fail:(TwentyDeletefail)fail{
    
    start();
    
    NSDictionary *updic = @{
                            @"awId":aWID,
                            @"machine":machID,
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/checks/checkmsgr" success:^(NSDictionary *dic) {
        
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
                      start:(TwentyClickAgreeStartBlock)start
                    Success:(TwentyClickAgreeSuccessBlock)success
                       fail:(TwentyClickAgreeFailBlock)fail{
    start();
    
    NSMutableArray *datarray = [NSMutableArray array];
    
    for (TwentyModel *model in Array) {
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

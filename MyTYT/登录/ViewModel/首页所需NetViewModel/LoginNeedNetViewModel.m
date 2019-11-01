//
//  LoginNeedNetViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LoginNeedNetViewModel.h"
#import "FlyHttpTools.h"
#import "LoginModel.h"
#import "AllModel.h"
#import "DeviceModel.h"
#import "TestModel.h"
#import "OperationMachinModel.h"
#import "LastLoginTimeModel.h"
#import "TwentyForuHourRoadModel.h"
#import "TwentyMachineAllModel.h"

@implementation LoginNeedNetViewModel

- (void)loadWithAllModel:(AllModel *)allmodel success:(NeedLoadSuccessBlock)succcess fail:(NeedFailBlock)fail{
    
    
    __block LastLoginTimeModel *lastTimerModel = nil;
    __block OperationMachinModel *operationModel = nil;
    __block TestModel *textmodel = nil;
    __block TwentyForuHourRoadModel *hourModel = nil;
    __block TwentyMachineAllModel *machineModel = nil;
    
    __block NSString *LastTimeError = nil;
    __block NSString *operationError = nil;
    __block NSString *textError = nil;
    __block NSString *HourError = nil;
    __block NSString *machineErroe = nil;

    dispatch_group_t group = dispatch_group_create();
    
    
    ////////////////////////时间
    dispatch_group_enter(group);
    
    [FlyHttpTools postWithStr:[NSString stringWithFormat:@"%ld",allmodel.loginmdoel.PersonID] interface:@"/api/pactl/comm/get/login/date" success:^(NSDictionary *dic) {
        
        FlyLog(@"时间---%@",dic);
        lastTimerModel = [[LastLoginTimeModel alloc] initWirhDic:dic];
        
        dispatch_group_leave(group);
        
    } failure:^(NSString *NetFailReason) {
        
        LastTimeError = NetFailReason;
        dispatch_group_leave(group);
        
    }];
    
    
    ////////////////////////货站名称
    dispatch_group_enter(group);
    
    
    NSDictionary *updic = @{
                            @"machineId":allmodel.deviceModel.machinID
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/queryCargo" success:^(NSDictionary *dic) {
       
        FlyLog(@"货站---%@",dic);
        operationModel = [[OperationMachinModel alloc] initWirhDic:dic];
        dispatch_group_leave(group);
        
        
    } failure:^(NSString *NetFailReason) {
        
        operationError = NetFailReason;
        dispatch_group_leave(group);
        
    }];
    
    
    ////////////////////////测字
    dispatch_group_enter(group);
    
    [FlyHttpTools postWithStr:@"informalRule" interface:@"/api/pactl/comm/item" success:^(NSDictionary *dic) {
       
        FlyLog(@"测字---%@",dic);
        textmodel = [[TestModel alloc] initWirhDic:dic];
        dispatch_group_leave(group);
        
    } failure:^(NSString *NetFailReason) {
        
        textError = NetFailReason;
        dispatch_group_leave(group);
        
    }];
    
    
    ////////////////////////24小时通道
    dispatch_group_enter(group);
    
    
    NSDictionary *updic2 = @{
                            
                            };
    
    [FlyHttpTools postWithJsonDic:updic2 interface:@"/api/pactl/scheck/getPAisles" success:^(NSDictionary *dic) {
        
        FlyLog(@"24小时通道---%@",dic);
        hourModel = [[TwentyForuHourRoadModel alloc] initWithDic:dic];
        dispatch_group_leave(group);
        
    } failure:^(NSString *NetFailReason) {
        
        HourError = NetFailReason;
        dispatch_group_leave(group);
    }];
    
    ////////////////////////安检机(24小时)
    dispatch_group_enter(group);
    
    
    NSDictionary *updicmachin = @{
                             
                               };
    
    [FlyHttpTools postWithJsonDic:updicmachin interface:@"/api/pactl/scheck/getMachines" success:^(NSDictionary *dic) {
        
        FlyLog(@"安检机---%@",dic);
        machineModel = [[TwentyMachineAllModel alloc] initWithDic:dic];
        dispatch_group_leave(group);
        
    } failure:^(NSString *NetFailReason) {
        
        machineErroe = NetFailReason;
        dispatch_group_leave(group);
    }];
    
    
    ////////////////////////线程同步
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        if ( (LastTimeError != nil) || (operationError != nil) || (textError != nil) || (HourError != nil) || (lastTimerModel.ok != 1) || (textmodel.ok != 1) ) {//有错误，或者返回ok不等于1

            if ( LastTimeError != nil ) {
                
                fail(LastTimeError);
                
            }else if ( operationError != nil ){
                
                fail(operationError);
                
            }else if ( textError != nil ){
                
                fail(textError);

                
            }else if ( HourError != nil ){
                
                fail(HourError);

        
            }else if ( machineErroe != nil ){
                
                fail(machineErroe);
                
                
            }else if ( lastTimerModel.ok != 1 ){
                
                fail(lastTimerModel.msg);
                
            }else if ( textmodel.ok != 1 ){
                
                fail(textmodel.msg);
            }
            
        }else{
            
            allmodel.lasttimeModel = lastTimerModel;
            allmodel.operationModel = operationModel;
            allmodel.textModel = textmodel;
            allmodel.RoadModel = hourModel;
            allmodel.machineAllModel = machineModel;
            
            succcess(allmodel);
        }
        
        FlyLog(@"全部请求结束");
    });
}



@end

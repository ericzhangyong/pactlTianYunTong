//
//  DetailYDNetViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailYDNetViewModel.h"
#import "FlyHttpTools.h"
#import "FirstModel.h"
#import "FlyView.h"
#import "GPModel.h"
#import "DetailModel.h"
#import "DeviceModel.h"

@implementation DetailYDNetViewModel

- (void)loadDataWithView:(UIView *)superView
                    aWID:(NSString *)aWID
             deviceModel:(DeviceModel *)deviceModel
                    type:(NSString *)type
                 success:(DetailLoadSuccessBlock)success
                    fail:(DetailLoadFailBlock)fail{
    
    __block NSString *GPerror = nil;
    __block NSString *detailError = nil;
    
    __block GPModel *gpmodel = nil;
    __block DetailModel *detailmodel = nil;
    
    dispatch_group_t Detailgroup = dispatch_group_create();
    
    [FlyView showFlyViewFromSuperView:superView];
    
    NSDictionary *updic = @{
                            @"awId":aWID
                            };
    
    
    dispatch_group_enter(Detailgroup);
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/other/changed/detail" success:^(NSDictionary *dic) {
        
        FlyLog(@"改配信息%@",dic);

       gpmodel = [[GPModel alloc] initWithdic:dic];
        
        dispatch_group_leave(Detailgroup);
        
    } failure:^(NSString *NetFailReason) {
        GPerror = NetFailReason;
        dispatch_group_leave(Detailgroup);

    }];
    
    
    NSDictionary *DetailDic;
    
    if ([type isEqualToString:@"0"]) {
        
       DetailDic = @{
            @"awId":aWID,
            @"machineId":deviceModel.machinID
            };
        
    }else if([type isEqualToString:@"1"]){
        
        DetailDic = @{
                      @"awId":aWID,
                      @"machineId":deviceModel.machinID,
                      @"type24hFlag":@"1"
                      };
    }
    
  
    
    dispatch_group_enter(Detailgroup);
    
    [FlyHttpTools postWithJsonDic:DetailDic interface:@"/api/pactl/checks/waybill" success:^(NSDictionary *dic) {
        
        FlyLog(@"详细信息%@",dic);
        
        detailmodel = [[DetailModel alloc] initWithDic:dic];
        
        dispatch_group_leave(Detailgroup);

        
    } failure:^(NSString *NetFailReason) {
        
        detailError = NetFailReason;
        dispatch_group_leave(Detailgroup);

    }];
    
    
    dispatch_group_notify(Detailgroup, dispatch_get_main_queue(), ^{
        [FlyView removeFlyViewFromSuperView:superView];
        
        if (GPerror!=nil || detailError!=nil || gpmodel.ok !=1 || detailmodel.ok !=1 ) {
            
            if (GPerror !=nil) {
                fail(GPerror);
            }else if (detailError !=nil){
                fail(detailError);
            }else if (gpmodel.ok !=1){
                fail(gpmodel.msg);
            }else if (detailmodel.ok !=1){
                fail(gpmodel.msg);
            }
            
        }else{
            success(gpmodel,detailmodel);
        }
    });
   
}


@end

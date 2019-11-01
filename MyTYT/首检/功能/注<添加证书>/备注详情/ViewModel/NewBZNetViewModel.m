//
//  NewBZNetViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "NewBZNetViewModel.h"
#import "FlyView.h"
#import "FlyHttpTools.h"
#import "newBZALLModel.h"
#import "NewBZModel.h"
#import "BZCerModel.h"
#import "DeviceModel.h"

@implementation NewBZNetViewModel

//加载数据
//加载数据
- (void)loadDataWithViewModel:(UIView *)superView
                         aWID:(NSString *)aWID
                         Type:(NSString *)type
                  deviceModel:(DeviceModel *)deviceModel
                      success:(BZSuccessBlock)success
                         fail:(BZFailBlock)fail{

    
    [FlyView showFlyViewFromSuperView:superView];
    
    NSDictionary *updic;
    NSString *interFace;
    
    if ([type isEqualToString:@"0"]) {
        
        updic = @{
                  @"awId":aWID,
                  @"machineId":deviceModel.machinID
                  };
        interFace = @"/api/pactl/check/getRemrak";
        
    }else if([type isEqualToString:@"1"]){
        
        updic = @{
                  @"awId":aWID,
                  @"machine":deviceModel.machinID,
                  @"type24hFlag":@"1",
                  };
        interFace = @"/api/pactl/checks/getRemrak";
    }
   
    
    
    
    [FlyHttpTools postWithJsonDic:updic interface:interFace success:^(NSDictionary *dic) {
        
        
        [FlyView removeFlyViewFromSuperView:superView];

        newBZALLModel *model = [[newBZALLModel alloc] initWithDic:dic];
                
        FlyLog(@"%@",dic);
   
        success(model);
        
        
    } failure:^(NSString *NetFailReason) {
        
        [FlyView removeFlyViewFromSuperView:superView];
        fail(NetFailReason);
    }];
}



#pragma mark------------------------------------------------------------------------------------
//删除证书
- (void)deleteCerWithCerModel:(BZCerModel *)model
                         aWID:(NSString *)aWID
                        start:(BZDeleteCerStartBlock)start
                      success:(BZDeleteCerSuccessBlock)success
                         fail:(BZDeleteCerFailBlock)fail{
    
    start();
    
    
    NSDictionary *updic = @{
                            @"awId":aWID,
                            @"bookNo":model.bookNo,
                            @"ocId":model.ocId,
                            @"id":model.ID
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/deletedBook" success:^(NSDictionary *dic) {
        if ([dic[@"ok"] integerValue] == 1) {
            success(dic[@"data"]);
        }else{
            fail(dic[@"msg"]);
        }
        
        FlyLog(@"%@",dic);
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);

    }];
    
}

@end

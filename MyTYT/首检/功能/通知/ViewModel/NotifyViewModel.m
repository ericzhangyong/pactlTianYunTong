//
//  NotifyViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "NotifyViewModel.h"
#import "FlyHttpTools.h"
#import "NotifiModel.h"

@implementation NotifyViewModel

- (void)notifyWithModel:(NotifiModel *)model MachID:(NSString *)MAchID success:(NotiFySuccessBlock)success fail:(NotiFyFailBlock)fail{
    
    NSString *status;
    
    if ([model.status isEqualToString:@"1"]) {
       status  = @"0";
    }else if ([model.status isEqualToString:@"0"]){
        status = @"1";
    }
    
    NSNumber *statesNumber = [NSNumber numberWithInt:[status intValue]];
    
    NSDictionary *updic = @{
                            @"machineId":MAchID,
                            @"id":model.ID,
                            @"status":statesNumber
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/updateNotice" success:^(NSDictionary *dic) {
        
        FlyLog(@"%@",dic);
        
        if ([dic[@"ok"] integerValue] == 1) {
            success();
        }else{
            fail(dic[@"msg"]);
        }
        
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
        
    }];
    
}


@end

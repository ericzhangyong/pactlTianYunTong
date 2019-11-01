//
//  QueryShareNetViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QueryShareNetViewModel.h"
#import "FlyHttpTools.h"
#import "SelctCerAllModel.h"

@implementation QueryShareNetViewModel

- (void)queryShareCerBookNo:(NSString *)bookNo
                   suuccess:(QuerySuccessBlock)success
                       fail:(QueryFailBlock)fail{
    
    NSDictionary *updic = @{
                            @"bookNo":bookNo
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/shareBooks" success:^(NSDictionary *dic) {
        
        FlyLog(@"%@",dic);
        
        SelctCerAllModel *allmdoel = [[SelctCerAllModel alloc] initWithdic:dic];
        success(allmdoel);
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
    
    
    
}

@end

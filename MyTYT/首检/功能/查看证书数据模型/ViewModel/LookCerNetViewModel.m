//
//  LookCerNetViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LookCerNetViewModel.h"
#import "FlyHttpTools.h"
#import "PDFImageModel.h"

@implementation LookCerNetViewModel

//查看证书
- (void)RequestCerImageArrayWithBookID:(NSString *)BookID
                                 start:(getPdfStartBlock)start
                               Success:(GetPDFSuccessBlodk)success
                                  fail:(GetPDFFailBlock)fail{
    start();
    
    NSDictionary *updic = @{
                            @"bookId":BookID
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/getBookPDF" success:^(NSDictionary *dic) {
        
        FlyLog(@"%@",dic);
        PDFImageModel *mdoel = [[PDFImageModel alloc] initWithDic:dic];
        
        success(mdoel);
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}


- (NSString *)MyExplainerror:(NSError *)error{
    
    if (error.code == NSURLErrorNotConnectedToInternet) {
        return @"请检查网络设置";
    }else if (error.code == NSURLErrorTimedOut){
        return @"请求超时";
    }else{
        return @"未知错误";
    }
    return nil;
}

@end

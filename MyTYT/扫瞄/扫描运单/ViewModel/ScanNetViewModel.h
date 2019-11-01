//
//  ScanNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScanModel;

typedef void(^ScanStartBlock)(void);
typedef void(^ScanSuccessModelBlock)(ScanModel *model);
typedef void(^ScanFailBlock)(NSString *failStr);

typedef void(^SaveScanStartBlock)(void);
typedef void(^SaveScanSuccessModelBlock)(NSString *numStr);
typedef void(^SaveScanFailBlock)(NSString *failStr);

@interface ScanNetViewModel : NSObject

//扫描请求数据状态
- (void)loaddataWithMachID:(NSString *)machID
                    number:(NSString *)number
                   TypeStr:(NSString *)typeStr
                     start:(ScanStartBlock)start
                   success:(ScanSuccessModelBlock)success
                      fail:(ScanFailBlock)fail;

//保存<0首检 1 24小时>
- (void)saveEventWithMachID:(NSString *)machID
                  listArray:(NSArray *)listarray
                    TypeStr:(NSString *)typeStr
                      start:(SaveScanStartBlock)start
                    success:(SaveScanSuccessModelBlock)success
                       fail:(SaveScanFailBlock)fail;


@end

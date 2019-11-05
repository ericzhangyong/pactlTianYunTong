//
//  ScanNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ScanModel.h"

typedef void(^ScanStartBlock)(void);
typedef void(^ScanSuccessModelBlock)(ScanBillModel *billModel);
typedef void(^ScanFailBlock)(NSString *failStr);
typedef void(^ScanCheckSuccessModelBlock)(id data);


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

/// 查验单
- (void)loaddataWitNumber:(NSString *)number
                      start:(ScanStartBlock)start
                    success:(ScanCheckSuccessModelBlock)success
                      fail:(ScanFailBlock)fail;


//保存<0首检 1 24小时>
- (void)saveEventWithMachID:(NSString *)machID
                  listArray:(NSArray *)listarray
                    TypeStr:(NSString *)typeStr
                      start:(SaveScanStartBlock)start
                    success:(SaveScanSuccessModelBlock)success
                       fail:(SaveScanFailBlock)fail;


/// 保存查验的借故欧
/// @param AwId AwId
/// @param refResult  通过pass 不合格 unqualified   暂扣 hold
/// @param start startblcok
/// @param success success description
/// @param fail fail description
-(void)saveCheckActionWithAwId:(NSString *)AwId
                     refResult:(NSString *)refResult
                         start:(SaveScanStartBlock)start
                       success:(ScanCheckSuccessModelBlock)success
                          fail:(SaveScanFailBlock)fail;


@end

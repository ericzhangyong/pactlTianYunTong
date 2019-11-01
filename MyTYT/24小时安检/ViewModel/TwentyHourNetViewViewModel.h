//
//  TwentyHourNetViewViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwentyAllModel;

typedef void(^TwentySuccessBlock)(TwentyAllModel *allModel);
typedef void(^TwentyFailBlock)(NSString *FailStr);


typedef void(^TwentyOperationStartBlock)(void);
typedef void(^TwentyOperationSuceessBlock)(void);
typedef void(^TwentyOperationFailBlcok)(NSString *failStr);

typedef void(^TwentyDeleteSuccess)(NSString *deleteSuccessStr);
typedef void(^TwentyDeletefail)(NSString *deletefailStr);

typedef void(^TwentySaveSpecilFailmsgBlock)(NSString *msg);


typedef void(^TwentyClickAgreeStartBlock)(void);
typedef void(^TwentyClickAgreeSuccessBlock)(NSArray *array);
typedef void(^TwentyClickAgreeFailBlock)(NSString *FailStr);

@interface TwentyHourNetViewViewModel : NSObject
/*
 加载页面
 */
- (void)loadDataWithView:(UIView *)view
                  MachId:(NSString *)machId
               agentName:(NSString *)agentname
                 success:(TwentySuccessBlock)success
                 failStr:(TwentyFailBlock)failStr;


//取消网络状态
- (void)CanCelStateWithaWID:(NSString *)aWID
                   machineID:(NSString *)machinID
                       start:(TwentyOperationStartBlock)start
                     success:(TwentyOperationSuceessBlock)success
                        fail:(TwentyOperationFailBlcok)fail;

//保存数据
- (void)updateCheckWithArray:(NSMutableArray *)array
                   machineID:(NSString *)machinID
                       start:(TwentyOperationStartBlock)start
                     success:(TwentyOperationSuceessBlock)success
                        fail:(TwentyOperationFailBlcok)fail
               SpecilFailMsg:(TwentySaveSpecilFailmsgBlock)failMsg;

//刷新列表
- (void)FreshDataListWitMachId:(NSString *)machId
                     agentName:(NSString *)agentname
                       success:(TwentySuccessBlock)success
                       failStr:(TwentyFailBlock)failStr;


//删除订单
- (void)deleteDataWithaWID:(NSString *)aWID
                   machinID:(NSString *)machID
                      start:(TwentyOperationStartBlock)start
                    Success:(TwentyDeleteSuccess)success
                      fail:(TwentyDeletefail)fail;


//点击通过
- (void)clickAgreeWithArray:(NSArray *)Array
                      start:(TwentyClickAgreeStartBlock)start
                    Success:(TwentyClickAgreeSuccessBlock)success
                       fail:(TwentyClickAgreeFailBlock)fail;
@end

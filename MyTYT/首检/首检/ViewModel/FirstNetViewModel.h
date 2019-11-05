//
//  FirstNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/4/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstAllModel;
@class  FirstModel;


typedef void(^FirstSuccessBLock)(FirstAllModel *firstAllModel);
typedef void(^FirstFailBlock)(NSString *failStr);

typedef void(^FirstOperationStartBlock)(void);
typedef void(^FirstOperationSuceessBlock)(void);
typedef void(^FirstOperationFailBlcok)(NSString *failStr);
typedef void(^FirstOperationNetFailBlock)(NSString *reason);

typedef void(^FirsDeleteSuccess)(NSString *deleteSuccessStr);
typedef void(^FirsDeleteFail)(NSString *deleteFailStr);

typedef void(^FirstClickAgreeStartBlock)(void);
typedef void(^FirstClickAgreeSuccessBlock)(NSArray *array);
typedef void(^FirstClickAgreeFailBlock)(NSString *FailStr);

@interface FirstNetViewModel : NSObject

/*
 每次进入加载页面
*/
- (void)loadDataWithView:(UIView *)view
                  MachId:(NSString *)machId
               agentName:(NSString *)agentname
           detectionType:(DetectionType)detectionType
                 success:(FirstSuccessBLock)success
                 failStr:(FirstFailBlock)failStr;

//保存数据
- (void)updateCheckWithArray:(NSMutableArray *)array
                   machineID:(NSString *)machinID
                       start:(FirstOperationStartBlock)start
                     success:(FirstOperationSuceessBlock)success
                        fail:(FirstOperationFailBlcok)fail
                  Failreason:(FirstOperationNetFailBlock)FailReason;

//刷新列表
- (void)FreshDataListWitMachId:(NSString *)machId
                     agentName:(NSString *)agentname
                   dectionType:(DetectionType)detectionType
                       success:(FirstSuccessBLock)success
                       failStr:(FirstFailBlock)failStr;

//取消网络状态
- (void)CanCelStateWithModel:(FirstModel *)model
                   machineID:(NSString *)machinID
                       start:(FirstOperationStartBlock)start
                     success:(FirstOperationSuceessBlock)success
                        fail:(FirstOperationFailBlcok)fail
                  Failreason:(FirstOperationNetFailBlock)FailReason;

//删除订单
- (void)deleteDataWithModel:(FirstModel *)model
                   machinID:(NSString *)machID
                      start:(FirstOperationStartBlock)start
                     success:(FirsDeleteSuccess)success
                       fail:(FirsDeleteFail)fail;

//点击通过
- (void)clickAgreeWithArray:(NSArray *)Array
                      start:(FirstClickAgreeStartBlock)start
                    Success:(FirstClickAgreeSuccessBlock)success
                       fail:(FirstClickAgreeFailBlock)fail;
/*********************************************24小时*************************************/
@end

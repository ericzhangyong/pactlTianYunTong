//
//  AddCerNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/13.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SelctCerAllModel;
@class FirstModel;
@class SelectCerModel;

typedef void(^AddCerStartBlock)(void);
typedef void(^AddCerSuccessBlock)(SelctCerAllModel *allmodel);
typedef void(^AddCerFailBlock)(NSString *FailStr);

typedef void(^SaveCerSuccessBlock)(void);
typedef void(^SaveCerfailBlock)(NSString *failStr);
typedef void(^SaveCerStartBlock)(void);


@interface AddCerNetViewModel : NSObject

//查询证书信息
- (void)loadDataWithBookNo:(NSString *)BookNo
                      aWID:(NSString *)aWID
               agentOprnId:(NSString *)agentOprnId
               airCode:(NSString *)airCode
                     start:(AddCerStartBlock)start
                   success:(AddCerSuccessBlock)success
                      fail:(AddCerFailBlock)fail;

//保存证书
- (void)saveDataWithaWID:(NSString *)aWID
             SelectCerModel:(SelectCerModel *)model
                      start:(SaveCerStartBlock)start
                    success:(SaveCerSuccessBlock)success
                       fail:(SaveCerfailBlock)fail;


@end

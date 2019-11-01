//
//  NewBZNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class newBZALLModel;
@class BZCerModel;
@class NewBZModel;
@class DeviceModel;

typedef void(^BZSuccessBlock)(newBZALLModel *mdoel);
typedef void(^BZFailBlock)(NSString *FailStr);



typedef void(^BZDeleteCerStartBlock)(void);
typedef void(^BZDeleteCerSuccessBlock)(NSString *str);
typedef void(^BZDeleteCerFailBlock)(NSString *FailSrt);



@interface NewBZNetViewModel : NSObject

//加载数据<0.首检 1.24小时>
- (void)loadDataWithViewModel:(UIView *)superView
                     aWID:(NSString *)aWID
                         Type:(NSString *)type
                  deviceModel:(DeviceModel *)deviceModel
                      success:(BZSuccessBlock)success
                         fail:(BZFailBlock)fail;
//删除证书
- (void)deleteCerWithCerModel:(BZCerModel *)model
                         aWID:(NSString *)aWID
                        start:(BZDeleteCerStartBlock)start
                      success:(BZDeleteCerSuccessBlock)success
                         fail:(BZDeleteCerFailBlock)fail;



@end

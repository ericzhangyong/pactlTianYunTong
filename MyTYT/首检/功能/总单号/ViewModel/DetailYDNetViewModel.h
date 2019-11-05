//
//  DetailYDNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPModel;
@class DetailModel;
@class DeviceModel;

typedef void(^DetailLoadSuccessBlock)(GPModel *gpModel,DetailModel *detailModel);
typedef void(^DetailLoadFailBlock)(NSString *FailStr);

@interface DetailYDNetViewModel : NSObject

//加载信息<0首检 1 24小时 2：9610>
- (void)loadDataWithView:(UIView *)superView
                    aWID:(NSString *)aWID
             deviceModel:(DeviceModel *)deviceModel
                    type:(NSString *)type
                 success:(DetailLoadSuccessBlock)success
                    fail:(DetailLoadFailBlock)fail;

@end

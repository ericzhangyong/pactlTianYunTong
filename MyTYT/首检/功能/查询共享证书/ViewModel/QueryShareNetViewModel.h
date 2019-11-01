//
//  QueryShareNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelctCerAllModel;

typedef void(^QuerySuccessBlock)(SelctCerAllModel *allModel);
typedef void(^QueryFailBlock)(NSString *FailStr);

@interface QueryShareNetViewModel : NSObject

//加载信息
- (void)queryShareCerBookNo:(NSString *)bookNo
                     suuccess:(QuerySuccessBlock)success
                         fail:(QueryFailBlock)fail;

@end

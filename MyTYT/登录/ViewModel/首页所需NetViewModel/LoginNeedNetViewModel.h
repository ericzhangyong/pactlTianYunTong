//
//  LoginNeedNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AllModel;

typedef void(^NeedLoadSuccessBlock)(AllModel *allmodel);
typedef void(^NeedFailBlock)(NSString *fail);

@interface LoginNeedNetViewModel : NSObject

- (void)loadWithAllModel:(AllModel *)allmodel success:(NeedLoadSuccessBlock)succcess fail:(NeedFailBlock)fail;

@end

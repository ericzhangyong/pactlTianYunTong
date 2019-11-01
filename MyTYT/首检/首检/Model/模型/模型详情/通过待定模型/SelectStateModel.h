//
//  SelectStateModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectStateModel : NSObject

//状态<0待定 1通过 ""没有状态>
@property (nonatomic) NSString *state;
//是否一键通过
@property (nonatomic,assign) BOOL isAllAgree;
//操作个数
@property (nonatomic,assign) NSInteger operationcount;

@end

//
//  TwentyMachineModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwentyMachineModel : NSObject

//删除
@property (nonatomic) NSString *deleted;
//安检机ID
@property (nonatomic) NSString *ID;
//安检机名称
@property (nonatomic) NSString *name;
//货站ID
@property (nonatomic) NSString *ctid;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

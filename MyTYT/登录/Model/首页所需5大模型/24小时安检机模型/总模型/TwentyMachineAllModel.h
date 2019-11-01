//
//  TwentyMachineAllModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/22.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwentyMachineAllModel : NSObject

@property (nonatomic,assign) NSInteger totolMachineCount;

@property (nonatomic) NSArray *MachineArray;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

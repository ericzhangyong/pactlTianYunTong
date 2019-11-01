//
//  FDAllModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/18.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDAllModel : NSObject

@property (nonatomic) NSDecimalNumber *allcount;

@property (nonatomic) NSDecimalNumber *allWeight;

- (instancetype)initWithArray:(NSArray *)array;

@end

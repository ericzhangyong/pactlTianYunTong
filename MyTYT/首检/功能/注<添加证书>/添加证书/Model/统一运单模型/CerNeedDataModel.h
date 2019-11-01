//
//  CerNeedDataModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FirstModel;
@class TwentyModel;

@interface CerNeedDataModel : NSObject

@property (nonatomic) NSString *YDH;

@property (nonatomic) NSString *DL;

@property (nonatomic) NSString *DLChinese;

@property (nonatomic) NSString *JS;

@property (nonatomic) NSString *ZL;

@property (nonatomic) NSString *MDG;

//首检
- (instancetype)initWithFirstModel:(FirstModel *)model;
//24小时
- (instancetype)initWithTwentyModel:(TwentyModel *)model;

@end

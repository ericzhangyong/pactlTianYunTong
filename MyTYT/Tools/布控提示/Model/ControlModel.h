//
//  ControlModel.h
//  MyTYT
//
//  Created by Fly on 2018/9/19.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwentyModel;
@class FirstModel;

@interface ControlModel : NSObject

@property (nonatomic) NSString *YDH;
//安检布控
@property (nonatomic,assign) BOOL IsControl;
//安保布控
@property (nonatomic,assign) BOOL IsABControl;

- (instancetype)initWithTwentyModel:(TwentyModel *)mdoel;

- (instancetype)initWithFirstModel:(FirstModel *)mdoel;

@end

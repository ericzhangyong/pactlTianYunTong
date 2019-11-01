//
//  MyimageModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyimageModel : NSObject

@property (nonatomic) NSString *FileID;

@property (nonatomic) NSString *FilepAth;

@property (nonatomic) NSData *data;

- (instancetype)initWithFildID:(NSString *)FileID filePath:(NSString *)filePath data:(NSData *)data;

@end

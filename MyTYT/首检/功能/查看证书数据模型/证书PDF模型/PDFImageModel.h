//
//  PDFImageModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFImageModel : NSObject

@property (nonatomic) NSString *msg;

@property (nonatomic,assign) NSInteger ok;
//存放模型数组
@property (nonatomic) NSArray *picModelarray;

@property (nonatomic) NSArray *picArray;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

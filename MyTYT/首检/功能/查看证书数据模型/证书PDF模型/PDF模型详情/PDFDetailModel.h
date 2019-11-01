//
//  PDFDetailModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFDetailModel : NSObject

//图片地址
@property (nonatomic) NSString *imagePath;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

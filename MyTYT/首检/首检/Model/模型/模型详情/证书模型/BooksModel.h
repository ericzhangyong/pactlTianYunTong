//
//  BooksModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "BaseModel.h"

@interface BooksModel : BaseModel

@property (nonatomic) NSString *BookNo;

@property (nonatomic) NSString *BookID;

@property (nonatomic) NSString *ID;



- (instancetype)initWithDic:(NSDictionary *)dic;

@end

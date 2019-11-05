//
//  BooksModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "BooksModel.h"
//#import "NSDictionary+Judge.h"

@implementation BooksModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.BookNo = dic[@"bookNo"];
        
        if (dic[@"bookId"] !=Nil) {
            self.BookID = dic[@"bookId"];
        }else{
            self.BookID = @"";
        }

        
        if (dic[@"id"] != Nil) {
            self.ID = dic[@"id"];
        }else{
            self.ID = @"";
        }
        
    }
    return self;
}

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@[@"ID",@"id"],
             @"BookID":@[@"BookID",@"bookId"],
             @"BookNo":@[@"bookNo",@"BookNo"],
    };
}

@end

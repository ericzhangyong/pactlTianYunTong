//
//  DetailBook.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailBook.h"

@implementation DetailBook

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        if (dic[@"bookNo"] !=Nil) {
            self.bookNo = dic[@"bookNo"];
        }else{
            self.bookNo = @"";
        }
        
        if (dic[@"bookId"] !=Nil) {
            self.bookId = dic[@"bookId"];
        }else{
            self.bookId = @"";
        }
        
        
        if (dic[@"bookCheckType"] !=Nil) {
            self.bookCheckType = dic[@"bookCheckType"];
        }else{
            self.bookCheckType = @"";
        }
        
        
        if (dic[@"checkVisual"] !=Nil) {
            self.checkVisual = dic[@"checkVisual"];
        }else{
            self.checkVisual = @"";
        }
        
        if (dic[@"id"] !=Nil) {
            self.ID = dic[@"id"];
        }else{
            self.ID = @"";
        }
        
        [self setTimeWithDic:dic];
        
    }
    return self;
}

//转化时间戳
- (void)setTimeWithDic:(NSDictionary *)dic{
    
    if (dic[@"createdDate"] !=Nil) {
        
        NSDate *date  = [NSDate dateWithTimeIntervalSince1970:[dic[@"createdDate"] doubleValue]/1000];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
        
      self.createdDate = [formatter stringFromDate:date];
        
        
        
    }else{
        self.createdDate = @"";
    }
}

@end

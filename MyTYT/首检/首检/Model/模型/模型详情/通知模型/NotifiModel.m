//
//  NotifiModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/10.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "NotifiModel.h"
#import "DetailNotifyModel.h"

@implementation NotifiModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.status = dic[@"status"];
        
        self.ID = dic[@"id"];
        
        NSString *msg = dic[@"msg"];
    
        
        NSData *msgData = [msg dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:msgData options:NSJSONReadingMutableLeaves error:nil];
        
        NSMutableArray *Myarray = [NSMutableArray array];
        NSMutableString *str = [NSMutableString stringWithString:@""];
        
        for (NSDictionary *temdic in array) {
            
            DetailNotifyModel *mdoel = [[DetailNotifyModel alloc] initWithDic:temdic];
            [Myarray addObject:mdoel];
            
            NSString *newstr = [NSString stringWithString:mdoel.name];
            
           NSString *mynewstr = [newstr stringByAppendingString:@"\n\n"];
            
            [str appendString:mynewstr];

            
        }
        
        if (str.length>2) {
            [str replaceCharactersInRange:NSMakeRange(str.length-2, 2) withString:@""];

        }
        
        
        
        self.AllTitle = [[NSString alloc] initWithString:str];
        
        self.notifyarray = [NSArray arrayWithArray:Myarray];
        
    }
    return self;
}

@end

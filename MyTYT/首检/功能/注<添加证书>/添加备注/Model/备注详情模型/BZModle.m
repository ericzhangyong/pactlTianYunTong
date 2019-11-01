//
//  BZModle.m
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "BZModle.h"
#import "NSDictionary+Judge.h"

@implementation BZModle

- (instancetype)initWithdic:(NSDictionary *)dic{
    if (self = [super init]) {
       
      
        
        if (dic[@"pCheckRemark"] !=Nil && [dic[@"pCheckRemark"] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *temdic = dic[@"pCheckRemark"];
            
            self.employid = temdic[@"employid"];
            
            self.ID = temdic[@"id"];
            
            self.awID = temdic[@"awId"];
            
            self.remark = temdic[@"remark"];
            
            self.isedit = temdic[@"isedit"];
            
            NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:([temdic[@"createddate"] doubleValue]/1000)];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"HH:mm MM/dd "];
            
            self.time = [dateFormatter stringFromDate: detailDate];
            
            
            
            
        }else{
            
            self.employid = @"";
            
            self.ID = @"";
            
            self.awID = @"";
            
            self.remark =@"";
            
            self.isedit = @"";
            
            self.time = @"";
            
        }
        
        if (dic[@"pFileRelation"] !=Nil && [dic[@"pFileRelation"] isKindOfClass:[NSDictionary class]]) {//有图片
            
            NSDictionary *temdic = dic[@"pFileRelation"];
            
           NSString *path = temdic[@"fileHttpPath"];
            
            self.picFilePath = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],path];
        }else{
            
            self.picFilePath = @"";
        }
        
        
        self.IsCanEditContent = NO;
        
        
        if ([dic judgekeyAndValueWithKey:@"files"]) {//图片数组
            
            NSMutableArray *array = [NSMutableArray array];
            
            if ([dic[@"files"] isKindOfClass:[NSArray class]]) {
                
                for (id temdic in dic[@"files"]) {
                   
                    if ([temdic  isKindOfClass:[NSDictionary class]]) {
                        
                    if ([temdic[@"suffix"] isEqualToString:@"jpeg"]) {
                        
                        [array addObject: [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],temdic[@"fileHttpPath"]]];
                    }
                        
                    }
                }
                
            }
            
            self.FileArray = [NSArray arrayWithArray:array];

        }else{
            self.FileArray = [NSArray array];
        }
        
    }
    return self;
}

@end

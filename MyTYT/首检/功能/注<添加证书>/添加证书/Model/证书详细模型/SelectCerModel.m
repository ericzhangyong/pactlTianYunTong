//
//  SelectCerModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "SelectCerModel.h"

@implementation SelectCerModel

- (instancetype)initWithdic:(NSDictionary *)dic{
    if (self = [super init]) {
    
        [self setPicWithDic:dic];
        
        [self setUpBase];
        
        [self setStatusWithDic:dic];
        
        [self proproseNotReturnWithDic:dic];
        
        [self cerWithDic:dic[@"pAgentShareBook"]];
        
        [self JDWithDic:dic[@"pOfficeInfo"]];
        
        [self setagentArrayWithDic:dic];
        
    }
    return self;
}

//设置代理
- (void)setagentArrayWithDic:(NSDictionary *)dic{
    
    if (dic[@"agentCode"]!=Nil && [dic[@"agentCode"] isKindOfClass:[NSArray class]] && [dic[@"agentCode"] count]>0) {
        
        self.agentArray = [NSArray arrayWithArray:dic[@"agentCode"]];
        
    }else{
        self.agentArray = [NSArray array];
    }
}

//设置图片
- (void)setPicWithDic:(NSDictionary *)dic{
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *userarray = [NSMutableArray array];
    
    if (dic[@"pFileRelations"] !=Nil && [dic[@"pFileRelations"] isKindOfClass:[NSArray class]] && [dic[@"pFileRelations"] count]>0) {//有图片数组
        
        for (NSDictionary *temdic in  dic[@"pFileRelations"]) {
            
            NSString *filepath = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath], temdic[@"fileHttpPath"]];
            
            [array addObject:filepath];
            
            if (temdic[@"type"] !=Nil && [temdic[@"type"] isEqualToString:@"jpeg"]) {//图片格式
                [userarray addObject:filepath];
            }
        }
        
    }
    
    self.ZSarray = [NSArray arrayWithArray:array];
    self.CanUsePicArray = [NSArray arrayWithArray:userarray];
}

//为保存上传做默认字段
- (void)setUpBase{
    
    self.bookCheckType = @"book";
    
    self.deviceID = @"1";
}

//设置状态
- (void)setStatusWithDic:(NSDictionary *)dic{
    
    if (dic[@"returnStatus"] !=Nil) {
        self.returnStatus = dic[@"returnStatus"];
    }else{
        self.returnStatus = @"";
    }
    
    if (dic[@"returnReason"] !=Nil) {
        self.returnReason =  dic[@"returnReason"];
    }else{
        self.returnReason = @"";
        
    }
}

//设置不返回字段
- (void)proproseNotReturnWithDic:(NSDictionary *)dic{
    
    NSDictionary *ZSdic = dic[@"pAgentShareBook"];

    if (ZSdic[@"bookType"]!=Nil) {
        self.booktype = ZSdic[@"bookType"];
    }else{
        self.booktype = @"sharing";
    }
    
    
    if (ZSdic[@"id"]!=Nil) {//没有ID 上传时不要传此字段
        self.ID = ZSdic[@"id"];
    }else{
        self.ID = nil;
    }
   
}

//鉴定机构信息
- (void)JDWithDic:(NSDictionary *)dic{
    
    self.shortName = dic[@"shortName"];
       
}

//证书信息
- (void)cerWithDic:(NSDictionary *)dic{
    
    if (dic[@"bookId"] !=Nil) {
        self.bookId = dic[@"bookId"];
    }else{
        self.bookId = @"";
    }
    
    
    self.bookNo = dic[@"bookNo"];
    
    self.ocId = dic[@"ocId"];
    
    self.officeCode = dic[@"officeCode"];
    
    self.officeName = dic[@"officeName"];
    
}


//默认进入添加页面初始化没有BOokID 用来判断保存时有没有验证证书 array用来初始化数据
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bookId = @"";
        self.ID = nil;
        self.CanUsePicArray = [NSArray array];
        self.agentArray = [NSArray array];
    }
    return self;
}

@end

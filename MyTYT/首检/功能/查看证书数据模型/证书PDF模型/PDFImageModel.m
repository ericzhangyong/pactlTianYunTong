//
//  PDFImageModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "PDFImageModel.h"
#import "PDFDetailModel.h"

@implementation PDFImageModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.ok = [dic[@""] integerValue];
        
        self.msg = dic[@""];
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSMutableArray *picArray = [NSMutableArray array];
        
        if ([dic[@"data"] isKindOfClass:[NSArray class]] && [dic[@"data"] count]>0) {//有数据
            
            for (NSDictionary *temdic in dic[@"data"]) {//数据是pdf忽略
                
                if (temdic[@"type"]!=Nil && [temdic[@"type"] isEqualToString:@"jpeg"]) {
                    
                    [picArray addObject:[[NSString alloc] initWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],temdic[@"fileHttpPath"]]];
                    
                    PDFDetailModel *model = [[PDFDetailModel alloc] initWithDic:temdic];
                    [array addObject:model];
                }else{
                    
                 
                }
                
            }
            
        }
        
        self.picModelarray = [NSArray arrayWithArray:array];
        self.picArray  = [NSArray arrayWithArray:picArray];
        
    }
    return self;
}

@end

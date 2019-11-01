//
//  PDFDetailModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "PDFDetailModel.h"

@implementation PDFDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self =[super init]) {
        
        self.imagePath = [[NSString alloc] initWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],dic[@"fileHttpPath"]];
    }
    return self;
}

@end

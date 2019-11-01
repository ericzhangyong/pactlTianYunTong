//
//  QueryCerImageModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QueryCerImageModel.h"

@implementation QueryCerImageModel


- (instancetype)initWithpicFilepath:(NSString *)picFilepath{
    if (self = [super init]) {
        
        self.picFilepath = picFilepath;
    }
    return self;
}


@end

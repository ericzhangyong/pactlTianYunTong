//
//  MyimageModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "MyimageModel.h"

@implementation MyimageModel

- (instancetype)initWithFildID:(NSString *)FileID filePath:(NSString *)filePath data:(NSData *)data{
    
    if (self = [super init]) {
        
        self.FileID = FileID;
        self.FilepAth = filePath;
        self.data = data;
    }
    return self;
}

//
//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"fileID---%@  \n filepath------%@", self.FileID,self.FilepAth];
//}
@end

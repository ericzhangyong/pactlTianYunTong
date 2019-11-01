//
//  AddBZDataManager.m
//  MyTYT
//
//  Created by Fly on 2018/6/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddBZDataManager.h"
#import "AddBZSectionModel.h"
#import "BZAddModel.h"
#import "AddBZImageModel.h"

@implementation AddBZDataManager

- (instancetype)initWithArray:(NSArray *)array{
    
    if (self = [super init]) {
        
        [self setdataWithArray:array];
        
    }
    return self;
}


- (void)setdataWithArray:(NSArray *)array{
    
    //备注
    AddBZSectionModel *sectionModelZero = [[AddBZSectionModel alloc] initWithSectionType:contentTYpe rowArray:@[array]];
    
    //添加
    self.addmodel = [[BZAddModel alloc] init];
    AddBZSectionModel *sectionModelOne = [[AddBZSectionModel alloc] initWithSectionType:addType rowArray:@[@[self.addmodel]]];
    
    //拍摄图片
    self.imageModel = [[AddBZImageModel alloc] init];
    
    self.SectionArray =[NSMutableArray arrayWithObjects:sectionModelZero,sectionModelOne, nil];
}

@end

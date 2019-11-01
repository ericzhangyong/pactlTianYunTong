//
//  AddBZRowModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddBZRowModel.h"
#import "BZModle.h"
#import "AddBZImageModel.h"
#import "BZAddModel.h"

@implementation AddBZRowModel

- (instancetype)initWithModel:(id)model{
    if (self = [super init]) {
        
        if ([[model class] isEqual:[BZModle class]]) {
            self.bzmodel =(BZModle *) model;
            self.type = CellcontentTYpe;
        }else if ([[model class ] isEqual:[BZAddModel class]]){
            self.addmodel =(BZAddModel *) model;
            self.type = CelladdType;
        }else if ([[model class ] isEqual:[AddBZImageModel class]]){
            self.imageModel =(AddBZImageModel *) model;
            self.type = CellimageType;
        }
    }
    return self;
}

@end

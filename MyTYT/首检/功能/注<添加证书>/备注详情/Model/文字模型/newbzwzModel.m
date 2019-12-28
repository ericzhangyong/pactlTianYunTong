//
//  newbzwzModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "newbzwzModel.h"

@implementation newbzwzModel

- (instancetype)initWithDetectionType:(DetectionType)detectionTyep;
{
    self = [super init];
    if (self) {
        if (detectionTyep == DetectionType9610System) {
            self.wzarray = @[@"运单号",@"证书",@"品名",@"备注"];
        }else{
            self.wzarray = @[@"运单号",@"证书",@"英文品名",@"中文品名",@"备注"];
        }
    }
    return self;
}

@end

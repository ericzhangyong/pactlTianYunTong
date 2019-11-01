//
//  ClickControlModel.m
//  MyTYT
//
//  Created by Fly on 2019/3/27.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ClickControlModel.h"
#import "NSDictionary+Judge.h"

@implementation ClickControlModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        //布控
        if ([dic judgekeyAndValueWithKey:@"isSc"]) {
            
            if ([dic[@"isSc"] isEqualToString:@"1"]) {
                self.iscontrol = YES;
                
            }else{
                self.iscontrol = NO;
            }
            
        }else{
            self.iscontrol = NO;
        }
        
        //安保布控
        if ([dic judgekeyAndValueWithKey:@"isTc"]) {
            
            if ([dic[@"isTc"] isEqualToString:@"1"]) {
                self.isABControl = YES;
                
            }else{
                self.isABControl = NO;
            }
            
        }else{
            self.isABControl = NO;
        }
        
        self.awID = dic[@"awId"];
    }
    return self;
}

@end

//
//  NSDictionary+Judge.m
//  MyTYT
//
//  Created by Fly on 2018/6/1.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "NSDictionary+Judge.h"

@implementation NSDictionary (Judge)

- (BOOL)judgekeyAndValueWithKey:(NSString *)key{
    
    if ([self objectForKey:key] == nil) {//judge nil
        return NO;
    }
    
    id obj = [self objectForKey:key]; // judge null
    
    return ![obj isEqual:[NSNull null]];
}

@end

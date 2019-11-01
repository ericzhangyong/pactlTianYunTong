//
//  NSString+JM.h
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JM)

- (NSString*) sha1;

- (NSString *) md5;

//去除空格
- (NSString *) whiteSpace;

@end

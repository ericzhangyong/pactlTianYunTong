//
//  MyCooke.m
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "MyCooke.h"

@implementation MyCooke

+ (instancetype)shareInstance{
    
    static MyCooke *instace;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instace = [[self alloc] init];
    });
    return instace;
}

- (NSHTTPCookie *)addCookename:(NSString *)name value:(id )vale{
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:name forKey:NSHTTPCookieName];
    [cookieProperties setObject:vale forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath] forKey:NSHTTPCookieDomain];
    NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:cookieProperties];
    
    return cookie;
}

@end

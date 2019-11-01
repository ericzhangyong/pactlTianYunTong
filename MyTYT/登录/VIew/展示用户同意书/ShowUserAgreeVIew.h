//
//  ShowUserAgreeVIew.h
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,OpeartionTYpe) {
    SelectOpertionType,//选择操作说明
    ShowOperationType//展示操作说明
};

typedef void(^UserAgreeBlock)(void);
typedef void(^UserDontAgreeBlock)(void);


@interface ShowUserAgreeVIew : UIView


+ (void)showUserTitle:(NSString *)title content:(NSString *)content type:(OpeartionTYpe)type agree:(UserAgreeBlock)agree dontAgree:(UserDontAgreeBlock)dontagree;

@end

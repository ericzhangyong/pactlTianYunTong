//
//  InputYDVC.h
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StrBlock)(NSString *Str);

@interface InputYDVC : UIViewController

@property (nonatomic,copy) StrBlock block;

@property (nonatomic) NSString *inputStr;

@end

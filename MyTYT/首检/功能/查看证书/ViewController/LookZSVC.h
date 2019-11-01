//
//  LookZSVC.h
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BooksModel;

typedef void(^LOOkZSBlockID)(BooksModel *model);

@interface LookZSVC : UIViewController

@property (nonatomic) NSArray *dataarray;

@property (nonatomic,copy) LOOkZSBlockID Block;

@end

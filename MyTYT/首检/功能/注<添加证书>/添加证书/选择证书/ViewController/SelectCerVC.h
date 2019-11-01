//
//  SelectCerVC.h
//  MyTYT
//
//  Created by Fly on 2018/5/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectCerModel;

typedef void(^SelectCerBlock)(SelectCerModel *mdoel);

@interface SelectCerVC : UIViewController

@property (nonatomic) NSArray *dataarray;

@property (nonatomic,copy) SelectCerBlock block;

@end

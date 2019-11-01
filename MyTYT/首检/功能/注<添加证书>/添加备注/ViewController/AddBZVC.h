//
//  AddBZVC.h
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AddBZBlock)(void);

@class OperationMachinModel;

@interface AddBZVC : UIViewController

@property (nonatomic) NSString *aWID;

@property (nonatomic) NSString *MachID;
//运单号
@property (nonatomic) NSString *YDH;

@property (nonatomic) OperationMachinModel *opeartionModel;

@property (nonatomic,copy) AddBZBlock block;

@end

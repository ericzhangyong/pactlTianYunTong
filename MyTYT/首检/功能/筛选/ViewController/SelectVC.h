//
//  SelectVC.h
//  MyTYT
//
//  Created by Fly on 2018/4/26.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectModel;

typedef void(^SelectBlock)(SelectModel *model);

@interface SelectVC : UIViewController

@property (nonatomic) NSMutableArray *AgentArray;

@property (nonatomic,copy) SelectBlock block;

@end

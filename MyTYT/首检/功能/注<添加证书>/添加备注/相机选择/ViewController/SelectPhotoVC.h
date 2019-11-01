//
//  SelectPhotoVC.h
//  MyTYT
//
//  Created by Fly on 2018/5/3.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SlectPhotoBlock)(NSInteger row);

@interface SelectPhotoVC : UIViewController

@property (nonatomic,copy) SlectPhotoBlock block;

@end

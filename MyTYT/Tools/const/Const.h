//
//  Const.h
//  MyTYT
//
//  Created by zhangyong on 2019/10/27.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#ifndef Const_h
#define Const_h

typedef NS_ENUM(NSInteger,DetectionType){
    DetectionTypeFirst = 0, //首检
    DetectionType9610System //9610系统
};


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//弱引用，强引用
#define WEAK_SELF __weak typeof(self) weakSelf = self;
#define STRONG_SELF __strong typeof(weakSelf) self = weakSelf


#import "IQKeyboardManager.h"
#import "Masonry.h"
#import "ColorConst.h"

#endif /* Const_h */

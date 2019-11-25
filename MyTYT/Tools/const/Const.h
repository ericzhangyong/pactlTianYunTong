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
    DetectionTypeTwentyFour,//24小时
    DetectionType9610System //9610系统
};
typedef NS_ENUM(NSInteger,ScanType) {
    SCANYGD,//扫描运单号
    SCANYCER,//扫描证书
    ScanTypeCheck, //查验扫描
    //ScanTypeCheckYGD_and_YCER //vc界面扫描运单号扫描证书
};


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//弱引用，强引用
#define WEAK_SELF __weak typeof(self) weakSelf = self;
#define STRONG_SELF __strong typeof(weakSelf) self = weakSelf


#import "IQKeyboardManager.h"
#import "Masonry.h"
#import "ColorConst.h"
#import "BaseVerifyUtils.h"

#endif /* Const_h */

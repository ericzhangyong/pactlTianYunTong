//
//  WriteScanYDVC.h
//  MyTYT
//
//  Created by Fly on 2018/6/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ScanYDType) {
    FirstScanYDType,//首检扫描类型
    TwentyScanYDType//24小时扫描
};

@interface WriteScanYDVC : UIViewController

@property (nonatomic) NSString *machID;

@property (nonatomic,assign) ScanYDType type;

@end

//
//  ScanVC.h
//  MyTYT
//
//  Created by Fly on 2018/4/27.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,IntoScanType){
    FirstScanType,//首检类型
    TwenTyScanType,//24小时类型
    IntoScanType9610System //9610系统
};
typedef NS_ENUM(NSInteger,ScanVCType){
    ScanVCTypeScan = 0,//扫描界面
    ScanVCTypeCheck//查验界面
};

@interface ScanVC : UIViewController

-(instancetype)initWithScanVCType:(ScanVCType)vcType;


@property (nonatomic) NSString *machID;

@property (nonatomic,assign) IntoScanType intoScantype;

@end

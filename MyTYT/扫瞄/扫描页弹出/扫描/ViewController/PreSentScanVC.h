//
//  PreSentScanVC.h
//  MyTYT
//
//  Created by Fly on 2018/4/27.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ScanType) {
    SCANYGD,//扫描运单号
    SCANYCER,//扫描证书
    ScanTypeCheck //查验扫描
};

typedef NS_ENUM(NSInteger,FromType) {
    FromFirstCome,//首检
    FromTwentyCome,//24小时
    From9610System //9601系统
};

//扫描字符串
typedef void(^ScanStrBlock)(NSString *scanStr);

@interface PreSentScanVC : UIViewController

@property (nonatomic,copy) ScanStrBlock block;

@property (nonatomic, assign) ScanType type;

@property (nonatomic,assign) FromType fromType;

@property (nonatomic) NSString *MachID;

@end

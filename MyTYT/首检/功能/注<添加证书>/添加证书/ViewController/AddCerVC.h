//
//  AddCerVC.h
//  MyTYT
//
//  Created by Fly on 2018/5/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,IntoCerType) {
    FromRemark,//备注(已经有备注信息)--->添加证书
    FromFirst//从首页进来-->备注(没有请求备注信息)-->添加证书--|返回时让备注页面刷新数据
    //                                      |------------|
    //作用:让证书页面返回时判断如何进来的，如果是首页进来备注没有请求数据则返回时让备注页面请求数据
    
};

@class FirstModel;
@class CerNeedDataModel;

typedef void(^ADDCerSuccessBlock)(void);

@interface AddCerVC : UIViewController


@property (nonatomic) NSString *aWID;

@property (nonatomic) NSString *agentOprnId;

@property (nonatomic) NSString *airCode;

@property (nonatomic) IntoCerType type;

@property (nonatomic) CerNeedDataModel *CerdataModel;

@property (nonatomic,copy) ADDCerSuccessBlock block;

@property (nonatomic,assign) BOOL isReturnToRootVC;

@end

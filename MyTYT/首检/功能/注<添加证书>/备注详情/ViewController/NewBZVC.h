//
//  NewBZVC.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BZCheckTYpe) {
    FIRSTTYPE,//首检
    TWenTYTYPE//24小时
};

typedef NS_ENUM(NSInteger,ComeIngType) {
    AddRemarkType,//添加备注类型
    AddCerType,//添加证书类型
};


@class OperationMachinModel;
@class DeviceModel;
@class FirstModel;
@class CerNeedDataModel;

@interface NewBZVC : UIViewController

//进入此页面的类型<备注还是添加证书>
@property (nonatomic,assign) ComeIngType comeType;

//进入类型
@property (nonatomic,assign) BZCheckTYpe Type;

//加载所用
@property (nonatomic) DeviceModel *deviceModel;

//运单主键
@property (nonatomic) NSString *aWID;

/*****************添加证书用*********************/

@property (nonatomic) NSString *agent_oprn_id;

@property (nonatomic) NSString *airCode;

/**************************************/

@property (nonatomic) CerNeedDataModel *CerdataModel;

@property (nonatomic) OperationMachinModel *operationModel;//本页面用不到，用来传给添加备注页面，拍照成功后<没输入内容显示操作人信息的>

@end

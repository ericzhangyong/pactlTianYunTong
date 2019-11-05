//
//  FirstModel.h
//  MyTYT
//
//  Created by Fly on 2018/4/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SelectStateModel;

@interface FirstModel : NSObject

//新消息 1最新
@property (nonatomic) NSString *isnew;
//数据记录ID
@property (nonatomic) NSString *ID;
//运单ID
@property (nonatomic) NSString *awId;

//代理
@property (nonatomic) NSString *daili;
//代理简称
@property (nonatomic) NSString *agent_short_name;

/// 控字的背景颜色
@property (nonatomic,copy) NSString *securityCheckResultColor;
/// 控字的
@property (nonatomic,copy) NSString *securityCheckResult;

/**********************测**********==
 '1' 时显示 showWord
 !='1' 或者为空或字段不存在时显示取到的’测’字(取到的值)
 ******************/
//是否测试<1代表真实>
@property (nonatomic) NSString *is_formal;
//测字
@property (nonatomic) NSString *testText;
//这个字段可能返回存在而且不为空显示这个字
@property (nonatomic) NSString *show_word;
/**************************************************/


//是否电子运单
@property (nonatomic) NSString * isEle;
//总单号
@property (nonatomic) NSString *ALLNUmber;
//目的港
@property (nonatomic) NSString *MUdigang;
//件数
@property (nonatomic) NSString *jianshu;
//重量
@property (nonatomic) NSString *zhongliang;
//证书个数
@property (nonatomic) NSString * booksCount;
//证书数组
@property (nonatomic) NSArray *bookArray;

//通过，待定（0，待定 1 通过 没有 ""）
@property (nonatomic) NSString *THOrDD;
//本地模型
@property (nonatomic) SelectStateModel *LocalstateModel;

//货物类型 <0铺货 1危险品 2 24小时>
@property (nonatomic) NSString *type;
//测试员工号码
@property (nonatomic) NSString *TextYG;
//时间
@property (nonatomic) NSString *time;
//通知个数
@property (nonatomic) NSString *count_notice;
//通知数组
@property (nonatomic) NSArray *noticeArray;

//24小时通道
@property (nonatomic) NSString *aisle24;

//锂电池
@property (nonatomic) NSString *elm_flag;
//( Eli——flag || elm_flag)=1 锂电池
////锂电池
@property (nonatomic) NSString *eli_flag;

//备注
@property (nonatomic) NSString *count_remark;

/**************************添加证书时所需要字段************************************/
//操作代理ID
@property (nonatomic) NSString *agent_oprn_id;

//航空公司二字代码
@property (nonatomic) NSString *airCode;
/**************************************************************/

//是否安检布控
@property (nonatomic,assign) BOOL iscontrol;

//是否安保布控
@property (nonatomic,assign) BOOL isABControl;



- (instancetype)initWithDic:(NSDictionary *)dic;

@end

//
//  TwentyModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SelectStateModel;
@class TwentyLocalInfoModel;

@interface TwentyModel : NSObject

/*
 备注
 */
@property (nonatomic) NSString *count_remark;


/*
 新消息
 */
@property (nonatomic) NSString *isnew;

/*
 操作代理
 */
@property (nonatomic) NSString *agent_oprn;

/*
 代理简称
 */
@property (nonatomic) NSString *agent_short_name;

/*
 操作代理ID
 */
@property (nonatomic) NSString *agent_oprn_id;

/*
 总单号
 */
@property (nonatomic) NSString *waybill_no;

/*
 目的港
 */
@property (nonatomic) NSString *dest1;

/*
 件数
 */
@property (nonatomic) NSNumber *total_count;

/*
 重量
 */
@property (nonatomic) NSNumber *gross_weight;

/*
 证书数量
 */
@property (nonatomic) NSString *count_books;

/*
 证书数组
 */
@property (nonatomic) NSArray *booksArray;

/*
 通过待定
 ""没有状态
 1.通过
 0.待定
 */
@property (nonatomic) NSString *fstatus;

/*
 货物类别
 */
@property (nonatomic) NSString *goods_class;

/*
 eli || elm == 1 表示锂电池
 */
@property (nonatomic) NSString *eli_flag;

/*
 eli || elm == 1 表示锂电池
 */
@property (nonatomic) NSString *elm_flag;

/*
 isfoamal = 1正式
 */
@property (nonatomic) NSString *is_formal;

/*
 测试字
 */
@property (nonatomic) NSString *testWord;

/*
 正是运单的字
 */
@property (nonatomic) NSString *show_word;

/*
 电子运单
 */
@property (nonatomic) NSString *wb_ele;

/*
 航空二字代码
 */
@property (nonatomic) NSString *airCode;

/*
 运单主键
 */
@property (nonatomic) NSString *awId;

/*****************************************************************/
/*
 24小时ID
 */
@property (nonatomic) NSString *aisle24;

/*
 通道货物数量
 */
@property (nonatomic) NSString *aislecount;

/*
 24小时待过安检机
 */
@property (nonatomic) NSString *machine24;

/*
 安检机
 */
@property (nonatomic) NSString *mcid;

/*****************************************************************/

/*
 本地信息模型
 */
@property (nonatomic) TwentyLocalInfoModel *infoModel;

/*
 本地选择模型
 */
@property (nonatomic) SelectStateModel *LocalstateModel;

/*
 控
 */
@property (nonatomic,assign) BOOL iscontrol;

//是否安保布控
@property (nonatomic,assign) BOOL isABControl;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

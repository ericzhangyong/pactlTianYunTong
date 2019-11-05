//
//  CheckInfoView.h
//  MyTYT
//
//  Created by zhangyong on 2019/11/4.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftLable.h"
#import "RightLable.h"
#import "ScanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckInfoView : UIView

@property (nonatomic) LeftLable *label_minuteOrder;

@property (nonatomic) LeftLable *label_zhongWenPinMing;

@property (nonatomic) LeftLable *label_allOrderNum;

@property (nonatomic) LeftLable *label_muDiGangKou;
@property (nonatomic) LeftLable *label_allMuDiGangKou;


@property (nonatomic) LeftLable *label_daiLi;
@property (nonatomic,strong) LeftLable *label_zhengShu;
@property (nonatomic,strong) UIImageView *imageView_pdf;

//分单号
@property (nonatomic) RightLable *label_minuteOrderContent;
@property (nonatomic) UILabel *label_eleMinuteOrder;

//中文品名
@property (nonatomic) RightLable *label_zhongWenPinMingContent;
//总单号
@property (nonatomic) RightLable *label_allOrderNumContent;
@property (nonatomic) UILabel *label_eleAllOrder;

//分单目的港口
@property (nonatomic) RightLable *label_muDiGangKouContent;
//总单目的港口
@property (nonatomic) RightLable *label_allMuDiGangKouContent;

//代理
@property (nonatomic) RightLable *label_daiLiContent;



@property (nonatomic,copy) void(^zhengShuClick)(BOOL isClick);
- (void)loaddataWithscanModel:(ScanBillModel *)billModel;
@end

NS_ASSUME_NONNULL_END

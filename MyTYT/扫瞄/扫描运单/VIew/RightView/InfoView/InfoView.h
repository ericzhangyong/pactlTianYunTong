//
//  InfoView.h
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanModel.h"

@class LeftLable;
@class RightLable;
@interface InfoView : UIView

@property (nonatomic) LeftLable *allnumberlable;

@property (nonatomic) LeftLable *hangbanlable;

@property (nonatomic) LeftLable *mudiganglable;

@property (nonatomic) LeftLable *daililable;

@property (nonatomic) LeftLable *jianshulable;

@property (nonatomic) LeftLable *zhonglianglable;

@property (nonatomic) LeftLable *jifeizhiagianglable;

@property (nonatomic) LeftLable *tijilable;

@property (nonatomic) LeftLable *pinminglable;

@property (nonatomic) LeftLable *tehuodaimalable;

@property (nonatomic) LeftLable *fahuorenlable;

@property (nonatomic) LeftLable *shouhuorenlable;

//运单
@property (nonatomic) RightLable *YDH;
//航班
@property (nonatomic) RightLable *HB;
//目的港
@property (nonatomic) RightLable *MDG;
//代理
@property (nonatomic) RightLable *DL;
//件数
@property (nonatomic) RightLable *JS;
//重量
@property (nonatomic) RightLable *ZL;
//计费重量
@property (nonatomic) RightLable *JFZL;
//体积
@property (nonatomic) RightLable *TJ;
//品名
@property (nonatomic) RightLable *PM;
//特货代码
@property (nonatomic) RightLable *THDM;
//发货人
@property (nonatomic) RightLable *FHR;
//收货人
@property (nonatomic) RightLable *SHR;

@property (nonatomic) UILabel *eleLable;

- (void)loaddataWithscanModel:(ScanBillModel *)billModel;

@end

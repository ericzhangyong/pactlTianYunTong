//
//  DetailWayBillHeadView.h
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailSectionBaseHeadView.h"
#import "SectionheadLable.h"

//@class SectionheadLable;

@interface DetailWayBillHeadView : DetailSectionBaseHeadView
-(instancetype)initWithDetectionType:(DetectionType)detectionType;


@property (nonatomic) SectionheadLable *FDHLable;

@property (nonatomic) SectionheadLable *JSable;

@property (nonatomic) SectionheadLable *ZLable;

@property (nonatomic) SectionheadLable *MDGLable;

@property (nonatomic) SectionheadLable *PMLable;
/// 中文品名
@property (nonatomic) SectionheadLable *PMChLable;


@property (nonatomic) SectionheadLable *BZLable;

@end

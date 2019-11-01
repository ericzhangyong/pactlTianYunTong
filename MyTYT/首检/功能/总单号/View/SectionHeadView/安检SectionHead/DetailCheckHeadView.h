//
//  DetailCheckHeadView.h
//  MyTYT
//
//  Created by Fly on 2018/5/18.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailSectionBaseHeadView.h"

@class SectionheadLable;
@class CheckModel;

@interface DetailCheckHeadView : DetailSectionBaseHeadView

@property (nonatomic) SectionheadLable *statusLable;

@property (nonatomic) SectionheadLable *timeLable;

@property (nonatomic) SectionheadLable *machLable;

- (instancetype)init;

@end

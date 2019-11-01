//
//  DetailBookHead.h
//  MyTYT
//
//  Created by Fly on 2018/5/17.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailSectionBaseHeadView.h"

@class SectionheadLable;


@interface DetailBookHead : DetailSectionBaseHeadView

@property (nonatomic) SectionheadLable *bookLable;

@property (nonatomic) SectionheadLable *countLable;

- (instancetype)initWithBookCount:(NSInteger)count;

@end

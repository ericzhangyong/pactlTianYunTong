//
//  QuerySectionModle.h
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,QuerySectionCellType) {
    
    SectionCerStateType,//证书状态
    SectionAgentType,//代理
    SectionImageType//证书
};

@interface QuerySectionModle : NSObject

@property (nonatomic,assign) QuerySectionCellType cellType;

@property (nonatomic) NSArray *rowArray;

@property (nonatomic) NSString *Sectiontitle;

@property (nonatomic,assign) CGSize SectionheadSize;

@property (nonatomic,assign) CGSize SectionfootSize;

@property (nonatomic,assign) UIEdgeInsets sectionInset;

@property (nonatomic,assign) CGFloat minlineSpace;

@property (nonatomic,assign) CGFloat minInterSpace;

- (instancetype)initWithcellType:(QuerySectionCellType)type rowArray:(NSArray <NSArray *> *)rowArray;

@end

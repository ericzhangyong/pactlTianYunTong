//
//  AddBZSectionModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ADDBZSectionCellType) {
    contentTYpe,//内容
    addType,//添加
    ImageType//图片
};

@interface AddBZSectionModel : NSObject

@property (nonatomic,assign) CGFloat headheight;

@property (nonatomic,assign) CGFloat footerHeight;

@property (nonatomic) UIView *headview;

@property (nonatomic) UIView *footview;

@property (nonatomic,strong) NSMutableArray *rowarray;

@property (nonatomic,assign) ADDBZSectionCellType sectionType;

- (instancetype)initWithSectionType:(ADDBZSectionCellType)type rowArray:(NSArray <NSArray *>*)rowarray;

@end

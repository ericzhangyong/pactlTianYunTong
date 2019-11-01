//
//  AddBZRowModel.h
//  MyTYT
//
//  Created by Fly on 2018/6/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BZModle;
@class BZAddModel;
@class AddBZImageModel;

typedef NS_ENUM(NSInteger,AddBZRowType) {
    CellcontentTYpe,//内容
    CelladdType,//添加
    CellimageType//图片
};

@interface AddBZRowModel : NSObject

@property (nonatomic,assign) AddBZRowType type;

@property (nonatomic) BZModle *bzmodel;

@property (nonatomic) BZAddModel *addmodel;

@property (nonatomic) AddBZImageModel *imageModel;

- (instancetype)initWithModel:(id)model;

@end

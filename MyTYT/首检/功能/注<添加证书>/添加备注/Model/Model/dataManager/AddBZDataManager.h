//
//  AddBZDataManager.h
//  MyTYT
//
//  Created by Fly on 2018/6/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddBZImageModel;
@class BZAddModel;

@interface AddBZDataManager : NSObject

@property (nonatomic) NSMutableArray *SectionArray;

@property (nonatomic) BZAddModel *addmodel;

@property (nonatomic) AddBZImageModel *imageModel;

- (instancetype)initWithArray:(NSArray *)array;

@end

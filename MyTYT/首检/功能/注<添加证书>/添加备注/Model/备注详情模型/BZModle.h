//
//  BZModle.h
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZModle : NSObject

//员工
@property (nonatomic) NSString *employid;
//内容
@property (nonatomic) NSString *remark;
//时间
@property (nonatomic) NSString *time;
//图片路径
@property (nonatomic) NSString *picFilePath;
//是否可以编辑删除 1可以编辑删除<控制编辑删除按钮的>
@property (nonatomic) NSString *isedit;
//备注ID<删除备注可用>
@property (nonatomic) NSString *ID;
//运单
@property (nonatomic) NSString *awID;


//本地默认生成 不可以编辑内容
@property (nonatomic ,assign) BOOL IsCanEditContent;


@property (nonatomic) NSArray *FileArray;

- (instancetype)initWithdic:(NSDictionary *)dic;

@end

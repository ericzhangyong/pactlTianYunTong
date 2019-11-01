//
//  QueryCerImageModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QuerybaseModel.h"

@interface QueryCerImageModel : QuerybaseModel


@property (nonatomic) NSString *picFilepath;

- (instancetype)initWithpicFilepath:(NSString *)picFilepath;



@end

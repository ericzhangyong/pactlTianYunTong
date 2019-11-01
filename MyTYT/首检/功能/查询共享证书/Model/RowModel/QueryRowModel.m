//
//  QueryRowModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QueryRowModel.h"
#import "QuerybaseModel.h"
#import "QueryCerStateModel.h"
#import "QueryCerImageModel.h"
#import "QueryAgentModel.h"
#import "SQModel.h"

@implementation QueryRowModel

- (instancetype)initWithModel:(QuerybaseModel *)model{

    if (self = [super init]) {
        
        self.model = model;
        
        if ([[self.model class] isEqual:[QueryCerStateModel class]]) {
            
            self.cellType = RowCerStateType;
            self.itemSize = CGSizeMake(kuan, 90);
          
            
        }else if ([[self.model class] isEqual:[QueryAgentModel class]]){
            
            self.cellType = RowAgentType;
            self.itemSize =  CGSizeMake((kuan - 9*20)/8, 40);
            
        }else if ([[self.model class] isEqual:[QueryCerImageModel class]]){
            
            self.cellType = RowImageType;
            self.itemSize =  CGSizeMake((kuan - 3*20)/2, (gao-64)*0.5);
            
        }else if ([[self.model class] isEqual:[SQModel class]]){
            self.cellType = RowSQDLType;
            self.itemSize =  CGSizeMake((kuan - 9*20)/8, 40);
        }
        
    }
    return self;
}


@end

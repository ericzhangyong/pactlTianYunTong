//
//  QueryDataManger.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QueryDataManger.h"
#import "QuerySectionModle.h"
#import "SelectCerModel.h"
#import "QueryCerImageModel.h"
#import "QueryCerStateModel.h"
#import "QueryAgentModel.h"
#import "SQModel.h"

@implementation QueryDataManger

- (instancetype)initBaseData{
    self = [super init];
    if (self) {
        
        QuerySectionModle *stateModel = [[QuerySectionModle alloc] initWithcellType:SectionCerStateType rowArray:@[@[self.stateModel]]];
        
        self.sectionArray = [NSArray arrayWithObjects:stateModel,nil];
        
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
     
        QuerySectionModle *stateModel = [[QuerySectionModle alloc] initWithcellType:SectionCerStateType rowArray:@[@[self.stateModel]]];
        
        self.sectionArray = [NSArray arrayWithObjects:stateModel,nil];
        


    }
    return self;
}

- (QueryCerStateModel *)stateModel{
    if (!_stateModel) {
        _stateModel = [[QueryCerStateModel alloc] init];
    }
    return _stateModel;
}

- (instancetype)initWithModel:(SelectCerModel *)Model{
    
    if (self = [super init]) {
        self.cermodel = Model;
        [self setSetionModelWithallModel:Model];
    }
    
    return self;
}

- (void)setSetionModelWithallModel:(SelectCerModel *)Model{
    
    QuerySectionModle *stateModel = [[QuerySectionModle alloc] initWithcellType:SectionCerStateType rowArray:@[@[self.stateModel]]];
    
    QuerySectionModle *AgentModel = [self agentModelWithModel:Model];
    
    QuerySectionModle *ImageModel = [self CerModelWithModel:Model];
    
    self.sectionArray = [NSArray arrayWithObjects:stateModel,AgentModel,ImageModel, nil];
    
}

//代理
- (QuerySectionModle *)agentModelWithModel:(SelectCerModel *)model{
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *coloarray = @[ @"#4cb0f9",
                            @"#b9e563",
                            @"#fec04e",
                            @"#ff7680",
                            @"#a49ef0"];
    
//    model.agentArray = @[@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL",@"GDP买买买",@"丹砂",@"DHL"];
//   
    for (int i = 0; i<model.agentArray.count; i++) {
        
        NSString *agent = model.agentArray[i];
        
        QueryAgentModel *model = [[QueryAgentModel alloc] initWithAgent:agent];
        
        model.colorStr = coloarray[i%5];
        
        [array addObject:model];

    }
    
    
    self.AgentArray = [NSArray arrayWithArray:array];
    
    SQModel *sqmodel = [[SQModel alloc] initWithTitle:@"授权代理:"];
    
    QuerySectionModle *AgentModel = [[QuerySectionModle alloc] initWithcellType:SectionAgentType rowArray:@[@[sqmodel],array]];
    
    return AgentModel;

}

//证书
- (QuerySectionModle *)CerModelWithModel:(SelectCerModel *)model{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *filePath in model.CanUsePicArray) {
        QueryCerImageModel *model = [[QueryCerImageModel alloc] initWithpicFilepath:filePath];
        [array addObject:model];
    }
    
    QuerySectionModle *CerImageModel = [[QuerySectionModle alloc] initWithcellType:SectionImageType rowArray:@[array]];
    
    return CerImageModel;
    
}

@end

//
//  ShowCerDataModel.m
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowCerDataModel.h"
#import "ShowCerModel.h"
#import "CerNeedDataModel.h"

@implementation ShowCerDataModel

- (instancetype)initWithStr:(NSString *)CerStr state:(NSString *)state model:(CerNeedDataModel *)model{
    
    if (self = [super init]) {
        
        self.mdoel = model;
        
        [self setDataWithCerStr:CerStr state:state];
        
    }
    
    return self;
}

- (void)setDataWithCerStr:(NSString *)cerStr state:(NSString *)state{
    
    if ([state isEqualToString:@""]) {
        
        ShowCerModel *Cermodel = [[ShowCerModel alloc] initWithTitle:@"证书号:" content:cerStr];
        
        ShowCerModel *YDHmodel = [[ShowCerModel alloc] initWithTitle:@"运单号:" content:self.mdoel.YDH];

        NSString *DL = [self.mdoel.DLChinese isEqualToString:@""] ? self.mdoel.DL : self.mdoel.DLChinese;
        
        ShowCerModel *DLmodel = [[ShowCerModel alloc] initWithTitle:@"代理:" content:[NSString stringWithFormat:@"%@",DL]];

        ShowCerModel *JSmodel = [[ShowCerModel alloc] initWithTitle:@"件数:" content:self.mdoel.JS];

        ShowCerModel *ZLmodel = [[ShowCerModel alloc] initWithTitle:@"重量:" content:self.mdoel.ZL];


        ShowCerModel *MDGmodel = [[ShowCerModel alloc] initWithTitle:@"目的港:" content:self.mdoel.MDG];
        
        self.datararay = [NSArray arrayWithObjects:Cermodel,YDHmodel,MDGmodel,DLmodel,JSmodel,ZLmodel, nil];

    }else{
        
        ShowCerModel *cerModel = [[ShowCerModel alloc] initWithTitle:@"证书号:" content:cerStr];

        ShowCerModel *errorModel = [[ShowCerModel alloc] initWithTitle:@"证书状态:" content:state];
        
        self.datararay = [NSArray arrayWithObjects:cerModel,errorModel, nil];
    }
    
    
}

- (NSArray *)datararay{
    
    if (!_datararay) {
        _datararay = [NSArray array];
    }
    return _datararay;
}

@end

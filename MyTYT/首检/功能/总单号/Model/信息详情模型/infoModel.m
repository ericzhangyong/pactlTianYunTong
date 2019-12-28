//
//  infoModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "infoModel.h"

@implementation infoModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        //运单主键
        if (dic[@"awId"] !=Nil) {
            self.awId = dic[@"awId"];
        }else{
            self.awId = @"";
        }
        
         //运单号
        if (dic[@"waybillNo"] !=Nil) {
            self.waybillNo = dic[@"waybillNo"];
        }else{
            self.waybillNo = @"";
        }
        
        //电子运单
        if (dic[@"wbEle"] !=Nil) {
            self.wbEle = dic[@"wbEle"];
        }else{
            self.wbEle = @"";
        }
        
    
         //操作代理
        if (dic[@"agentOprn"] !=Nil) {
            self.agentOprn = dic[@"agentOprn"];
        }else{
            self.agentOprn = @"";
        }
        
        //航班
        if (dic[@"flightNo"] !=Nil) {
            self.flightNo = dic[@"flightNo"];
        }else{
            self.flightNo = @"";
        }
        
        //日期
        if (dic[@"fltDate"] !=Nil) {
            self.fltDate = dic[@"fltDate"];
        }else{
            self.fltDate = @"";
        }
        
         //发货人
        if (dic[@"spName"] !=Nil) {
            self.spName = dic[@"spName"];
        }else{
            self.spName = @"";
        }
        //收货人
        if (dic[@"csName"] !=Nil) {
            self.csName = dic[@"csName"];
        }else{
            self.csName = @"";
        }
        
        //件数
        if (dic[@"rcpNo"] !=Nil) {
            self.rcpNo = dic[@"rcpNo"];
        }else{
            self.rcpNo = @0;
        }
        
        //重量
        if (dic[@"grossWeight"] !=Nil) {
          
            self.grossWeight = dic[@"grossWeight"];
            
        }else{
            self.grossWeight = @0;
        }
        
        //计费重量
        if (dic[@"chargeWeight"] !=Nil) {
            
            self.chargeWeight = dic[@"chargeWeight"];

        }else{
            self.chargeWeight = @0;
        }
        
        //体积
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"vol"]]) {
           
            self.vol = [self decimWithnumber:dic[@"vol"]];
            
        }else{
            self.vol = @0;
        }
        
        
        //目的港
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"airportDest"]]) {
            self.airportDest = dic[@"airportDest"];
        }else{
            self.airportDest = @"";
        }
        
        //品名
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"goodsDesc"]]) {
            self.goodsDesc = dic[@"goodsDesc"];
        }else{
            self.goodsDesc = @"";
        }
        
        self.goodsDesc = [[self.goodsDesc componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]] componentsJoinedByString:@""];
        
        //ELI
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"eliFlag"]]) {
            self.eliFlag = dic[@"eliFlag"];
        }else{
            self.eliFlag = @"";
        }
        
         //ELM
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"elmFlag"]]) {
            self.elmFlag = dic[@"elmFlag"];
        }else{
            self.elmFlag = @"";
        }
        
        //特或代码
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"holdCode"]]) {
            self.holdCode = dic[@"holdCode"];
        }else{
            self.holdCode = @"";
        }
        
        
        //SSR
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"ssr"]]) {
            self.ssr = dic[@"ssr"];
        }else{
            self.ssr = @"";
        }
        
        //OSI
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"osi1"]]) {
            self.osi1 = dic[@"osi1"];
        }else{
            self.osi1 = @"";
        }
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"securityCheckResultColor"]]) {
            self.securityCheckResultColor =dic[@"securityCheckResultColor"];
        }else{
            self.securityCheckResultColor = @"000000";
        }
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"securityCheckResult"]]) {
            self.securityCheckResult =dic[@"securityCheckResult"];
        }else{
            self.securityCheckResult = @"";
        }
 
        if (![BaseVerifyUtils isNullOrSpaceStr:dic[@"goodsNameCn"]]) {
            self.goodsNameCn =dic[@"goodsNameCn"];
        }else{
            self.goodsNameCn = @"";
        }
    }
    return self;
}


//保留两位小数
- (NSDecimalNumber *)decimWithnumber:(NSNumber *)number{
    
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber  *newNumber = [[NSDecimalNumber decimalNumberWithString:[number stringValue]] decimalNumberByRoundingAccordingToBehavior:handel];
    
    return newNumber;
}

@end

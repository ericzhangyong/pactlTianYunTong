//
//  ScanModel.m
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ScanModel.h"
#import "NSDictionary+Judge.h"
#import "ScanHisToryModel.h"

@implementation ScanModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        NSDictionary *temdic = dic[@"waybill"];
        
        if (dic[@"waybillno"] !=Nil) {
            self.waybillno = dic[@"waybillno"];
        }else{
            self.waybillno = @"";
        }
        
        
        if (temdic[@"flightNo"] !=Nil) {
            self.flightNo = temdic[@"flightNo"];
        }else{
            self.flightNo = @"";
        }
        
        if (temdic[@"fltDate"] !=Nil) {
            self.fltDate = temdic[@"fltDate"];
        }else{
            self.fltDate = @"";
        }
        
        if (temdic[@"airportDest"] !=Nil) {
            self.airportDest = temdic[@"airportDest"];
        }else{
            self.airportDest = @"";
        }
        
        if (temdic[@"agentOprn"] !=Nil) {
            self.agentOprn = temdic[@"agentOprn"];
        }else{
            self.agentOprn = @"";
        }
        //件数
        if (temdic[@"rcpNo"] !=Nil) {
            
            
            
            self.rcpNo = [temdic[@"rcpNo"] stringValue];
            
            
        }else{
            self.rcpNo = @"0";
        }
        //重量
        if (temdic[@"grossWeight"] !=Nil) {
            
            self.grossWeight = [temdic[@"grossWeight"] stringValue];
            
        }else{
            self.grossWeight = @"0";
        }
        //计费重量
        if (temdic[@"chargeWeight"] !=Nil) {
            
            self.chargeWeight = [temdic[@"chargeWeight"] stringValue];

        }else{
            self.chargeWeight = @"0";
        }
        //体积
        if (temdic[@"vol"] !=Nil) {
            
            self.vol = [[self decimWithnumber:temdic[@"vol"]] stringValue];
            
        }else{
            self.vol = @"0";
        }
        
        if (temdic[@"goodsDesc"] !=Nil) {
            self.goodsDesc = [[temdic[@"goodsDesc"] componentsSeparatedByString:@"\n"] componentsJoinedByString:@" "];
        }else{
            self.goodsDesc = @"";
        }
        
        if (temdic[@"holdCode"] !=Nil) {
            self.holdCode = temdic[@"holdCode"];
        }else{
            self.holdCode = @"";
        }
        
        if (temdic[@"spName"] !=Nil) {
            self.spName = temdic[@"spName"];
        }else{
            self.spName = @"";
        }
        
        if (temdic[@"csName"] !=Nil) {
            self.csName = temdic[@"csName"];
        }else{
            self.csName = @"";
        }
        
        if (temdic[@"eliFlag"] !=Nil) {
            self.eliFlag = temdic[@"eliFlag"];
        }else{
            self.eliFlag = @"";
        }
        
        if (temdic[@"elmFlag"] !=Nil) {
            self.elmFlag = temdic[@"elmFlag"];
        }else{
            self.elmFlag = @"";
        }
        if (temdic[@"subWaybill"] !=nil) {
            self.subWaybill = temdic[@"subWaybill"];
        }else{
            self.subWaybill = nil;
        }
        if (temdic[@"waybill"] !=nil) {
            self.waybill = temdic[@"waybill"];
        }else{
            self.waybill = nil;
        }
        
        if (temdic[@"books"] !=nil) {
            self.books = temdic[@"books"];
        }else{
            self.books = nil;
        }
        /*****************
         ****************字段******************************************/
        
        if (dic[@"isCheck"] !=Nil) {
            self.isCheck = dic[@"isCheck"];
        }else{
            self.isCheck = @"";
        }
        
        
        if ([dic judgekeyAndValueWithKey:@"wb_ele"]) {
            self.Ele = dic[@"wb_ele"];
        }else{
            self.Ele = @"";
        }
        
        if (dic[@"msg"] !=Nil) {
            self.msg = dic[@"msg"];
        }else{
            self.msg = @"";
        }
        
        
        if ([dic judgekeyAndValueWithKey:@"agentShortName"]) {
            self.agentShortName = dic[@"agentShortName"];
        }else{
            self.agentShortName = @"";
        }
        
        //安检布控
        if ([dic judgekeyAndValueWithKey:@"isSc"]) {
            
            if ([dic[@"isSc"] isEqualToString:@"1"]) {
                self.iscontrol = YES;
            }else{
                self.iscontrol = NO;
            }
            
        }else{
            self.iscontrol = NO;
        }
        
        //安保布控
        if ([dic judgekeyAndValueWithKey:@"isTc"]) {
            
            if ([dic[@"isTc"] isEqualToString:@"1"]) {
                self.isABControl = YES;
            }else{
                self.isABControl = NO;
            }
            
        }else{
            self.isABControl = NO;
        }
        
        
        //历史记录
        if ([dic judgekeyAndValueWithKey:@"pCheckFlistVo"]) {
            
            [self HistoryWithArray:dic[@"pCheckFlistVo"]];
            
        }else{
            [self HistoryWithArray:@[]];
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
        
        
        if (dic[@"pCheckRemark"] !=Nil && [dic[@"pCheckRemark"] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *temdic = dic[@"pCheckRemark"];
            self.pCheckRemark = [BZModle new];
            self.pCheckRemark.employid = temdic[@"employid"];
            
            self.pCheckRemark.ID = temdic[@"id"];
            
            self.pCheckRemark.awID = temdic[@"awId"];
            
            self.pCheckRemark.remark = temdic[@"remark"];
            
            self.pCheckRemark.isedit = temdic[@"isedit"];
            
            NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:([temdic[@"createddate"] doubleValue]/1000)];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormatter setDateFormat:@"HH:mm MM/dd "];
            
            self.pCheckRemark.time = [dateFormatter stringFromDate: detailDate];
            
            
            
            
        }else{
            
            self.pCheckRemark.employid = @"";
            
            self.pCheckRemark.ID = @"";
            
            self.pCheckRemark.awID = @"";
            
            self.pCheckRemark.remark =@"";
            
            self.pCheckRemark.isedit = @"";
            
            self.pCheckRemark.time = @"";
            
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

- (void)HistoryWithArray:(NSArray *)Array{
    //记得数组不存在设为空数组
    self.historyArray = [NSArray arrayWithArray:Array];
}

//解挡
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.agentShortName = [aDecoder decodeObjectForKey:@"agentShortName"];
        self.waybillno = [aDecoder decodeObjectForKey:@"waybillno"];
        self.flightNo = [aDecoder decodeObjectForKey:@"flightNo"];
        self.fltDate = [aDecoder decodeObjectForKey:@"fltDate"];
        self.airportDest = [aDecoder decodeObjectForKey:@"airportDest"];
        self.agentOprn = [aDecoder decodeObjectForKey:@"agentOprn"];
        self.rcpNo = [aDecoder decodeObjectForKey:@"rcpNo"];
        self.grossWeight = [aDecoder decodeObjectForKey:@"grossWeight"];
        self.chargeWeight = [aDecoder decodeObjectForKey:@"chargeWeight"];
        self.vol = [aDecoder decodeObjectForKey:@"vol"];
        self.goodsDesc = [aDecoder decodeObjectForKey:@"goodsDesc"];
        self.Ele = [aDecoder decodeObjectForKey:@"Ele"];
        self.eliFlag = [aDecoder decodeObjectForKey:@"eliFlag"];
        self.elmFlag = [aDecoder decodeObjectForKey:@"elmFlag"];
        self.holdCode = [aDecoder decodeObjectForKey:@"holdCode"];
        self.spName = [aDecoder decodeObjectForKey:@"spName"];
        self.csName = [aDecoder decodeObjectForKey:@"csName"];
        self.isCheck = [aDecoder decodeObjectForKey:@"isCheck"];
        self.msg = [aDecoder decodeObjectForKey:@"msg"];
        
        /*****************************************************/
        self.iscontrol = [aDecoder decodeBoolForKey:@"iscontrol"];
        self.isABControl = [aDecoder decodeBoolForKey:@"isABControl"];
        self.historyArray = [aDecoder decodeObjectForKey:@"historyArray"];
        /*****************************************************/
        
    }
    return self;
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.agentShortName forKey:@"agentShortName"];
    [aCoder encodeObject:self.waybillno forKey:@"waybillno"];
    [aCoder encodeObject:self.flightNo forKey:@"flightNo"];
    [aCoder encodeObject:self.fltDate forKey:@"fltDate"];
    [aCoder encodeObject:self.airportDest forKey:@"airportDest"];
    [aCoder encodeObject:self.agentOprn forKey:@"agentOprn"];
    [aCoder encodeObject:self.rcpNo forKey:@"rcpNo"];
    [aCoder encodeObject:self.grossWeight forKey:@"grossWeight"];
    [aCoder encodeObject:self.chargeWeight forKey:@"chargeWeight"];
    [aCoder encodeObject:self.vol forKey:@"vol"];
    [aCoder encodeObject:self.goodsDesc forKey:@"goodsDesc"];
    [aCoder encodeObject:self.Ele forKey:@"Ele"];
    [aCoder encodeObject:self.eliFlag forKey:@"eliFlag"];
    [aCoder encodeObject:self.elmFlag forKey:@"elmFlag"];
    [aCoder encodeObject:self.holdCode forKey:@"holdCode"];
    [aCoder encodeObject:self.spName forKey:@"spName"];
    [aCoder encodeObject:self.csName forKey:@"csName"];
    [aCoder encodeObject:self.isCheck forKey:@"isCheck"];
    [aCoder encodeObject:self.msg forKey:@"msg"];
    
    /*****************************************************/
    [aCoder encodeBool:self.iscontrol forKey:@"iscontrol"];
    [aCoder encodeBool:self.isABControl forKey:@"isABControl"];
    [aCoder encodeObject:self.historyArray forKey:@"historyArray"];
    /*****************************************************/
}

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"waybillno":@[@"waybillNo",@"waybill_no",@"waybillno"],
             @"agentOprn":@[@"agentOprn",@"agent_oprn"],
             @"airportDest":@[@"airportDest",@"dest1"],
             @"rcpNo":@[@"rcpNo",@"total_count"],
             @"grossWeight":@[@"grossWeight",@"gross_weight"],
             @"goodsDesc":@[@"goodsDesc",@"goods_desc"]
    };
}


@end

@implementation ScanBillModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"books":[BooksModel class]
             };
}
@end


@implementation ScanBillSubModel



@end

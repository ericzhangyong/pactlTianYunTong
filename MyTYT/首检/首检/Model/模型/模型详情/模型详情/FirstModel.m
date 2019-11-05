//
//  FirstModel.m
//  MyTYT
//
//  Created by Fly on 2018/4/25.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "FirstModel.h"
#import "BooksModel.h"
#import "NotifiModel.h"
#import "SelectStateModel.h"
#import "NSDictionary+Judge.h"

@implementation FirstModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        
        //新消息
        if (dic[@"isnew"] !=Nil) {
            self.isnew = dic[@"isnew"];
        }else{
            self.isnew = @"";
        }
        
        //订单号ID
        self.ID = dic[@"id"];
        
        //运单ID
        self.awId = dic[@"awId"];
        
        //代理
        self.daili = dic[@"agent_oprn"];
        
        
        
        
        //测试 1是真实
        if (dic[@"is_formal"] != Nil && [dic[@"is_formal"] isEqualToString:@"1"]) {
            self.is_formal = dic[@"is_formal"];
        }
        
        if (dic[@"show_word"] !=Nil) {
            self.show_word = dic[@"show_word"];
        }else{
            self.show_word = @"";
        }
        
        self.testText = @"";

        //代理简称
        
        if ([dic judgekeyAndValueWithKey:@"agent_short_name"]) {
            self.agent_short_name = dic[@"agent_short_name"];
        }else{
            self.agent_short_name = @"";
        }
    
        
        
        
        //电子运单
        self.isEle =  dic[@"wb_ele"];
        
        //运单
        [self setNumberWtihDic:dic];
        
        //操作时间
        [self setTimeWithDic:dic];
        
        //目的港
        self.MUdigang = dic[@"dest1"];
        //件数
        self.jianshu = [dic[@"total_count"] stringValue];
        //重量
        self.zhongliang = [dic[@"gross_weight"] stringValue];
        
        //证书
        [self setBookWithDic:dic];
        
        //通知
        [self setNotifiWithDic:dic];
        
       
        //设置本地操作记录
        [self setLocalState];
        
        //货物类别
        self.type = dic[@"goods_class"];
        
        //操作员工
        self.TextYG = dic[@"personid"];
        
      
        //状态
        if (dic[@"fstatus"] == Nil) {
            self.THOrDD = @"";
        }else{
            //通过状态
            self.THOrDD = dic[@"fstatus"];
        }

        
        //24小时通道
        if (dic[@"aisle24"] == Nil) {

            self.aisle24 = @"";
        }else{
            self.aisle24 = dic[@"aisle24"];

        }
        
        
        //锂电池
        if (dic[@"elm_flag"] == Nil) {
            self.elm_flag = nil;
        }else{
            self.elm_flag = dic[@"elm_flag"];
        }
        //锂电池
        if (dic[@"eli_flag"] == Nil) {
            self.eli_flag = nil;
        }else{
            self.eli_flag = dic[@"eli_flag"];
        }
        
        
        if (dic[@"agent_oprn_id"]!=Nil) {
            self.agent_oprn_id = dic[@"agent_oprn_id"];
        }else{
            self.agent_oprn_id = @"";
        }
        
        if (dic[@"airCode"]!=Nil) {
            self.airCode = dic[@"airCode"];
        }else{
            self.airCode = @"";
        }
        
        //备注
        if (dic[@"count_remark"] !=Nil) {
            self.count_remark = dic[@"count_remark"];
        }else{
            self.count_remark = @"";
        }
        
        //布控
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
        
        //锂电池
        if (dic[@"eli_flag"] == Nil) {
            self.eli_flag = nil;
        }else{
            self.eli_flag = dic[@"eli_flag"];
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
    
        
    
    }
    return self;
}

//设置本地操作记录
- (void)setLocalState{
    
    self.LocalstateModel = [[SelectStateModel alloc] init];
}

//设置时间
- (void)setTimeWithDic:(NSDictionary *)dic{
    
    NSMutableString *datestr = [NSMutableString stringWithFormat:@"%@",dic[@"operatdate"]];


    NSString *str  =[[datestr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n\t\t"]] componentsJoinedByString:@" "];
   NSString *newstr = [str stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@""];
    self.time = [NSString stringWithString:newstr];
}

//设置单号
- (void)setNumberWtihDic:(NSDictionary *)dic{
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",dic[@"waybill_no"]];
    
    [str insertString:@"-" atIndex:3];
    
    self.ALLNUmber = [NSString stringWithString:str];
}

//设置证书
- (void)setBookWithDic:(NSDictionary *)dic{
    
    self.booksCount = dic[@"count_books"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    if ([dic[@"books"] isKindOfClass:[NSArray class]] && [dic[@"books"] count] > 0) {
        
        for (NSDictionary *temdic in dic[@"books"]) {
            BooksModel *mdoel = [[BooksModel alloc] initWithDic:temdic];
            [array addObject:mdoel];
        }
        
        self.bookArray = [NSArray arrayWithArray:array];
    }

}

//设置通知
- (void)setNotifiWithDic:(NSDictionary *)dic{
    
    self.count_notice = dic[@"count_notice"];
    
    if ([dic[@"notice"] isKindOfClass:[NSArray class]] && [dic[@"notice"] count] > 0) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *temdic in dic[@"notice"]) {
            NotifiModel *mdoel = [[NotifiModel alloc] initWithDic:temdic];
            [array addObject:mdoel];
        }
        
        self.noticeArray = [NSArray arrayWithArray:array];
    }
}

#pragma mark------------------------------------------------------------------------------------
//status = 200;
//data = {
//    list =             (
//                        {
//                            dest1 = "MUC";
//                            account = "17476";
//                            agent_oprn = "TRA";
//                            waybill_no = "58016592214";
//                            awId = "377215c3385444bf8b64c133d24f3e9d";
//                            count_books = "0";
//                            personid = "17476";
//                            books =                     (
//                            );
//                            sstatus = "0";
//                            agent_oprn_id = "14051";
//                            operatdate = "2018-05-20
//                            16:18:02";
//                            airCode = "RU";
//                            id = "2121ad3f9e9c43a4adcf2f3bd0b618a4";
//                            agent_oprn_name = "TRA training";
//                            agent_iata_code = "0000141";
//                            total_count = 1;
//                            fstatus = "1";
//                            count_notice = "1";
//                            notice =                     (
//                                                          {
//                                                              status = "0";
//                                                              fromid = "17476";
//                                                              toid = "7";
//                                                              id = "a2c1783985e6475b9aaf5f2fef089c41";
//                                                              deleted = "0";
//                                                              firstid = "2121ad3f9e9c43a4adcf2f3bd0b618a4";
//                                                              createddate = 1526805309817;
//                                                              msg = "[{"id":"3","name":"扣押:证书不全","type":"0","checked":true}]";
//                                                              isnew = "0";
//                                                              awId = "377215c3385444bf8b64c133d24f3e9d";
//                                                          }
//                                                          );
//                            goods_class = "0";
//                            isnew = "0";
//                            count_remark = "1";
//                            agent_sales = "TRA";
//                            reinsert = "0";
//                            gross_weight = 10;
//                            machine = "7";
//                        },
//                        {
//                            dest1 = "MIA";
//                            account = "17476";
//                            agent_oprn = "TRA";
//                            elm_flag = "1";
//                            waybill_no = "04377333270";
//                            wb_ele = "1";
//                            awId = "b058c20ad4374e6e8db0a40360234d1d";
//                            count_books = "0";
//                            personid = "17476";
//                            books =                     (
//                            );
//                            sstatus = "1";
//                            agent_oprn_id = "14051";
//                            operatdate = "2018-05-20
//                            16:28:57";
//                            airCode = "CX";
//                            id = "8c80b70d965f4fa1be088c65f9218847";
//                            agent_oprn_name = "DHL GLOBAL FORWARDING CHINA";
//                            agent_iata_code = "0000141";
//                            total_count = 4;
//                            fstatus = "0";
//                            count_notice = "1";
//                            notice =                     (
//                                                          {
//                                                              status = "0";
//                                                              fromid = "17476";
//                                                              toid = "7";
//                                                              id = "4b876dc164b14bbc8ccffe0731e73d19";
//                                                              deleted = "0";
//                                                              firstid = "8c80b70d965f4fa1be088c65f9218847";
//                                                              createddate = 1526805310828;
//                                                              msg = "[{"id":"7","name":"通过:已排除隐含危险品可能","type":"1","checked":true}]";
//                                                              isnew = "0";
//                                                              awId = "b058c20ad4374e6e8db0a40360234d1d";
//                                                          }
//                                                          );
//                            goods_class = "0";
//                            isnew = "0";
//                            dest2 = "MIA";
//                            agent_sales = "TRA";
//                            count_remark = "0";
//                            gross_weight = 580;
//                            reinsert = "0";
//                            machine = "7";
//                            eli_flag = "0";
//                        },
//                        {
//                            dest1 = "PEN";
//                            account = "17476";
//                            agent_oprn = "TRA";
//                            waybill_no = "04377333303";
//                            wb_ele = "1";
//                            awId = "71a3155ece014e4face89efd69a5058c";
//                            count_books = "0";
//                            personid = "17476";
//                            books =                     (
//                            );
//                            sstatus = "1";
//                            agent_oprn_id = "14051";
//                            operatdate = "2018-05-20
//                            16:24:15";
//                            airCode = "KA";
//                            id = "9eea30d8e4034b7cb7321744fc9cd5bd";
//                            agent_oprn_name = "DHL GLOBAL FORWARDING CHINA";
//                            agent_iata_code = "0000141";
//                            total_count = 7;
//                            fstatus = "0";
//                            count_notice = "1";
//                            notice =                     (
//                                                          {
//                                                              status = "0";
//                                                              fromid = "17476";
//                                                              toid = "7";
//                                                              id = "418fa659479c493091b9eac5a0ed0acb";
//                                                              deleted = "0";
//                                                              firstid = "9eea30d8e4034b7cb7321744fc9cd5bd";
//                                                              createddate = 1526805310412;
//                                                              msg = "[{"id":"4","name":"通过:证书已全","type":"1","checked":true}]";
//                                                              isnew = "0";
//                                                              awId = "71a3155ece014e4face89efd69a5058c";
//                                                          }
//                                                          );
//                            goods_class = "0";
//                            isnew = "0";
//                            dest2 = "PEN";
//                            agent_sales = "TRA";
//                            count_remark = "0";
//                            gross_weight = 583;
//                            reinsert = "0";
//                            machine = "7";
//                        },
//                        {
//                            dest1 = "FRA";
//                            account = "17476";
//                            agent_oprn = "TRA";
//                            waybill_no = "58016592262";
//                            awId = "67af0af4bc76469ba5bfac7d6a23ffcf";
//                            count_books = "0";
//                            personid = "17476";
//                            books =                     (
//                            );
//                            sstatus = "1";
//                            agent_oprn_id = "14051";
//                            operatdate = "2018-05-20
//                            16:17:25";
//                            airCode = "RU";
//                            id = "13a113332d8d484d9966440dca04822f";
//                            agent_oprn_name = "TRA training";
//                            agent_iata_code = "0000141";
//                            total_count = 6;
//                            fstatus = "0";
//                            count_notice = "1";
//                            notice =                     (
//                                                          {
//                                                              status = "0";
//                                                              fromid = "17476";
//                                                              toid = "7";
//                                                              id = "26dee807747b40c9b2fac1079e4353df";
//                                                              deleted = "0";
//                                                              firstid = "13a113332d8d484d9966440dca04822f";
//                                                              createddate = 1526805309729;
//                                                              msg = "[{"id":"b877fa19f8284a92a45081039a9f52d9","name":"通过:厂家24小时联系电话已打通","type":"1","checked":true}]";
//                                                              isnew = "0";
//                                                              awId = "67af0af4bc76469ba5bfac7d6a23ffcf";
//                                                          }
//                                                          );
//                            goods_class = "0";
//                            isnew = "0";
//                            count_remark = "0";
//                            agent_sales = "TRA";
//                            reinsert = "0";
//                            gross_weight = 919;
//                            machine = "7";
//                        },
//                        {
//                            dest1 = "VIE";
//                            account = "17476";
//                            agent_oprn = "DHL";
//                            eli_flag = "1";
//                            waybill_no = "99905150003";
//                            wb_ele = "0";
//                            elm_flag = "1";
//                            awId = "546e104318a34e5e954e12ceddbe05ff";
//                            count_books = "1";
//                            personid = "17476";
//                            books =                     (
//                                                         {
//                                                             id = "1526383483134619";
//                                                             bookType = "sharing";
//                                                             bookNo = "201805151916";
//                                                             officeCode = "SHY";
//                                                             goodsType = "101";
//                                                             creater = "17476";
//                                                             createdDate = 1526383483113;
//                                                             deviceId = "1";
//                                                             bookId = "d11746c8065c4b4da3f23a0a64575903";
//                                                             deleteFlag = "0";
//                                                             checkVisual = "1";
//                                                             flag = "1";
//                                                             officeName = "上化院";
//                                                             ocId = "d703a75aa32648088a362e2b5a72faf5";
//                                                             bookCheckType = "book";
//                                                             status = "0";
//                                                             awId = "546e104318a34e5e954e12ceddbe05ff";
//                                                         }
//                                                         );
//                            agent_oprn_id = "1115";
//                            operatdate = "2018-05-20
//                            21:44:16";
//                            airCode = "CA";
//                            id = "02977c8177ee402e9c312020096889e0";
//                            agent_oprn_name = "DHL";
//                            agent_iata_code = "0830696";
//                            dest3 = "VIE";
//                            total_count = 9999;
//                            fstatus = "0";
//                            count_notice = "0";
//                            goods_class = "1";
//                            notice =                     (
//                            );
//                            dest2 = "AMS";
//                            agent_sales = "DHL";
//                            count_remark = "13";
//                            gross_weight = 99999;
//                            isnew = "0";
//                            machine = "7";
//                            reinsert = "0";
//                            ref_status = "-1";
//                        },
//                        {
//                            dest1 = "FRA";
//                            account = "17476";
//                            agent_oprn = "XYZ";
//                            waybill_no = "58016584595";
//                            awId = "f4f83fdfd2c44fed88afe29c4162496b";
//                            count_books = "0";
//                            personid = "17476";
//                            books =                     (
//                            );
//                            agent_oprn_id = "10224";
//                            operatdate = "2018-05-18
//                            13:30:27";
//                            airCode = "RU";
//                            id = "358df111252e4b36b260765c154fc69c";
//                            agent_oprn_name = "JHX CO LTD";
//                            total_count = 276;
//                            fstatus = "0";
//                            count_notice = "0";
//                            notice =                     (
//                            );
//                            reinsert = "0";
//                            goods_class = "0";
//                            isnew = "0";
//                            count_remark = "142";
//                            agent_sales = "JHX";
//                            gross_weight = 33276;
//                            machine = "7";
//                        },
//                        {
//                            dest1 = "AMS";
//                            account = "17476";
//                            agent_oprn = "DHL";
//                            waybill_no = "87152008073";
//                            wb_ele = "0";
//                            awId = "a36504c1d8a346e1b177d78adcd14360";
//                            count_books = "0";
//                            personid = "17476";
//                            books =                     (
//                            );
//                            agent_oprn_id = "1115";
//                            operatdate = "2018-05-17
//                            08:52:09";
//                            airCode = "Y8";
//                            id = "81ce504b4278450897822bc25f5b4dcb";
//                            agent_oprn_name = "DHL";
//                            agent_iata_code = "0830696";
//                            total_count = 16;
//                            fstatus = "0";
//                            count_notice = "0";
//                            notice =                     (
//                            );
//                            goods_class = "0";
//                            isnew = "0";
//                            count_remark = "1";
//                            agent_sales = "DHL";
//                            reinsert = "0";
//                            gross_weight = 2050;
//                            ref_status = "-1";
//                            machine = "7";
//                        },
//                        {
//                            dest1 = "LHR";
//                            account = "17476";
//                            agent_oprn = "DHL";
//                            elm_flag = "0";
//                            waybill_no = "17657555455";
//                            awId = "f1fc21deac6e496fb2ed4245229984a2";
//                            count_books = "0";
//                            personid = "17476";
//                            books =                     (
//                            );
//                            agent_oprn_id = "1115";
//                            operatdate = "2018-05-15
//                            16:20:05";
//                            airCode = "EK";
//                            id = "31cf1ef7647f4e33b142b6ac6d9f6d08";
//                            agent_oprn_name = "JHX";
//                            total_count = 4;
//                            fstatus = "0";
//                            count_notice = "0";
//                            notice =                     (
//                            );
//                            reinsert = "0";
//                            goods_class = "0";
//                            isnew = "0";
//                            count_remark = "2";
//                            agent_sales = "JHX";
//                            eli_flag = "1";
//                            gross_weight = 4000;
//                            machine = "7";
//                        },
//                        {
//                            dest1 = "KWI";
//                            account = "17476";
//                            agent_oprn = "DHL";
//                            elm_flag = "0";
//                            waybill_no = "17658382870";
//                            awId = "32a56f2fc67c4f8888ef79fa7284997f";
//                            count_books = "1";
//                            personid = "17476";
//                            books =                     (
//                                                         {
//                                                             id = "1505297008345038";
//                                                             bookType = "sharing";
//                                                             bookNo = "SHY81";
//                                                             officeCode = "SHY";
//                                                             goodsType = "102";
//                                                             creater = "17476";
//                                                             createdDate = 1505297008322;
//                                                             deviceId = "1";
//                                                             bookId = "4a0e96841b2b48da85382ae3fa0c59f1";
//                                                             deleteFlag = "0";
//                                                             checkVisual = "1";
//                                                             flag = "1";
//                                                             officeName = "上化院";
//                                                             ocId = "d703a75aa32648088a362e2b5a72faf5";
//                                                             bookCheckType = "book";
//                                                             status = "0";
//                                                             awId = "32a56f2fc67c4f8888ef79fa7284997f";
//                                                         }
//                                                         );
//                            agent_oprn_id = "1115";
//                            operatdate = "2018-05-14
//                            12:35:15";
//                            airCode = "EK";
//                            id = "b6cf61e800714b92abd96ce6bca40e95";
//                            agent_oprn_name = "FAF";
//                            agent_iata_code = "2468357";
//                            total_count = 10;
//                            fstatus = "0";
//                            count_notice = "0";
//                            notice =                     (
//                            );
//                            goods_class = "0";
//                            isnew = "0";
//                            count_remark = "1";
//                            agent_sales = "JHX";
//                            reinsert = "0";
//                            gross_weight = 1000;
//                            eli_flag = "1";
//                            machine = "7";
//                        },
//                        {
//                            dest1 = "ORD";
//                            account = "17476";
//                            agent_oprn = "DHL";
//                            waybill_no = "99985774813";
//                            awId = "878381621a0e44ff8c1902dbe1293cae";
//                            count_books = "2";
//                            personid = "17476";
//                            books =                     (
//                                                         {
//                                                             id = "1521709163292329";
//                                                             bookType = "sharing";
//                                                             bookNo = "21180224001";
//                                                             officeCode = "SHY";
//                                                             goodsType = "102";
//                                                             creater = "17476";
//                                                             createdDate = 1521709163267;
//                                                             deviceId = "1";
//                                                             bookId = "51d1f653e661474f857cb497d0c34fed";
//                                                             deleteFlag = "0";
//                                                             checkVisual = "1";
//                                                             flag = "1";
//                                                             officeName = "上化院";
//                                                             ocId = "d703a75aa32648088a362e2b5a72faf5";
//                                                             bookCheckType = "book";
//                                                             status = "0";
//                                                             awId = "878381621a0e44ff8c1902dbe1293cae";
//                                                         },
//                                                         {
//                                                             id = "1525764118562279";
//                                                             bookType = "sharing";
//                                                             bookNo = "2018003";
//                                                             officeCode = "SHY";
//                                                             goodsType = "102";
//                                                             creater = "17476";
//                                                             createdDate = 1525764118543;
//                                                             deviceId = "1";
//                                                             bookId = "717609d777034a0f87173cf70efcc922";
//                                                             deleteFlag = "0";
//                                                             checkVisual = "1";
//                                                             flag = "1";
//                                                             officeName = "上海化工研究院检测中心";
//                                                             ocId = "d703a75aa32648088a362e2b5a72faf5";
//                                                             bookCheckType = "book";
//                                                             status = "0";
//                                                             awId = "878381621a0e44ff8c1902dbe1293cae";
//                                                         }
//                                                         );
//                            agent_oprn_id = "1115";
//                            operatdate = "2018-05-14
//                            17:57:42";
//                            airCode = "CA";
//                            id = "da8a69d9ccd5426686d700c7b74dc1bc";
//                            agent_oprn_name = "DHL";
//                            agent_iata_code = "0830696";
//                            total_count = 4;
//                            fstatus = "";
//                            count_notice = "0";
//                            notice =                     (
//                            );
//                            goods_class = "0";
//                            isnew = "0";
//                            count_remark = "9";
//                            agent_sales = "DHL";
//                            reinsert = "0";
//                            gross_weight = 692;
//                            machine = "7";
//                        },
//                        {
//                            dest1 = "ADD";
//                            account = "17476";
//                            agent_oprn = "DHL";
//                            waybill_no = "00105090094";
//                            wb_ele = "1";
//                            awId = "1495679453985450";
//                            count_books = "0";
//                            personid = "17476";
//                            books =                     (
//                            );
//                            agent_oprn_id = "1115";
//                            operatdate = "2018-05-13
//                            09:07:00";
//                            airCode = "CA";
//                            id = "ef17365062534dc1bc039884cfa7c658";
//                            agent_oprn_name = "BEIJINGKANG JIE KONG CARGO AGENT CO";
//                            agent_iata_code = "0830696";
//                            total_count = 10;
//                            fstatus = "";
//                            count_notice = "0";
//                            notice =                     (
//                            );
//                            goods_class = "0";
//                            isnew = "0";
//                            count_remark = "2";
//                            agent_sales = "DHL";
//                            reinsert = "0";
//                            gross_weight = 100;
//                            ref_status = "-1";
//                            machine = "7";
//                        },
//                        {
//                            dest1 = "DWC";
//                            account = "17476";
//                            agent_oprn = "DHL";
//                            elm_flag = "0";
//                            waybill_no = "07977777770";
//                            wb_ele = "0";
//                            awId = "0661c8dbd6d940e8b27bafbbd03e15cc";
//                            is_formal = "1";
//                            count_books = "0";
//                            personid = "17476";
//                            books =                     (
//                            );
//                            show_word = "正";
//                            agent_oprn_id = "1115";
//                            operatdate = "2018-05-12
//                            11:24:50";
//                            airCode = "CA";
//                            id = "cc6706aff1824e6888a84bcf568404d0";
//                            agent_oprn_name = "DHL";
//                            agent_iata_code = "0830696";
//                            total_count = 90;
//                            fstatus = "";
//                            count_notice = "0";
//                            notice =                     (
//                            );
//                            goods_class = "0";
//                            isnew = "0";
//                            count_remark = "0";
//                            agent_sales = "DHL";
//                            reinsert = "0";
//                            gross_weight = 90;
//                            ref_status = "-1";
//                            machine = "7";
//                            eli_flag = "1";
//                        }
//                        );
//};
//msg = "ok";
//ok = 1;
//}


@end

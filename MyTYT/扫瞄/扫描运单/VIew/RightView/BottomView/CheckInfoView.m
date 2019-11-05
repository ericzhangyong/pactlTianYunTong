//
//  CheckInfoView.m
//  MyTYT
//
//  Created by zhangyong on 2019/11/4.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CheckInfoView.h"

@implementation CheckInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    

    self.label_minuteOrder = [[LeftLable alloc] initWithTitle:@"分单号:"];
    self.label_zhongWenPinMing = [[LeftLable alloc] initWithTitle:@"中文品名:"];
    self.label_allOrderNum = [[LeftLable alloc] initWithTitle:@"总单号:"];
    self.label_muDiGangKou = [[LeftLable alloc] initWithTitle:@"分单目的港口:"];
    self.label_allMuDiGangKou= [[LeftLable alloc] initWithTitle:@"总单目的港口:"];
    self.label_daiLi = [[LeftLable alloc] initWithTitle:@"代理:"];
    self.label_zhengShu =  [[LeftLable alloc] initWithTitle:@"证书:"];
    self.imageView_pdf = [UIImageView new];
    self.imageView_pdf.image = [UIImage imageNamed:@"pdf"];
    self.imageView_pdf.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.imageView_pdf addGestureRecognizer:tapGest];
   
    self.label_minuteOrderContent = [[RightLable alloc] init];
    self.label_zhongWenPinMingContent = [[RightLable alloc] init];
    self.label_allOrderNumContent = [[RightLable alloc] init];
    self.label_muDiGangKouContent = [[RightLable alloc] init];
    self.label_allMuDiGangKouContent = [[RightLable alloc] init];
    self.label_daiLiContent = [[RightLable alloc] init];
    
    [self addSubview:self.label_minuteOrder];
    [self addSubview:self.label_zhengShu];
    [self addSubview:self.imageView_pdf];
    [self addSubview:self.label_zhongWenPinMing];
    [self addSubview:self.label_allOrderNum];
    [self addSubview:self.label_muDiGangKou];
    [self addSubview:self.label_allMuDiGangKou];
    [self addSubview:self.imageView_pdf];
    [self addSubview:self.label_daiLi];
    [self addSubview:self.label_minuteOrderContent];
    [self addSubview:self.label_zhongWenPinMingContent];
    [self addSubview:self.label_allOrderNumContent];
    [self addSubview:self.label_muDiGangKouContent];
    [self addSubview:self.label_allMuDiGangKouContent];
    [self addSubview:self.label_daiLiContent];
    
    [self addSubview:self.label_eleAllOrder];
    [self addSubview:self.label_eleMinuteOrder];
}

- (void)loaddataWithscanModel:(ScanBillModel *)billModel{
    
    if (billModel) {
        ScanModel *allBillMoel = billModel.waybill;
        ScanModel *subBillModel = billModel.subWaybill;
        
        
        self.label_minuteOrderContent.text = subBillModel.waybillno;
        self.label_zhongWenPinMingContent.text = subBillModel.goodsDesc;
        self.label_allOrderNumContent.text = allBillMoel.waybillno;
        self.label_muDiGangKouContent.text = subBillModel.airportDest;
        self.label_daiLiContent.text = subBillModel.agentOprn;
        self.label_allMuDiGangKouContent.text = allBillMoel.airportDest;

        if ([subBillModel.Ele isEqualToString:@"1"] && ![BaseVerifyUtils isNullOrSpaceStr:subBillModel.waybillno]) {
               self.label_eleMinuteOrder.hidden =NO;
        }else{
               self.label_eleMinuteOrder.hidden = YES;
        }
        if ([allBillMoel.Ele isEqualToString:@"1"] && ![BaseVerifyUtils isNullOrSpaceStr:allBillMoel.waybillno]) {
               self.label_eleAllOrder.hidden =NO;
        }else{
               self.label_eleAllOrder.hidden = YES;
        }
        
        //证书
        if (billModel.books >0) {
            self.imageView_pdf.image = [UIImage imageNamed:@"pdf2"];
            self.imageView_pdf.userInteractionEnabled = YES;
        }else{
            self.imageView_pdf.image = [UIImage imageNamed:@"pdf"];
            self.imageView_pdf.userInteractionEnabled = NO;
        }
    }else{
        self.label_minuteOrderContent.text = @"";
        self.label_zhongWenPinMingContent.text = @"";
        self.label_allOrderNumContent.text = @"";
        self.label_muDiGangKouContent.text = @"";
        self.label_daiLiContent.text = @"";
        self.label_allMuDiGangKouContent.text = @"";
        //证书
        if (billModel.books >0) {
            self.imageView_pdf.image = [UIImage imageNamed:@"pdf2"];
            self.imageView_pdf.userInteractionEnabled = YES;
        }else{
            self.imageView_pdf.image = [UIImage imageNamed:@"pdf"];
            self.imageView_pdf.userInteractionEnabled = NO;
        }
    }

}

- (NSMutableAttributedString *)setELWithModel:(ScanModel *)model{
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.goodsDesc] attributes:@{}];
    
    NSMutableAttributedString *ELI;
    NSMutableAttributedString *ELM;
    
    if ([model.eliFlag isEqualToString:@"1"]) {
        
        [attribute appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" " attributes:nil]];
        
        ELI = [[NSMutableAttributedString alloc] initWithString:@"ELI" attributes:@{
                                                                                    NSBackgroundColorAttributeName:ELICOlor,
                                                                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                                    NSLigatureAttributeName:[NSNumber numberWithInt:1],
                                                                                    NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                    }];
        [attribute appendAttributedString:ELI];
        
        
    }
    
    
    
    if ([model.elmFlag isEqualToString:@"1"]) {
        
        [attribute appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" " attributes:nil]];
        
        ELM = [[NSMutableAttributedString alloc] initWithString:@"ELM" attributes:@{
                                                                                    NSBackgroundColorAttributeName:ELICOlor,
                                                                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                                    NSLigatureAttributeName:[NSNumber numberWithInt:1], NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                    }];
        [attribute appendAttributedString:ELM];
        
    }
    return attribute;
}

-(void)tapClick{
    if (self.zhengShuClick) {
        self.zhengShuClick(YES);
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat height = self.bounds.size.height;
    CGFloat MAxheight = (height - 7*20)/8;
    [self layoutWithMAxHeight:MAxheight];
}
- (void)layoutWithMAxHeight:(CGFloat)maxHeight{

    [self.label_minuteOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.mas_equalTo(80);
    }];

    [self.label_minuteOrderContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_minuteOrder.mas_right).offset(20);
        make.centerY.equalTo(self.label_minuteOrder);
    }];
    
    [self.label_eleMinuteOrder mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.label_minuteOrderContent.mas_right).offset(5);
           make.centerY.equalTo(self.label_minuteOrderContent);
           make.width.height.equalTo(@20);
    }];
    
    [self.label_zhengShu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_eleMinuteOrder.mas_right).offset(20);
        make.centerY.equalTo(self.label_minuteOrder);
    }];
    [self.imageView_pdf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_zhengShu.mas_right).offset(20);
        make.centerY.equalTo(self.label_zhengShu);
        make.width.height.mas_equalTo(20);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
    }];
    

    [self.label_zhongWenPinMing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_minuteOrder.mas_bottom).offset(20);
        make.left.equalTo(self.label_minuteOrder);
        make.width.mas_equalTo(80);
    }];


    [self.label_zhongWenPinMingContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_zhongWenPinMing.mas_right).offset(20);
        make.centerY.equalTo(self.label_zhongWenPinMing);
        make.right.equalTo(self).offset(-20);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
    }];

    
    [self.label_allOrderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_minuteOrder);
        make.top.equalTo(self.label_zhongWenPinMing.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
    }];
    
    
    [self.label_allOrderNumContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_allOrderNum.mas_right).offset(20);
        make.centerY.equalTo(self.label_allOrderNum);
        make.right.equalTo(self).offset(-20);
    }];
    [self.label_eleAllOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_allOrderNumContent.mas_right).offset(5);
        make.centerY.equalTo(self.label_allOrderNumContent);
        make.width.height.equalTo(@20);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
    }];
    
    [self.label_muDiGangKou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_minuteOrder);
        make.top.equalTo(self.label_allOrderNum.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
    }];
    [self.label_muDiGangKouContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_muDiGangKou.mas_right).offset(20);
        make.centerY.equalTo(self.label_muDiGangKou);
    }];
    
   [self.label_allMuDiGangKou mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.label_muDiGangKouContent.mas_right).offset(20);
       make.centerY.equalTo(self.label_muDiGangKouContent);
   }];
   [self.label_allMuDiGangKouContent mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.label_allMuDiGangKou.mas_right).offset(10);
       make.centerY.equalTo(self.label_allMuDiGangKou);
       make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
   }];
       
    
    [self.label_daiLi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_muDiGangKou.mas_bottom).offset(20);
        make.left.equalTo(self.label_minuteOrder);
        make.width.mas_equalTo(80);
    }];
    
    [self.label_daiLiContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_daiLi.mas_right).offset(20);
        make.right.lessThanOrEqualTo(self);
        make.centerY.equalTo(self.label_daiLi);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
    }];
}

- (UILabel *)label_eleMinuteOrder{
    if (!_label_eleMinuteOrder) {
        _label_eleMinuteOrder = [[UILabel alloc] init];
       _label_eleMinuteOrder.backgroundColor = [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00];
        _label_eleMinuteOrder.text = @"E";
        _label_eleMinuteOrder.textAlignment = NSTextAlignmentCenter;
        _label_eleMinuteOrder.font = [UIFont systemFontOfSize:15];
        _label_eleMinuteOrder.layer.masksToBounds = YES;
        _label_eleMinuteOrder.layer.cornerRadius = 10;
        _label_eleMinuteOrder.textColor = [UIColor whiteColor];
    }
    return _label_eleMinuteOrder;
}
- (UILabel *)label_eleAllOrder{
    if (!_label_eleAllOrder) {
        _label_eleAllOrder = [[UILabel alloc] init];
       _label_eleAllOrder.backgroundColor = [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00];
        _label_eleAllOrder.text = @"E";
        _label_eleAllOrder.textAlignment = NSTextAlignmentCenter;
        _label_eleAllOrder.font = [UIFont systemFontOfSize:15];
        _label_eleAllOrder.layer.masksToBounds = YES;
        _label_eleAllOrder.layer.cornerRadius = 10;
        _label_eleAllOrder.textColor = [UIColor whiteColor];
    }
    return _label_eleAllOrder;
}


@end

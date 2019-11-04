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
    

    self.label_minuteOrder = [[LeftLable alloc] initWithTitle:@"分单号"];
    self.label_zhongWenPinMing = [[LeftLable alloc] initWithTitle:@"中文品名"];
    self.label_allOrderNum = [[LeftLable alloc] initWithTitle:@"总单号"];
    self.label_muDiGangKou = [[LeftLable alloc] initWithTitle:@"目的港口"];
    self.label_daiLi = [[LeftLable alloc] initWithTitle:@"代理"];
    self.label_zhengShu =  [[LeftLable alloc] initWithTitle:@"证书"];
    self.imageView_pdf = [UIImageView new];
    self.imageView_pdf.image = [UIImage imageNamed:@"pdf"];
    self.imageView_pdf.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.imageView_pdf addGestureRecognizer:tapGest];
   
    self.label_minuteOrderContent = [[RightLable alloc] init];
    self.label_zhongWenPinMingContent = [[RightLable alloc] init];
    self.label_allOrderNumContent = [[RightLable alloc] init];
    self.label_muDiGangKouContent = [[RightLable alloc] init];
    self.label_daiLiContent = [[RightLable alloc] init];
    
    [self addSubview:self.label_minuteOrder];
    [self addSubview:self.label_zhengShu];
    [self addSubview:self.imageView_pdf];
    [self addSubview:self.label_zhongWenPinMing];
    [self addSubview:self.label_allOrderNum];
    [self addSubview:self.label_muDiGangKou];
    [self addSubview:self.imageView_pdf];
    [self addSubview:self.label_daiLi];
    [self addSubview:self.label_minuteOrderContent];
    [self addSubview:self.label_zhongWenPinMingContent];
    [self addSubview:self.label_allOrderNumContent];
    [self addSubview:self.label_muDiGangKouContent];
    [self addSubview:self.label_daiLiContent];
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
    }];

    [self.label_minuteOrderContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_minuteOrder.mas_right).offset(20);
        make.centerY.equalTo(self.label_minuteOrder);
        make.right.equalTo(self).offset(-20);
    }];
    
    [self.label_zhengShu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_minuteOrder.mas_right).offset(20);
        make.centerY.equalTo(self.label_minuteOrder);
    }];
    [self.imageView_pdf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_zhengShu.mas_right).offset(20);
        make.centerY.equalTo(self.label_zhengShu);
        make.width.height.mas_equalTo(20);
    }];
    

    [self.label_zhongWenPinMing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_minuteOrder.mas_bottom).offset(20);
        make.left.equalTo(self.label_minuteOrder);
    }];


    [self.label_zhongWenPinMingContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_zhongWenPinMing.mas_right).offset(20);
        make.centerY.equalTo(self.label_zhongWenPinMing);
        make.right.equalTo(self).offset(-20);
    }];

    
    [self.label_allOrderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_minuteOrder);
        make.top.equalTo(self.label_zhongWenPinMing.mas_bottom).offset(20);
    }];
    
    
    [self.label_allOrderNumContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_allOrderNum.mas_right).offset(20);
        make.centerY.equalTo(self.label_allOrderNum);
        make.right.equalTo(self).offset(-20);
    }];
    
    [self.label_muDiGangKou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_minuteOrder);
        make.top.equalTo(self.label_allOrderNum.mas_bottom).offset(20);
    }];
    [self.label_muDiGangKouContent mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.label_muDiGangKou.mas_right).offset(20);
        make.centerY.equalTo(self.label_muDiGangKou);
        make.right.equalTo(self).offset(-20);
       }];
       
    
    [self.label_daiLi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_muDiGangKou.mas_bottom).offset(20);
        make.left.equalTo(self.label_minuteOrder);
    }];
    
    [self.label_daiLiContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_daiLi).offset(20);
        make.right.lessThanOrEqualTo(self);
        make.centerY.equalTo(self.label_daiLi);
    }];
}

@end

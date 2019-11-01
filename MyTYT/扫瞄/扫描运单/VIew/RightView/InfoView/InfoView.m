//
//  InfoView.m
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "InfoView.h"
#import "LeftLable.h"
#import "Masonry.h"
#import "RightLable.h"
#import "ScanModel.h"

@implementation InfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
        
    }
    return self;
}

- (void)layoutSubviews{
    
   CGFloat height = self.bounds.size.height;
    
    CGFloat MAxheight = (height - 7*20)/8;
    
    [self layoutWithMAxHeight:MAxheight];

}

- (void)loaddataWithscanModel:(ScanModel *)mdoel{
    
    self.YDH.text = mdoel.waybillno;
    
    self.HB.text = [NSString stringWithFormat:@"%@  %@",mdoel.flightNo,mdoel.fltDate];

    self.MDG.text = mdoel.airportDest;

    self.DL.text = [mdoel.agentShortName isEqualToString:@""] ? mdoel.agentOprn : mdoel.agentShortName;
    
    self.JS.text = mdoel.rcpNo;
    
    self.ZL.text = mdoel.grossWeight;
    
    self.JFZL.text = mdoel.chargeWeight;
    
    self.TJ.text = mdoel.vol;
    
    self.THDM.text = mdoel.holdCode;
    
    self.FHR.text = mdoel.spName;
    
    self.SHR.text = mdoel.csName;
    
    if ([mdoel.Ele isEqualToString:@"1"]) {
        self.eleLable.hidden =NO;
    }else{
        self.eleLable.hidden = YES;
    }
    
    [self setELWithModel:mdoel];
    

    [self setNeedsUpdateConstraints];
    
    [self updateConstraintsIfNeeded];


}

- (void)setELWithModel:(ScanModel *)model{
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
    
    self.PM.attributedText = attribute;
}

#pragma mark------------------------------------------------------------------------------------

- (void)creatUI{
    
    self.allnumberlable = [[LeftLable alloc] initWithTitle:@"运单号"];
    self.hangbanlable = [[LeftLable alloc] initWithTitle:@"航班"];
    self.mudiganglable = [[LeftLable alloc] initWithTitle:@"目的港"];
    self.daililable = [[LeftLable alloc] initWithTitle:@"代理"];
    
    self.jianshulable = [[LeftLable alloc] initWithTitle:@"件数"];
    self.zhonglianglable = [[LeftLable alloc] initWithTitle:@"重量"];
    self.jifeizhiagianglable = [[LeftLable alloc] initWithTitle:@"计费重量"];
    self.tijilable = [[LeftLable alloc] initWithTitle:@"体积"];
    
    self.pinminglable = [[LeftLable alloc] initWithTitle:@"品名"];
    self.tehuodaimalable = [[LeftLable alloc] initWithTitle:@"特货代码"];
    self.fahuorenlable = [[LeftLable alloc] initWithTitle:@"发货人"];
    self.shouhuorenlable = [[LeftLable alloc] initWithTitle:@"收货人"];
    
    [self addSubview:self.allnumberlable];
    [self addSubview:self.hangbanlable];
    [self addSubview:self.mudiganglable];
    [self addSubview:self.daililable];
    
    [self addSubview:self.jianshulable];
    [self addSubview:self.zhonglianglable];
    [self addSubview:self.tijilable];
    [self addSubview:self.jifeizhiagianglable];
    
    [self addSubview:self.pinminglable];
    [self addSubview:self.tehuodaimalable];
    [self addSubview:self.fahuorenlable];
    [self addSubview:self.shouhuorenlable];

    
    
    self.YDH = [[RightLable alloc] init];
    self.HB = [[RightLable alloc] init];
    self.MDG = [[RightLable alloc] init];
    self.DL = [[RightLable alloc] init];
    
    self.JS = [[RightLable alloc] init];
    self.ZL = [[RightLable alloc] init];
    self.JFZL = [[RightLable alloc] init];
    self.TJ = [[RightLable alloc] init];
    
    self.PM = [[RightLable alloc] init];
    self.THDM = [[RightLable alloc] init];
    self.FHR = [[RightLable alloc] init];
    self.SHR = [[RightLable alloc] init];
    
    [self addSubview:self.YDH];
    [self addSubview:self.HB];
    [self addSubview:self.MDG];
    [self addSubview:self.DL];
    
    [self addSubview:self.JS];
    [self addSubview:self.ZL];
    [self addSubview:self.JFZL];
    [self addSubview:self.TJ];
    
    [self addSubview:self.PM];
    [self addSubview:self.THDM];
    [self addSubview:self.FHR];
    [self addSubview:self.SHR];
    
   

    [self addSubview:self.eleLable];
    
    [self.jifeizhiagianglable setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置挤压拉伸优先级
    [self.PM setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    self.PM.numberOfLines = 0;
    self.THDM.numberOfLines = 0;
    self.FHR.numberOfLines = 0;
    self.SHR.numberOfLines = 0;
    
    self.PM.lineBreakMode = NSLineBreakByWordWrapping;
    self.YDH.font = [UIFont boldSystemFontOfSize:21];
    self.YDH.textColor = [UIColor blackColor];
}


- (void)layoutWithMAxHeight:(CGFloat)maxHeight{

    [self.allnumberlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
    }];

    [self.hangbanlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.top.bottom.equalTo(self.allnumberlable);
    }];

    [self.HB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.lessThanOrEqualTo(self);
        make.left.equalTo(self.hangbanlable.mas_right).offset(20);
        make.top.bottom.equalTo(self.allnumberlable);
    }];

    [self.YDH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allnumberlable.mas_right).offset(20);
        make.bottom.top.equalTo(self.allnumberlable);
    }];

    [self.eleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.YDH.mas_right).offset(5);
        make.centerY.equalTo(self.allnumberlable);
        make.width.height.equalTo(@20);
        
    }];


    [self.mudiganglable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allnumberlable.mas_bottom).offset(20);
        make.left.equalTo(self.allnumberlable);
    }];



    [self.daililable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hangbanlable);
        make.top.bottom.equalTo(self.mudiganglable);
    }];

    [self.MDG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mudiganglable.mas_right).offset(20);
        make.bottom.top.equalTo(self.mudiganglable);
        make.right.equalTo(self.daililable.mas_left).offset(-5);
    }];
    
    [self.DL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.HB);
        make.right.lessThanOrEqualTo(self);
        make.bottom.top.equalTo(self.mudiganglable);
    }];
    
    [self.jianshulable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allnumberlable);
        make.top.equalTo(self.mudiganglable.mas_bottom).offset(20);
    }];
    
    [self.zhonglianglable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.daililable);
        make.top.bottom.equalTo(self.jianshulable);
    }];
    
    [self.JS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jianshulable.mas_right).offset(20);
        make.right.equalTo(self.zhonglianglable.mas_left).offset(-5);
        make.top.bottom.equalTo(self.jianshulable);

    }];
    
    [self.ZL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.HB);
        make.right.lessThanOrEqualTo(self);
        make.bottom.top.equalTo(self.jianshulable);
    }];
    
    [self.jifeizhiagianglable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allnumberlable);
        make.top.equalTo(self.jianshulable.mas_bottom).offset(20);
        make.width.equalTo(@[self.allnumberlable,self.mudiganglable,self.jianshulable]);
    }];
    
    [self.tijilable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hangbanlable);
        make.top.bottom.equalTo(self.jifeizhiagianglable);
    }];
    
    [self.JFZL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jifeizhiagianglable.mas_right).offset(20);
        make.right.equalTo(self.tijilable.mas_left).offset(-5);
        make.top.bottom.equalTo(self.jifeizhiagianglable);
    }];
    
    [self.TJ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.HB);
        make.right.lessThanOrEqualTo(self);
        make.bottom.top.equalTo(self.jifeizhiagianglable);
    }];

    [self.pinminglable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jifeizhiagianglable);
        make.top.bottom.equalTo(self.PM);
        make.right.equalTo(self.jifeizhiagianglable);
    }];

    [self.PM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jifeizhiagianglable.mas_bottom).offset(20);
        make.left.equalTo(self.pinminglable.mas_right).offset(20);
        make.right.equalTo(self.mas_right);
    }];
    
    [self.tehuodaimalable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.pinminglable);
        make.top.bottom.equalTo(self.THDM);
    }];
    
    [self.THDM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.PM.mas_bottom).offset(20);
        make.right.equalTo(self);
        make.left.equalTo(self.tehuodaimalable.mas_right).offset(20);
    }];
  
    [self.fahuorenlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.pinminglable);
        make.top.bottom.equalTo(self.FHR);
    }];
    
    [self.FHR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.THDM.mas_bottom).offset(20);
        make.right.equalTo(self);
        make.left.equalTo(self.fahuorenlable.mas_right).offset(20);
    }];
    
    [self.shouhuorenlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.pinminglable);
        make.top.bottom.equalTo(self.SHR);
    }];
    
    [self.SHR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.FHR.mas_bottom).offset(20);
        make.right.equalTo(self);
        make.left.equalTo(self.shouhuorenlable.mas_right).offset(20);
        make.bottom.lessThanOrEqualTo(self);

    }];
    
//    [self.allnumberlable mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.height.equalTo(@[self.jianshulable,self.mudiganglable,self.jifeizhiagianglable,self.FHR,self.THDM,self.SHR]);
//        make.height.equalTo(@(maxHeight));
//    }];
//

}


- (UILabel *)eleLable{
    if (!_eleLable) {
        _eleLable = [[UILabel alloc] init];
       _eleLable.backgroundColor = [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00];
        _eleLable.text = @"E";
        _eleLable.textAlignment = NSTextAlignmentCenter;
        _eleLable.font = [UIFont systemFontOfSize:15];
        _eleLable.layer.masksToBounds = YES;
        _eleLable.layer.cornerRadius = 10;
        _eleLable.textColor = [UIColor whiteColor];
    }
    return _eleLable;
}

@end

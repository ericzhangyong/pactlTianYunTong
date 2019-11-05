//
//  Mycell.m
//  MyTYT
//
//  Created by Fly on 2018/4/24.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "Mycell.h"
#import "FirstModel.h"
#import "SelectStateModel.h"
#import "NotifiModel.h"

@interface Mycell ()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewXuhao;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewDaiLi;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewCe;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewMudi;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewJianshu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewZs;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewTongguo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewDaiding;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewHWL;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewRoadLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewYuangongTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_viewTZ;


@property (weak, nonatomic) IBOutlet UIView *view_daiDing;
@property (weak, nonatomic) IBOutlet UIView *view_time;


@property (weak, nonatomic) IBOutlet UIView *view_orderNumKongIcon;
@property (weak, nonatomic) IBOutlet UILabel *label_orderKongIcon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth_ViewZongDanControl;

@property (weak, nonatomic) IBOutlet UILabel *label_firstKongIcon;


@end
@implementation Mycell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self baseSet];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    self.layoutWidth_viewXuhao.constant = 0.05*width;
    self.layoutWidth_viewDaiLi.constant = 0.055*width;
    self.layoutWidth_viewCe.constant = 0.18*width;
    self.layoutWidth_viewMudi.constant = 0.05*width;
    self.layoutWidth_viewJianshu.constant = 0.075*width;
    self.layoutWidth_viewZs.constant = 0.125*width;
    self.layoutWidth_viewTongguo.constant = 0.09*width;
//    self.layoutWidth_viewDaiding.constant = 0.09*width;
    self.layoutWidth_viewHWL.constant = 0.09*width;
//    self.layoutWidth_viewRoadLabel.constant= 0.05*width;
//    self.layoutWidth_viewYuangongTime.constant = 0.085*width;
    self.layoutWidth_viewTZ.constant = 0.06*width;
    
    self.view_daiDing.hidden = NO   ;
    self.view_time.hidden = NO;
    if (self.detectionType == DetectionType9610System ) {
        self.view_daiDing.hidden = YES   ;
        self.view_time.hidden = YES;
        self.layoutWidth_viewDaiding.constant = 0+15;
        self.layoutWidth_viewRoadLabel.constant = 0+15;
        self.layoutWidth_viewYuangongTime.constant = 0.135*width;
    }else{
        self.layoutWidth_viewDaiding.constant = 0.09*width;
        self.layoutWidth_viewRoadLabel.constant = 0.05*width;
        self.layoutWidth_viewYuangongTime.constant = 0.085*width;
    }
}

- (void)loaddtaWithModel:(FirstModel *)model row:(NSInteger)row{
    
    [self XUhaoWithRow:row];
    
    [self newWithRow:model];
    
    [self dailiWithModel:model];
    
    [self ceshiWithModel:model];
    
    [self EleWithModel:model];
    
    [self zongdanWithModel:model];
    
    [self mudigangWithModel:model];
    
    [self jianshuWithModel:model];
    
    [self zhengshuWithModel:model];
    
    [self tongguodaidingWithModel:model];
    
    [self typeWithModel:model];
    
    [self loadRoadWithModel:model];
    
    [self ygWithModel:model];
    
    [self timeWithModel:model];
    
    [self isLDCWithModel:model];
    
    [self notificationWithModel:model];
    
    [self BZWithModel:model];
    
    //控
    [self isControlWithModel:model];
}

-(void)setDetectionType:(DetectionType)detectionType{
    _detectionType = detectionType;
}
#pragma mark------------------------------------------------------------------------------------
//备注
- (void)BZWithModel:(FirstModel *)model{
    
    if ([model.count_remark integerValue] >0) {//有备注
        
        [self.ZSBtn setBackgroundColor:[UIColor colorWithRed:0.000 green:0.663 blue:0.902 alpha:1.00]];
        [self.ZSBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        
        [self.ZSBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
        [self.ZSBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
        
        
    }
}

//序号
- (void)XUhaoWithRow:(NSInteger)row{
    //序号
    self.xuhaoLable.text = [NSString stringWithFormat:@"%ld",row+1];
}

//新消息
- (void)newWithRow:(FirstModel *)mdoel{
    
    if ([mdoel.isnew isEqualToString:@"1"]) {//最新消息
        self.XImageView.hidden = NO;
    }else{
        self.XImageView.hidden = YES;
    }
}

//代理
- (void)dailiWithModel:(FirstModel *)model{
    //代理
    self.DaiLILable.text =  [model.agent_short_name isEqualToString:@""] ? model.daili : model.agent_short_name;
}


//电子
- (void)EleWithModel:(FirstModel *)mdoel{
    
    self.Eletritclable.hidden = NO;
    self.elecontant.constant = 20;
    self.EleRightConstant.constant = 5;
    
    if ([mdoel.isEle isEqualToString:@"1"]) {//是电子运单
        
    }else{//不是电子运单
        self.Eletritclable.hidden = YES;
        self.elecontant.constant = 0;
        self.EleRightConstant.constant = 0;
    }
}

//测试
- (void)ceshiWithModel:(FirstModel *)model{
    
    //设置默认值
    self.ceLable.hidden = NO;
    self.cecontant.constant = 25;
    self.JianJuConconstant.constant = 5;
    self.ceLable.backgroundColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00];
    self.ceLable.textColor = [UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00];
    self.ceLable.adjustsFontSizeToFitWidth = YES;
    self.ceLable.numberOfLines = 0;
    //测试
    if ([model.is_formal isEqualToString:@"1"]) {//不是测试
        
        if ([model.show_word isEqualToString:@""]) {//没返回字
            
            self.ceLable.hidden = YES;
            self.cecontant.constant = 0;
            self.JianJuConconstant.constant = 0;
            
        }else{//返回showword
            
            self.ceLable.backgroundColor = [UIColor redColor];
            self.ceLable.textColor = [UIColor whiteColor];
            self.ceLable.text = model.show_word;
        }
  
    }else{//是测试
        
        if ([model.testText isEqualToString:@""]) {//是测试逻辑，但没有测字
            self.ceLable.hidden = YES;
            self.cecontant.constant = 0;
            self.JianJuConconstant.constant = 0;
        }else{
            self.ceLable.text = model.testText;
        }
    }
}

//总单号
- (void)zongdanWithModel:(FirstModel *)model{
    //总单号
    [self.ZDBtn setTitle:model.ALLNUmber forState:UIControlStateNormal];
    
}

//目的港
- (void)mudigangWithModel:(FirstModel *)model{
    //目的港
    self.MudiLable.text = model.MUdigang;
}

//件数
- (void)jianshuWithModel:(FirstModel *)model{
    //件数/重量
    self.jianshuLable.text = [[NSString alloc] initWithFormat:@"%@/%@",model.jianshu,model.zhongliang];
    
}

//证书
- (void)zhengshuWithModel:(FirstModel *)model{
    //证书
    if ([model.booksCount isEqualToString:@"0"]) {
        
        [self.DisPlayZBBtn setImage:[UIImage imageNamed:@"pdf"] forState:UIControlStateNormal];
        self.DisPlayZBBtn.userInteractionEnabled = NO;
        
        
    }else{
        [self.DisPlayZBBtn setImage:[UIImage imageNamed:@"pdf2"] forState:UIControlStateNormal];
        self.DisPlayZBBtn.userInteractionEnabled = YES;
    }
}

#pragma mark------------------------------------------------------------------------------------
//通过待定
- (void)tongguodaidingWithModel:(FirstModel *)model{
    
    //设置默认隐藏
    self.daidingVIew.hidden = YES;
    self.TongguoVIew.hidden = YES;
    
    //通过
    if ([model.THOrDD isEqualToString:@"0"]) {//待定
        
        [self setWaitBtnSate];
        
    }else if ([model.THOrDD isEqualToString:@"1"]){//通过
        
        [self setagreeBtnSate];
        
    }else if ([model.THOrDD isEqualToString:@""]){//开始显示本地数据
        
        SelectStateModel *locaModel = model.LocalstateModel;//本地模型
        
        if ([locaModel.state isEqualToString:@""]) {//没有选择
            
            [self setNoSelectState];
            
        }else if ([locaModel.state isEqualToString:@"1"]){//通过
            
            [self setagreeBtnSate];
            
            if (locaModel.operationcount > 0) {
                self.TongguoVIew.hidden = NO;
                self.tongguocountLable.text = [[NSString alloc] initWithFormat:@"%ld",(long)locaModel.operationcount];
            }
            
            
        }else if ([locaModel.state isEqualToString:@"0"]){//待定
            [self setWaitBtnSate];
            
            if (locaModel.operationcount > 0) {
                self.daidingVIew.hidden = NO;
                self.daiDingOCuntLable.text = [[NSString alloc] initWithFormat:@"%ld",(long)locaModel.operationcount];
            }
            
        }
        
    }
}

//设置待定
- (void)setWaitBtnSate{
    
    [self.daiDingBtn setBackgroundColor:[UIColor colorWithRed:1.000 green:0.412 blue:0.706 alpha:1.00]];
    [self.daiDingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.tongguoBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
    [self.tongguoBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
}

//设置通过
- (void)setagreeBtnSate{
    
    [self.tongguoBtn setBackgroundColor:[UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00]];
    [self.tongguoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.daiDingBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
    [self.daiDingBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
}

//设置没有任何选择
- (void)setNoSelectState{
    
    [self.daiDingBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
    [self.daiDingBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
    
    [self.tongguoBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
    [self.tongguoBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
}

#pragma mark------------------------------------------------------------------------------------

//货物类别
- (void)typeWithModel:(FirstModel *)model{
    //货物类别
    
    if ([model.type isEqualToString:@"0"]) {//普获
        
        [self.HWLBBtn setBackgroundColor:[UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00]];
        [self.HWLBBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.HWLBBtn setTitle:@"普货" forState:UIControlStateNormal];
        
    }else if ([model.type isEqualToString:@"1"]){//危险品
        [self.HWLBBtn setTitle:@"危险品" forState:UIControlStateNormal];
        
        [self.HWLBBtn setBackgroundColor:[UIColor colorWithRed:1.000 green:0.239 blue:0.000 alpha:1.00]];
        [self.HWLBBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else if ([model.type isEqualToString:@"2"]){//24小时
        [self.HWLBBtn setTitle:@"24小时" forState:UIControlStateNormal];
        
        [self.HWLBBtn setBackgroundColor:[UIColor colorWithRed:0.204 green:0.773 blue:0.792 alpha:1.00]];
        [self.HWLBBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    
}

/*?控??**/

- (void)isControlWithModel:(FirstModel *)mdoel{
    
    self.view_orderNumKongIcon.hidden = YES;
    if (self.detectionType == DetectionType9610System) {
        if (![BaseVerifyUtils isNullOrSpaceStr:mdoel.securityCheckResult]) {
            self.view_orderNumKongIcon.hidden = NO;
            self.view_orderNumKongIcon.backgroundColor = [UIColor colorWithHexString:mdoel.securityCheckResultColor];
        }
    }else{
        if (mdoel.iscontrol == YES || mdoel.isABControl == YES) {
            self.label_firstKongIcon.hidden = NO;
        }else{
            self.label_firstKongIcon.hidden = YES;
        }
    }
    
}
/*????*/
//锂电池
- (void)isLDCWithModel:(FirstModel *)model{
    
    if ( model.elm_flag != nil && model.eli_flag !=nil && (([model.elm_flag integerValue] || [model.eli_flag integerValue]) == 1)) {
        
        self.huowuleibieVIew.hidden = NO;
        
    }else{
        self.huowuleibieVIew.hidden = YES;
    }
    
}

//24小时通道
- (void)loadRoadWithModel:(FirstModel *)model{
    
    self.roadlable.text = model.aisle24;

}

//首检员工
- (void)ygWithModel:(FirstModel *)model{
    //员工首检
    self.YGNumberLable.text = model.TextYG;
    
}

//操作时间
- (void)timeWithModel:(FirstModel *)model{
    //时间
    self.timeLable.text = model.time;
}

//通知
- (void)notificationWithModel:(FirstModel *)model{
    //通知
    if ([model.count_notice isEqualToString:@"0"]) {//没有通知隐藏
        
        self.TZBtn.hidden = YES;
        self.TZVIew.hidden = YES;
        
        
    }else{//有通知
        
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NotifiModel *notifimodel in model.noticeArray) {
            
            if ([notifimodel.status isEqualToString:@"0"]) {
                [array addObject:notifimodel];
            }
        }
        
        if (array.count != 0) {//没有全部都读
            
            self.TZBtn.hidden = NO;
            self.TZVIew.hidden = NO;
            self.TZcountLable.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [self.TZBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
            
            
        }else{
            self.TZVIew.hidden = YES;
            self.TZBtn.hidden = NO;
            
            [self.TZBtn setImage:[UIImage imageNamed:@"haveread"] forState:UIControlStateNormal];
        }
        
        
    }
}



- (void)baseSet{
    
    //代理
    self.DaiLILable.adjustsFontSizeToFitWidth = YES;
    
    //新
    self.XImageView.hidden = YES;
    
    //测
    self.ceLable.layer.cornerRadius = 5;
    self.ceLable.layer.masksToBounds = YES;
    
    //E
    self.Eletritclable.layer.masksToBounds = YES;
    self.Eletritclable.layer.cornerRadius = 10;
    self.Eletritclable.backgroundColor = [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00];
    
    //总单
    self.ZDBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    //通过
    self.TongguoVIew.layer.masksToBounds = YES;
    self.TongguoVIew.layer.cornerRadius = 14;
    
    //待定
    self.daidingVIew.layer.masksToBounds = YES;
    self.daidingVIew.layer.cornerRadius = 14;
    
    //锂电池
    self.huowuleibieVIew.layer.masksToBounds = YES;
    self.huowuleibieVIew.layer.cornerRadius = 14;
    
    //控
//    self.view_orderNumKongIcon.layer.masksToBounds = YES;
//    self.view_orderNumKongIcon.layer.cornerRadius = 14;
    
    //24小时
    self.roadlable.adjustsFontSizeToFitWidth = YES;
    
    //操作时间
    self.timeLable.adjustsFontSizeToFitWidth = YES;
    
    //货物类型
    self.HWLBBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    //通知
    self.TZVIew.layer.cornerRadius = 10;
    self.TZVIew.layer.masksToBounds = YES;
    self.TZVIew.userInteractionEnabled = NO;
    
    //序号
    self.xuhaoLable.adjustsFontSizeToFitWidth = YES;
}



@end

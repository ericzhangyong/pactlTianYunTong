//
//  TwentyCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "TwentyCell.h"
#import "TwentyModel.h"
#import "SelectStateModel.h"
#import "RoadModel.h"
#import "TwentyMachineModel.h"
#import "TwentyLocalInfoModel.h"
#import "UIColor+ColorString.h"

@implementation TwentyCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self baseSet];
    
    

}

- (void)loaddataWithModel:(TwentyModel *)model row:(NSInteger)row{
    
    //序号
    [self XUhaoWithRow:row];
    
    //新消息
    [self newWithRow:model];
    
    //代理
    [self dailiWithModel:model];
    
    //测试
    [self ceshiWithModel:model];
    
    //电子运单
    [self EleWithModel:model];
    
    //总单号
    [self zongdanWithModel:model];
    
    //目的港
    [self mudigangWithModel:model];
    
    //件数
    [self jianshuWithModel:model];
    
    //证书
    [self zhengshuWithModel:model];
    
    //通过
    [self tongguodaidingWithModel:model];
    
    //货物类别
    [self typeWithModel:model];
    
    //控
    [self controlEventWith:model];
    
    //锂电池
    [self isLDCWithModel:model];
    
    //24小时通道
    [self loadRoadWithModel:model];
    
    //通道货物数量
    [self RoadCountWithModel:model];
    
    //24小时待过安检机
    [self twentyCountWithModel:model];
    
    //安检机
    [self AJMAchineWithModel:model];

    //备注
    [self bzWithModel:model];
    
}

#pragma mark------------------------------------------------------------------------------------

//备注
- (void)bzWithModel:(TwentyModel *)model{
    
    if ([model.count_remark integerValue] >0) {//有备注
        
        [self.BZBtn setBackgroundColor:[UIColor colorWithRed:0.000 green:0.663 blue:0.902 alpha:1.00]];
        [self.BZBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        
        [self.BZBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
        [self.BZBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
        
    }
}

//序号
- (void)XUhaoWithRow:(NSInteger)row{
    //序号
    self.XHLable.text = [NSString stringWithFormat:@"%ld",row+1];
}

//新消息
- (void)newWithRow:(TwentyModel *)mdoel{
    
    if ([mdoel.isnew isEqualToString:@"1"]) {//最新消息
        self.NewImageView.hidden = NO;
    }else{
        self.NewImageView.hidden = YES;
    }
}

//代理
- (void)dailiWithModel:(TwentyModel *)model{
    //代理
    self.DLLable.text = [model.agent_short_name isEqualToString:@""] ? model.agent_oprn : model.agent_short_name;
    
}


//电子
- (void)EleWithModel:(TwentyModel *)mdoel{
    
    self.EleLable.hidden = NO;
    self.EleContant.constant = 20;
    self.EleDistanceConstant.constant = 10;
    
    if ([mdoel.wb_ele isEqualToString:@"1"]) {//是电子运单
        
    }else{//不是电子运单
        self.EleLable.hidden = YES;
        self.EleContant.constant = 0;
        self.EleDistanceConstant.constant = 0;
    }
}

//测试
- (void)ceshiWithModel:(TwentyModel *)model{
    
    //设置默认值
    self.mytextlable.hidden = NO;
    self.textlableConstant.constant = 25;
    self.JJConstant.constant = 5;
    self.mytextlable.backgroundColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00];
    self.mytextlable.textColor = [UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00];
    self.mytextlable.adjustsFontSizeToFitWidth = YES;
    self.mytextlable.numberOfLines = 0;
    //测试
    if ([model.is_formal isEqualToString:@"1"]) {//不是测试
        
        if ([model.show_word isEqualToString:@""]) {//没返回字
            
            self.mytextlable.hidden = YES;
            self.textlableConstant.constant = 0;
            self.JJConstant.constant = 0;
            
        }else{//返回showword
            
            self.mytextlable.backgroundColor = [UIColor redColor];
            self.mytextlable.textColor = [UIColor whiteColor];
            self.mytextlable.text = model.show_word;
            
        }
        
    }else{//是测试
        
        if ([model.testWord isEqualToString:@""]) {//是测试逻辑，但没有测字
            self.mytextlable.hidden = YES;
            self.textlableConstant.constant = 0;
            self.JJConstant.constant = 0;
        }else{
            self.mytextlable.text = model.testWord;
        }
    }
}

//总单号
- (void)zongdanWithModel:(TwentyModel *)model{
    //总单号
    [self.YDHBTn setTitle:model.waybill_no forState:UIControlStateNormal];
    
}

//目的港
- (void)mudigangWithModel:(TwentyModel *)model{
    //目的港
    self.MDGLable.text = model.dest1;
}

//件数
- (void)jianshuWithModel:(TwentyModel *)model{
    //件数/重量
    self.JSZLLable.text = [[NSString alloc] initWithFormat:@"%@/%@",model.total_count.stringValue,model.gross_weight.stringValue];
    
}

//证书
- (void)zhengshuWithModel:(TwentyModel *)model{
    //证书
    if ([model.count_books isEqualToString:@"0"]) {
        
        [self.ZSBtn setImage:[UIImage imageNamed:@"pdf"] forState:UIControlStateNormal];
        self.ZSBtn.userInteractionEnabled = NO;
        
        
    }else{
        [self.ZSBtn setImage:[UIImage imageNamed:@"pdf2"] forState:UIControlStateNormal];
        self.ZSBtn.userInteractionEnabled = YES;
    }
    
}

#pragma mark------------------------------------------------------------------------------------
//通过待定
- (void)tongguodaidingWithModel:(TwentyModel *)model{
    
    //设置默认隐藏
    self.AgreecountView.hidden = YES;
    self.WaitCountView.hidden = YES;
    
    //通过
    if ([model.fstatus isEqualToString:@"0"]) {//待定
        
        [self setWaitBtnSate];
        
    }else if ([model.fstatus isEqualToString:@"1"]){//通过
        
        [self setagreeBtnSate];
        
    }else if ([model.fstatus isEqualToString:@""]){//开始显示本地数据
        
        SelectStateModel *locaModel = model.LocalstateModel;//本地模型
        
        if ([locaModel.state isEqualToString:@""]) {//没有选择
            
            [self setNoSelectState];
            
        }else if ([locaModel.state isEqualToString:@"1"]){//通过
            
            [self setagreeBtnSate];
            
            if (locaModel.operationcount > 0) {
                self.AgreecountView.hidden = NO;
                self.agreeCoutLable.text = [[NSString alloc] initWithFormat:@"%ld",(long)locaModel.operationcount];
            }
            
            
        }else if ([locaModel.state isEqualToString:@"0"]){//待定
            [self setWaitBtnSate];
            
            if (locaModel.operationcount > 0) {
                self.WaitCountView.hidden = NO;
                self.WaitCountLable.text = [[NSString alloc] initWithFormat:@"%ld",(long)locaModel.operationcount];
            }
            
        }
        
    }
}

//设置待定
- (void)setWaitBtnSate{
    
    [self.WaitBtn setBackgroundColor:[UIColor colorWithRed:1.000 green:0.412 blue:0.706 alpha:1.00]];
    [self.WaitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.AgreeBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
    [self.AgreeBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
}

//设置通过
- (void)setagreeBtnSate{
    
    [self.AgreeBtn setBackgroundColor:[UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00]];
    [self.AgreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.WaitBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
    [self.WaitBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
}

//设置没有任何选择
- (void)setNoSelectState{
    
    [self.WaitBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
    [self.WaitBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
    
    [self.AgreeBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
    [self.AgreeBtn setTitleColor:[UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00] forState:UIControlStateNormal];
}

#pragma mark------------------------------------------------------------------------------------

//货物类别
- (void)typeWithModel:(TwentyModel *)model{
    //货物类别
    
    if ([model.goods_class isEqualToString:@"0"]) {//普获
        
        [self.typebackView setBackgroundColor:[UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00]];
        
        self.typelable.text = @"普货";
        
    }else if ([model.goods_class isEqualToString:@"1"]){//危险品
        
        [self.typebackView setBackgroundColor:[UIColor colorWithRed:1.000 green:0.239 blue:0.000 alpha:1.00]];
        self.typelable.text = @"危险品";

        
    }else if ([model.goods_class isEqualToString:@"2"]){//24小时
        
        self.typelable.text = @"24小时";
        [self.typebackView setBackgroundColor:[UIColor colorWithRed:0.204 green:0.773 blue:0.792 alpha:1.00]];
        
    }
    
    
}

//控
- (void)controlEventWith:(TwentyModel *)model{
    
    if (model.iscontrol == YES || model.isABControl == YES) {
        self.controlView.hidden = NO;
    }else{
        self.controlView.hidden = YES;
    }
}
//锂电池
- (void)isLDCWithModel:(TwentyModel *)model{
    
    if ( model.elm_flag != nil && model.eli_flag !=nil && (([model.elm_flag integerValue] || [model.eli_flag integerValue]) == 1)) {
        
        self.TypeView.hidden = NO;
        
    }else{
        self.TypeView.hidden = YES;
    }
    
}

//24小时通道
- (void)loadRoadWithModel:(TwentyModel *)model{
    
    [self.RoadBtn setTitle:model.infoModel.roadModel.name forState:UIControlStateNormal];
    
    
    if ([model.infoModel.aislecount isEqualToString:@""]) {//默认为空
        
        [self.RoadBtn setBackgroundColor:[UIColor colorWithHexString:@"#00B32C"]];

    }else{
        
        if ([model.infoModel.aislecount integerValue] <=0) {
            
            [self.RoadBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];
            
        }else{
            [self.RoadBtn setBackgroundColor:[UIColor colorWithHexString:@"#00B32C"]];
        }
        
    }
    
   
}

//通道货物数量
- (void)RoadCountWithModel:(TwentyModel *)model{
    
    self.RoadTextfiled.text = model.infoModel.aislecount;
}

//24小时待过安检机
- (void)twentyCountWithModel:(TwentyModel *)model{
    self.AJJTextFiled.text = model.infoModel.machine24;
}

//安检机
- (void)AJMAchineWithModel:(TwentyModel *)model{
    
    [self.AJJBtn setTitle:model.infoModel.machineModel.name forState:UIControlStateNormal];
    
    if ([model.infoModel.machine24 integerValue] <=0) {
        
        [self.AJJBtn setBackgroundColor:[UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00]];

    }else{
        [self.AJJBtn setBackgroundColor:[UIColor colorWithHexString:@"#00B32C"]];
    }
}

- (void)baseSet{
    
    //不能输入
    self.AJJTextFiled.enabled = NO;
    self.RoadTextfiled.enabled = NO;
    
    //代理换行宽度
    self.DLLable.preferredMaxLayoutWidth = kuan *0.05;
    //代理
    self.DLLable.adjustsFontSizeToFitWidth = YES;
    //件数重量
    self.JSZLLable.adjustsFontSizeToFitWidth = YES;
    
    //货物类别
    self.typelable.adjustsFontSizeToFitWidth = YES;
    
    //新
    self.NewImageView.hidden = YES;
    
    //测
    self.mytextlable.layer.cornerRadius = 5;
    self.mytextlable.layer.masksToBounds = YES;
    
    //E
    self.EleLable.layer.masksToBounds = YES;
    self.EleLable.layer.cornerRadius = 10;
    self.EleLable.backgroundColor = [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00];

    //总单
    self.YDHBTn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    //通过
    self.AgreecountView.layer.masksToBounds = YES;
    self.AgreecountView.layer.cornerRadius = 14;
    
    //待定
    self.WaitCountView.layer.masksToBounds = YES;
    self.WaitCountView.layer.cornerRadius = 14;
    
    //控
    self.controlView.layer.masksToBounds = YES;
    self.controlView.layer.cornerRadius = 14;
    
    //锂电池
    self.TypeView.layer.masksToBounds = YES;
    self.TypeView.layer.cornerRadius = 14;
    
    //序号
    self.XHLable.adjustsFontSizeToFitWidth = YES;
}

@end

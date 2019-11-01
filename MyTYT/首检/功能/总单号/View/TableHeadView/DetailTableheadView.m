//
//  DetailTableheadView.m
//  MyTYT
//
//  Created by Fly on 2018/5/18.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DetailTableheadView.h"
#import "Masonry.h"
#import "DeatilTstModel.h"
#import "GPModel.h"
#import "infoModel.h"
#import "CheckModel.h"
#import "UIColor+ColorString.h"

@implementation DetailTableheadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.danhaoLable];
        [self addSubview:self.TestLable];
        [self addSubview:self.YDHLable];
        [self addSubview:self.EleLable];
        [self addSubview:self.GPLable];
        [self addSubview:self.DaiLIlable];
        [self addSubview:self.AgentLable];
        [self addSubview:self.TypeLable];
        [self addSubview:self.controlLable];
        [self addSubview:self.ABcontrolLable];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setDataWithInfoModel:(infoModel *)indomodel testModel:(DeatilTstModel *)testModel gpModel:(GPModel *)gpModel testWord:(NSString *)testWord checkModel:(CheckModel *)checkModel AgentShortName:(NSString *)agentShorName iscontrol:(BOOL)iscontrol isABControl:(BOOL)isABcontrol{
    
    //测字
    if ([testModel.isFormal isEqualToString:@"1"]) {//正式
        
        if ([testModel.showWord isEqualToString:@""]) {//没返回字
            
            [_TestLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.danhaoLable.mas_right).offset(10);
                make.height.equalTo(@40);
                make.width.equalTo(@0);
                make.centerY.equalTo(self);
            }];
            
            [_YDHLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.TestLable.mas_right).offset(0);
                make.centerY.equalTo(self);
            }];
            
        }else{
            self.TestLable.text = testModel.showWord;
            self.TestLable.backgroundColor = [UIColor redColor];
            self.TestLable.textColor = [UIColor whiteColor];
            
            [_TestLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.danhaoLable.mas_right).offset(10);
                make.height.equalTo(@40);
                make.width.greaterThanOrEqualTo(@25);
                make.centerY.equalTo(self);
            }];
            
            [_YDHLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.TestLable.mas_right).offset(5);
                make.centerY.equalTo(self);
            }];
        }
      
    }else{
        
        if ([testWord isEqualToString:@""]) {//测字为空不显示
            
            [_TestLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.danhaoLable.mas_right).offset(10);
                make.height.equalTo(@40);
                make.width.equalTo(@0);
                make.centerY.equalTo(self);
            }];
            
            [_YDHLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.TestLable.mas_right).offset(0);
                make.centerY.equalTo(self);
            }];
            
        }else{
            self.TestLable.text = testWord;
            self.TestLable.backgroundColor = [UIColor colorWithRed:0.839 green:0.839 blue:0.839 alpha:1.00];
            self.TestLable.textColor = [UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00];
            
            
            [_TestLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.danhaoLable.mas_right).offset(10);
                make.height.equalTo(@40);
                make.width.greaterThanOrEqualTo(@25);
                make.centerY.equalTo(self);
            }];
            
            [_YDHLable mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.TestLable.mas_right).offset(5);
                make.centerY.equalTo(self);
            }];
        }
        
    }

    
    //电子运单
    if ([indomodel.wbEle isEqualToString:@"1"]) {

        [self.EleLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@20);
            make.left.equalTo(self.YDHLable.mas_right).offset(5);
        }];
    
        
    }else{
        
        [self.EleLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@0);
            make.left.equalTo(self.YDHLable.mas_right).offset(0);


        }];
    }
    
    //货物类型
    if ([checkModel.goods_class isEqualToString:@"0"]) {
        
        self.TypeLable.backgroundColor = [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00];
        self.TypeLable.text = @"普通货物";
        self.TypeLable.font = [UIFont systemFontOfSize:20];
       
    }else if ([checkModel.goods_class isEqualToString:@"1"]){
        
        self.TypeLable.backgroundColor =[UIColor colorWithRed:1.000 green:0.239 blue:0.000 alpha:1.00];
        self.TypeLable.text = @"危险品";
        self.TypeLable.font = [UIFont systemFontOfSize:20];
       

    }else if ([checkModel.goods_class isEqualToString:@"2"]){
        
        self.TypeLable.backgroundColor = [UIColor colorWithRed:0.204 green:0.773 blue:0.792 alpha:1.00];
        self.TypeLable.text = @"24小时货物";
        self.TypeLable.font = [UIFont systemFontOfSize:17];

    }else{
        self.TypeLable.text = @"";
    }
    
    
    //安检布控
    if (iscontrol == YES) {
        [self.controlLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.TypeLable.mas_right).offset(8);
            make.width.equalTo(@100);
        }];
    }else{
        [self.controlLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.TypeLable.mas_right).offset(0);
            make.width.equalTo(@0);
        }];
    }
    
    //安保布控
    if (isABcontrol == YES) {
        [self.ABcontrolLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.controlLable.mas_right).offset(8);
            make.width.equalTo(@100);
        }];
    }else{
        [self.ABcontrolLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.controlLable.mas_right).offset(0);
            make.width.equalTo(@0);
        }];
    }
    
    [self setNeedsUpdateConstraints];
    
    [self setNeedsLayout];
    
    
   //改配
    if (gpModel.isgp == YES) {
        self.GPLable.hidden = NO;
    }else{
        self.GPLable.hidden = YES;
    }
        
    //运单号
    NSMutableString *str = [NSMutableString stringWithString: indomodel.waybillNo];
    [str insertString:@"-" atIndex:3];
    self.YDHLable.text = str;
    
    //代理
    self.AgentLable.text = [agentShorName isEqualToString:@""] ? indomodel.agentOprn : agentShorName;
    
    

}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self layout];

}

- (void)layout{
    
    [_danhaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.width.equalTo(@0);
    }];
    
    [_TestLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.danhaoLable.mas_right).offset(10);
        make.height.equalTo(@40);
        make.centerY.equalTo(self);
    }];
    
    [_YDHLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.TestLable.mas_right).offset(0);
        make.centerY.equalTo(self);
    }];
    
    [_AgentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
    }];
    
    [_DaiLIlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.AgentLable.mas_left).offset(-5);
        make.centerY.equalTo(self);
    }];
    
    [_EleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.YDHLable.mas_right).offset(0);
        make.centerY.equalTo(self);
        make.height.width.greaterThanOrEqualTo(@0);
        make.height.width.lessThanOrEqualTo(@20);
    }];
    
    [_TypeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.EleLable.mas_right).offset(8);
        make.centerY.equalTo(self);
        make.height.equalTo(@35);
        make.width.greaterThanOrEqualTo(@100);
    }];
    
    [_controlLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.lessThanOrEqualTo(self.TypeLable.mas_right).offset(8);
        make.centerY.equalTo(self);
        make.height.equalTo(@35);
        make.width.lessThanOrEqualTo(@100);
    }];
    
    [_ABcontrolLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.lessThanOrEqualTo(self.controlLable.mas_right).offset(8);
        make.centerY.equalTo(self);
        make.height.equalTo(@35);
        make.width.lessThanOrEqualTo(@100);
    }];
    
    [_GPLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ABcontrolLable.mas_right).offset(8);
        make.centerY.equalTo(self);
        make.height.equalTo(@35);
        make.width.equalTo(@50);
    }];
    
}

- (UILabel *)danhaoLable{
    if (!_danhaoLable) {
        _danhaoLable = [[UILabel alloc] init];
        _danhaoLable.text = @"运单号:";
        _danhaoLable.font =[ UIFont systemFontOfSize:35];
        _danhaoLable.textAlignment = NSTextAlignmentRight;
    }
    return _danhaoLable;
}

- (UILabel *)TestLable{
    if (!_TestLable) {
        _TestLable = [[UILabel alloc] init];
        _TestLable.layer.masksToBounds = YES;
        _TestLable.layer.cornerRadius = 5;
        _TestLable.textAlignment = NSTextAlignmentCenter;
    }
    return _TestLable;
}

- (UILabel *)YDHLable{
    if (!_YDHLable) {
        _YDHLable = [[UILabel alloc] init];
        _YDHLable.textColor = BtnColor;
        _YDHLable.font = [UIFont boldSystemFontOfSize:35];
    }
    return _YDHLable;
}

- (UILabel *)EleLable{
    if (!_EleLable) {
        _EleLable = [[UILabel alloc] init];
        _EleLable.layer.masksToBounds = YES;
        _EleLable.layer.cornerRadius = 10;
        _EleLable.backgroundColor =  [UIColor colorWithRed:0.596 green:0.796 blue:0.157 alpha:1.00];
        _EleLable.textColor = [UIColor whiteColor];
        _EleLable.font = [UIFont systemFontOfSize:15];
        _EleLable.text = @"E";
        _EleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _EleLable;
}

- (UILabel *)GPLable{
    if (!_GPLable) {
        _GPLable = [[UILabel alloc] init];
        _GPLable.text = @"改配";
        _GPLable.backgroundColor = [UIColor redColor];
        _GPLable.textColor = [UIColor whiteColor];
        _GPLable.font = [UIFont boldSystemFontOfSize:20];
        _GPLable.layer.masksToBounds = YES;
        _GPLable.layer.cornerRadius = 5;
        _GPLable.textAlignment = NSTextAlignmentCenter;
        
    }
    return _GPLable;
}

- (UILabel *)DaiLIlable{
    if (!_DaiLIlable) {
        _DaiLIlable = [[UILabel alloc] init];
        _DaiLIlable.text = @"操作代理:";
        _DaiLIlable.font = [UIFont systemFontOfSize:25];
    }
    return _DaiLIlable;
}

- (UILabel *)AgentLable{
    if (!_AgentLable) {
        _AgentLable = [[UILabel alloc] init];
        _AgentLable.textColor = BtnColor;
        _AgentLable.font = [UIFont boldSystemFontOfSize:25];

    }
    return _AgentLable;
}

- (UILabel *)TypeLable{
    if (!_TypeLable) {
        _TypeLable = [[UILabel alloc] init];
        _TypeLable.font = [UIFont systemFontOfSize:20];
        _TypeLable.layer.masksToBounds = YES;
        _TypeLable.layer.cornerRadius = 5;
        _TypeLable.textColor = [UIColor whiteColor];
        _TypeLable.textAlignment = NSTextAlignmentCenter;
        _TypeLable.adjustsFontSizeToFitWidth = YES;
    }
    
    return _TypeLable;
}

- (UILabel *)controlLable{
    if (!_controlLable) {
        _controlLable = [[UILabel alloc] init];
        _controlLable.font = [UIFont systemFontOfSize:20];
        _controlLable.layer.masksToBounds = YES;
        _controlLable.layer.cornerRadius = 5;
        _controlLable.textColor = [UIColor whiteColor];
        _controlLable.textAlignment = NSTextAlignmentCenter;
        _controlLable.adjustsFontSizeToFitWidth = YES;
        _controlLable.backgroundColor =[UIColor colorWithHexString:@"#005493"];
        _controlLable.text = @"安检布控";

    }
    return _controlLable;
}


- (UILabel *)ABcontrolLable{
    if (!_ABcontrolLable) {
        _ABcontrolLable = [[UILabel alloc] init];
        _ABcontrolLable.font = [UIFont systemFontOfSize:20];
        _ABcontrolLable.layer.masksToBounds = YES;
        _ABcontrolLable.layer.cornerRadius = 5;
        _ABcontrolLable.textColor = [UIColor whiteColor];
        _ABcontrolLable.textAlignment = NSTextAlignmentCenter;
        _ABcontrolLable.adjustsFontSizeToFitWidth = YES;
        _ABcontrolLable.backgroundColor =[UIColor colorWithHexString:@"#005493"];
        _ABcontrolLable.text = @"安保布控";
        
    }
    return _ABcontrolLable;
}

@end

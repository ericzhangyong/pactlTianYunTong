//
//  RightView.m
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "RightView.h"
#import "InfoView.h"
#import "Masonry.h"
#import "UIView+BaseCategory.h"
#import "OperationMachinModel.h"
#import "CheckBottomView.h"

@interface RightView ()

@property (nonatomic,strong) CheckBottomView *view_bottom;


@property (nonatomic,assign) ScanVCType vcType;
@end
@implementation RightView

-(instancetype)initWithFrame:(CGRect)frame vcType:(ScanVCType)vcType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.vcType = vcType;
        [self creatUI];
        
        [self layout];
    }
    return self;
}

- (void)creatUI{
    
    [self addSubview:self.ScanBtn];
    [self addSubview:self.titlelable];
    if (self.vcType == ScanVCTypeScan) {
        [self addSubview:self.infoView];
    }else{
        [self addSubview:self.view_checkInfo];
    }
    [self addSubview:self.view_beizhu];
    [self.view_beizhu addSubview:self.view_bottom];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self layout];
}

-(void)configData{
    
//    addvc.block = ^{
//
//        [self requestData];
//    };
//    OperationMachinModel *model = [OperationMachinModel new ];
//    model.ctName =@"大家来卡解放了";
//    model.machineName = @"测试机器";
//    self.beizhuVC.opeartionModel = model;
//
//    self.beizhuVC.MachID = @"4";
//
//    self.beizhuVC.aWID = @"c657ee88a2604f76b4b168930ec54545";
//
//    self.beizhuVC.YDH = @"SLE00100306";
}

- (void)layout{
    
    [_titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(30);
        make.height.height.equalTo(@40);
    }];
    
    [_ScanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(@35);
        make.width.equalTo(@100);
        make.centerY.equalTo(self.titlelable);
    }];

    self.view_beizhu.hidden = YES;
    if (self.vcType == ScanVCTypeCheck) {
        self.view_beizhu.hidden = NO;
        [self.view_beizhu mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.bottom.equalTo(self).offset(-20);
            make.height.mas_equalTo(60);
           }];
        [self.view_bottom mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view_beizhu);
            make.height.mas_equalTo(50);
        }];
    }
    if (self.vcType == ScanVCTypeCheck) {
        [self.view_checkInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-20);
            make.top.equalTo(self.ScanBtn.mas_bottom).offset(25);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }];
    }else{
        [self.infoView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-20-60);
            make.top.equalTo(self.ScanBtn.mas_bottom).offset(25);
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
        }];
    }
}


- (UIButton *)ScanBtn{
    if (!_ScanBtn) {
        _ScanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ScanBtn setTitle:@"扫描" forState:UIControlStateNormal];
        _ScanBtn.layer.cornerRadius = 17.5;
        _ScanBtn.layer.masksToBounds = YES;
        _ScanBtn.backgroundColor = NavColor;
        [_ScanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_ScanBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_ScanBtn setImage:[UIImage imageNamed:@"san"] forState:UIControlStateNormal];
        [_ScanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    return _ScanBtn;
}

- (UILabel *)titlelable{
    if (!_titlelable) {
        _titlelable =[[UILabel alloc] init];
        _titlelable.text = @"运单信息";
        _titlelable.font = [UIFont boldSystemFontOfSize:25];
        _titlelable.textColor = [UIColor blackColor];
    }
    return _titlelable;
}

- (InfoView *)infoView{
    if (!_infoView) {
        _infoView = [[InfoView alloc] init];
        _infoView.backgroundColor = [UIColor whiteColor];
//        _infoView.hidden = YES;
    }
    return _infoView;
}

#pragma mark- lazy

-(CheckBottomView *)view_bottom{
    if (!_view_bottom) {
        _view_bottom = [[CheckBottomView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    }
    return _view_bottom;
}

-(CheckInfoView *)view_checkInfo{
    if (!_view_checkInfo) {
        _view_checkInfo = [[CheckInfoView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height*0.5)];
        _view_checkInfo.backgroundColor = [UIColor whiteColor];
        _view_checkInfo.zhengShuClick = ^(BOOL isClick) {
            
        };
    }
    return _view_checkInfo;
}

//-(AddBZVC *)beizhuVC{
//    if (!_beizhuVC) {
//        OperationMachinModel *model = [OperationMachinModel new ];
//        model.ctName =@"大家来卡解放了";
//        model.machineName = @"测试机器";
//        _beizhuVC = [[AddBZVC alloc] initWithOpeartionModel:model aWID:@"c657ee88a2604f76b4b168930ec54545" MachID:@"4" YDH:@"SLE00100306" DetectionType:DetectionType9610System];
//        _beizhuVC.view.frame = CGRectMake(0, 0, self.bounds.size.width*0.5, self.bounds.size.width*0.5);
//
//    }
//    return _beizhuVC;
//}

-(UIView *)view_beizhu{
    if (!_view_beizhu) {
        _view_beizhu = [UIView new];
//        _view_beizhu.layer.masksToBounds = YES;
//        _view_beizhu.layer.cornerRadius = 5;
//        _view_beizhu.layer.borderColor = [UIColor colorWithRed:0.369 green:0.369 blue:0.369 alpha:1.00].CGColor;
//        _view_beizhu.layer.borderWidth = 1;
    }
    return _view_beizhu;
}
          
////进入备注页面
//- (void)IntoBZEventWithaWID:(NSString *)awID YDH:(NSString *)YDH{
//
//    AddBZVC *addvc = [[AddBZVC alloc] init];
//
//    addvc.block = ^{
//
//        [self requestData];
//    };
//
//    addvc.opeartionModel = self.opeationModel;
//
//    addvc.MachID = self.deviceModel.machinID;
//
//    addvc.aWID = awID;
//
//    addvc.YDH = YDH;
//
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:addvc];
//
//    nav.modalPresentationStyle = UIModalPresentationFormSheet;
//
//    nav.preferredContentSize = CGSizeMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 100);
//
//    [self presentViewController:nav animated:YES completion:nil];
//}
                     
                     

@end

//
//  ControlAlertView.m
//  MyTYT
//
//  Created by Fly on 2018/8/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ControlAlertView.h"
#import "ControlTop.h"
#import "Controlbootom.h"
#import "Masonry.h"
#import "controlCell.h"
#import "ControlTwobtnView.h"

#define distance kuan *0.38

@interface ControlAlertView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UIView *contentView;

@property (nonatomic) ControlTop *top;

@property (nonatomic) Controlbootom *bottom;

@property (nonatomic) ControlTwobtnView *TwoView;

@property (nonatomic) UITableView *tableview;

@property (nonatomic) NSArray *dataArray;

@property (nonatomic) NSString *topTitle;

@property (nonatomic) NSString *bottomTitle;

@property (nonatomic,copy) ControlSureBlock sure;

@property (nonatomic,copy) ControlCanCelBlock cancel;

@end

@implementation ControlAlertView

+ (void)showControlAleratViewWithArray:(NSArray *)dataArray
                                  type:(ControlType)type
                              toptitle:(NSString *)topTitle
                           bottomTitle:(NSString *)bottomTitle
                                  sure:(ControlSureBlock)sure
                                cancel:(ControlCanCelBlock)cancel{
    
    ControlAlertView *aleartView = [[ControlAlertView alloc] init];
    
    aleartView.dataArray = dataArray;
    
    aleartView.topTitle = topTitle;
    
    aleartView.bottomTitle = bottomTitle;
    
    aleartView.sure = sure;
    
    aleartView.cancel = cancel;
    
    aleartView.type = type;
    
    [aleartView Show];
}

- (void)Show{
    
    [self creatUI];
    
    [self showAnimation];
    
}

- (void)creatUI{
    [self addSubview:self.contentView];
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(distance));
    }];
    
    [self.top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@50);
    }];
    
    CGFloat tableviewHeight = self.dataArray.count*80> gao*0.5 ?gao *0.5 : self.dataArray.count *80;
    
    if (self.dataArray.count*80 > gao*0.5) {//布控运单数量大于一半高度，可以滑动
        self.tableview.scrollEnabled = YES;
    }else{
        self.tableview.scrollEnabled = NO;
    }
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.top.mas_bottom);
        make.height.equalTo(@(tableviewHeight));
    }];
    
    
    switch (self.type) {
        case OnlySureBtn:
        {
            [self.bottom mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tableview.mas_bottom);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@45);
                make.bottom.equalTo(self.contentView);
            }];
        }
            break;
            
        case AllBtn:
        {
            [self.TwoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tableview.mas_bottom);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@45);
                make.bottom.equalTo(self.contentView);
            }];
        }
            break;
    }
   
}

- (void)showAnimation{
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    
    [keywindow addSubview:self];
    
    self.frame = keywindow.bounds;
    
    self.contentView.alpha = 0;
    
    self.contentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.9 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{

        self.backgroundColor= [[UIColor blackColor] colorWithAlphaComponent:0.4];

        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);

        self.contentView.alpha = 1;


    } completion:^(BOOL finished) {


    }];

}

- (void)sureEvent{
    [self removeFromSuperview];
    
    self.sure();
}

- (void)cancelEvent{
    [self removeFromSuperview];
    self.cancel();
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [_contentView addSubview:self.top];
        [_contentView addSubview:self.tableview];
        
        
        switch (self.type) {
            case OnlySureBtn:
                {
                    [_contentView addSubview:self.bottom];

                }
                break;
                
            case AllBtn:
            {
                [_contentView addSubview:self.TwoView];

            }
                break;
        }

        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 10;
    }
    return _contentView;
}

- (ControlTop *)top{
    if (!_top) {
        _top = [[ControlTop alloc] init];
        _top.titleLable.text = self.topTitle;
    }
    return _top;
}

- (Controlbootom *)bottom{
    if (!_bottom) {
        _bottom = [[Controlbootom alloc] init];
        [_bottom.btn addTarget:self action:@selector(sureEvent) forControlEvents:UIControlEventTouchUpInside];
        [_bottom.btn setTitle:self.bottomTitle forState:UIControlStateNormal];
    }
    return _bottom;
}

- (ControlTwobtnView *)TwoView{
    if (!_TwoView) {
        _TwoView = [[ControlTwobtnView alloc] init];
        [_TwoView.sureBtn addTarget:self action:@selector(sureEvent) forControlEvents:UIControlEventTouchUpInside];
        [_TwoView.sureBtn setTitle:self.bottomTitle forState:UIControlStateNormal];
        [_TwoView.cancelbtn addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TwoView;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 80;
        _tableview.allowsSelection = NO;
        _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableview registerNib:[UINib nibWithNibName:@"controlCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"controlCellID"];        
    }
    return _tableview;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    controlCell *cell = [tableView dequeueReusableCellWithIdentifier:@"controlCellID" forIndexPath:indexPath];
    [cell loadDataWithModel:self.dataArray[indexPath.row]];
    return cell;
}

@end

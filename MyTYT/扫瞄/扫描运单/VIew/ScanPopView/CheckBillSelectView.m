//
//  CheckBillSelectView.m
//  MyTYT
//
//  Created by zhangyong on 2019/11/4.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "CheckBillSelectView.h"
#import "CheckBillSelectedCell.h"
#import "ScanModel.h"
#import "CheckBIllselectHeaderView.h"


@interface CheckBillSelectView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *view_background;

@property (nonatomic,strong) UIView *view_contain;
@property (nonatomic,strong) UIButton *btn_back;
@property (nonatomic,strong) UILabel *label_title;

@property (nonatomic,strong) UITableView *tableView;

@end
@implementation CheckBillSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}

-(void)showBillSelectViewWithSuperView:(UIView *)superView{
    
    if (superView != nil) {
        self.frame = CGRectMake(0, 0, superView.bounds.size.width, superView.bounds.size.height);
        [superView addSubview:self];
    }else{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [window addSubview:self];
    }
    self.view_background.alpha = 0;
    self.view_contain.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.view_background.alpha = 0.3;
        self.view_contain.alpha = 1;
    }];
}
-(void)hiddenBillSelectView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view_background.alpha = 0;
        self.view_contain.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.tableView reloadData];
}

-(void)setUpUI{
    
       [self addSubview:self.view_background];
       [self addSubview:self.view_contain];
    
       //contain
       [self.view_contain addSubview:self.btn_back];
       [self.view_contain addSubview:self.label_title];
       [self.view_contain addSubview:self.tableView];
    
       [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(CheckBillSelectedCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(CheckBillSelectedCell.class)];
       self.dataSource = @[].mutableCopy;
       
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self laySubViews];
}

-(void)laySubViews{
    
    [self.view_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    CGFloat bottomHeight = 50;
    CGFloat viewContainHeight = 10+20+15+ 35+10 + 10+bottomHeight ;
    if (self.dataSource.count>0) {
        viewContainHeight =  10+20+15+ self.dataSource.count*35+10 +10 +bottomHeight;
    }
    [self.view_contain mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(300);
        make.height.mas_equalTo(viewContainHeight);
        make.center.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
    }];
    
    [self.btn_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view_contain).offset(15);
        make.top.equalTo(self.view_contain).offset(10);
        make.width.height.mas_equalTo(15);
    }];
    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.centerY.equalTo(self.btn_back.mas_centerY);
        make.centerX.equalTo(self.view_contain);
        make.height.mas_equalTo(20);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_title.mas_bottom).offset(15);
        make.bottom.left.right.equalTo(self.view_contain);
    }];
}


#pragma mark- UITableViewDelgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CheckBIllselectHeaderView *headerView = [[CheckBIllselectHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 35)];
    return headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CheckBillSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CheckBillSelectedCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row<self.dataSource.count) {
        ScanBillModel *billModel = self.dataSource[indexPath.row];
        
        cell.label_allBillNum.text = billModel.waybill.waybillno;
        cell.label_fendanHao.text = billModel.subWaybill.waybillno;
        cell.label_daiLI.text = billModel.waybill.agentOprn;
        WEAK_SELF;
        cell.selectedBlock = ^(BOOL isSelect) {
            [self hiddenBillSelectView];
            weakSelf.didSeleced(billModel);
        };
    }
    return cell;
}
#pragma mark- click
-(void)backClick{
    
    [self hiddenBillSelectView];
}

-(void)btnGetClick{
    
//    [[REGiftViewModel alloc] requestGetGiftWitGiftModel:self.giftModel Complete:^(BOOL isFinished,NSString *errmsg) {
//        if (isFinished) {
//            [MBProgressHUD toastMessageAtMiddle:@"领取成功"];
//        }
//    }];
}


#pragma mark- lazy
-(UIView *)view_background{
    if (!_view_background) {
        _view_background = [UIView new];
        _view_background.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tapGest= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBillSelectView)];
        [_view_background addGestureRecognizer:tapGest];
    }
    return _view_background;
}
-(UIView *)view_contain{
    if (!_view_contain) {
        _view_contain = [UIView new];
        _view_contain.backgroundColor = [UIColor whiteColor];
        _view_contain.layer.cornerRadius = 8;
        _view_contain.layer.masksToBounds = YES;
    }
    return _view_contain;
}

-(UIButton *)btn_back{
    if (!_btn_back) {
        _btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_back setBackgroundImage:[UIImage imageNamed:@"hp_icon_back_a"] forState:UIControlStateNormal];
//        [_btn_back setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        [_btn_back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_back;
}


-(UILabel *)label_title{
    if (!_label_title) {
        _label_title = [UILabel new];
        _label_title.text = @"选择分单";
        _label_title.font = [UIFont systemFontOfSize:16];
        _label_title.textColor = Color333333;
        _label_title.textAlignment = NSTextAlignmentCenter;
    }
    return _label_title;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
        //        if (@available(iOS 11.0, *)){
        //            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //        }
        _tableView.contentInset = UIEdgeInsetsZero;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

@end

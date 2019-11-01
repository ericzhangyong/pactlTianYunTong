//
//  twentyAletartView.m
//  MyTYT
//
//  Created by Fly on 2018/7/3.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "twentyAletartView.h"
#import "twentyAleartCell.h"
#import "NSString+Helper.h"

@interface twentyAletartView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) TwentyAleartSuccessBlock successblock;

@property (nonatomic) NSString *title;

@property (nonatomic) NSString *subtitle;

@property (nonatomic) NSAttributedString *subAttributeStr;

@property (nonatomic) UITableView *tableview;

@end

@implementation twentyAletartView

+ (instancetype)showViewWithTitle:(NSString *)title subtitle:(NSString *)subtitle success:(TwentyAleartSuccessBlock)success{
    
    return [[twentyAletartView alloc] initWithTitle:title subtitle:subtitle success:success];
}

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle success:(TwentyAleartSuccessBlock)success{
    
    if (self = [super init]) {
        
        self.title = title;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.lineSpacing = 5;
        
        style.alignment = NSTextAlignmentLeft;
        
        self.subtitle = subtitle;
        
        NSMutableAttributedString *str  = [[NSMutableAttributedString alloc] initWithString:subtitle attributes:@{
                                                                                                                  NSParagraphStyleAttributeName:style,
                                                                                                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:22]
                                                                                                                  
                                                                                                                  
                                                                                                                  }];
        
       
        self.subAttributeStr = str;
        
        self.successblock = success;
        
        [self creatUI];
        
        [self addAniamtion];
    }
    return self;
    
}


- (void)addAniamtion{
    
    self.tableview.alpha = 0;
    self.tableview.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.9 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.tableview.transform = CGAffineTransformMakeScale(1, 1);
        self.tableview.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)creatUI{
    
    [self addSubview:self.tableview];
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    
    [keywindow addSubview:self];
    
    self.frame = [UIScreen mainScreen].bounds;
    
    CGFloat width = kuan *0.45;
    
    CGFloat titleheight = [NSString autoHeightWithString:self.title Width:width-50 Font:[UIFont boldSystemFontOfSize:20]];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.lineSpacing = 5;
    
    CGFloat subHeight = [NSString autoHeightWithString:self.subtitle Width:width-30 Font:[UIFont boldSystemFontOfSize:22] paragh:style];
    
    CGFloat BtnHeight = 50;
    
    CGFloat height = BtnHeight + titleheight + subHeight + 70;
    
    height = height > gao *0.5 ? gao *0.5 : height;
    
    self.tableview.frame = CGRectMake(0, 0, width, height);
    
    self.tableview.center = self.center;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerNib:[UINib nibWithNibName:@"twentyAleartCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([twentyAleartCell class])];
        _tableview.estimatedRowHeight = 200;
        _tableview.layer.cornerRadius = 10;
        _tableview.layer.masksToBounds = YES;
        _tableview.scrollEnabled = YES;
        _tableview.allowsSelection = NO;
    }
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    twentyAleartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([twentyAleartCell class]) forIndexPath:indexPath];
    cell.title.text = self.title;
    
    cell.subtitle.attributedText =self.subAttributeStr;
    [cell.sureBtn addTarget:self action:@selector(sureEvent) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)sureEvent{
    
    [self backEvent];
    
    self.successblock();
}

- (void)backEvent{
    [self removeFromSuperview];
}



@end

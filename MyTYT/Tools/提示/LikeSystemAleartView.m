//
//  LikeSystemAleartView.m
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LikeSystemAleartView.h"
#import "LikeCell.h"
#import "NSString+Helper.h"

@interface LikeSystemAleartView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) ClickSuccessBlock successblock;

@property (nonatomic,copy) ClickCancelBlock cancelBlock;

@property (nonatomic) NSString *title;

@property (nonatomic) NSString *subtitle;

@property (nonatomic) NSAttributedString *subAttributeStr;

@property (nonatomic) UITableView *tableview;

@property (nonatomic) NSString *sureTite;

@end

@implementation LikeSystemAleartView

+ (instancetype)showViewWithTitle:(NSString *)title subtitle:(NSString *)subtitle                         sureTitle:(NSString *)suretitle
 success:(ClickSuccessBlock)success cancel:(ClickCancelBlock)cancel{

    return [[LikeSystemAleartView alloc] initWithTitle:title subtitle:subtitle                         sureTitle:(NSString *)suretitle
 success:success cancel:cancel];
}

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle                         sureTitle:(NSString *)suretitle
 success:(ClickSuccessBlock)success cancel:(ClickCancelBlock)cancel{
    
    if (self = [super init]) {
        
        self.title = title;
        
        self.sureTite = suretitle;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.lineSpacing = 5;
        
        style.alignment = NSTextAlignmentCenter;
        
        self.subtitle = subtitle;
        
        NSMutableAttributedString *str  = [[NSMutableAttributedString alloc] initWithString:subtitle attributes:@{
                                                                                                NSParagraphStyleAttributeName:style,
                                                                                                NSFontAttributeName:[UIFont boldSystemFontOfSize:19]
                                                                                        
                                                                            
                                                                                                }];
        
        [str addAttributes:@{
                             NSForegroundColorAttributeName:NavColor,
                             NSFontAttributeName:[UIFont boldSystemFontOfSize:22]
                             } range:NSMakeRange(0, 12)];
        
        self.subAttributeStr = str;
        
        self.successblock = success;
        
        self.cancelBlock = cancel;
        
        [self creatUI];
        
        [self addAniamtion];
    }
    return self;
    
}

- (void)cancelEvent{
    
    [self backEvent];

    self.cancelBlock();
}

- (void)sureEvent{
    
    [self backEvent];
    
    self.successblock();
}

- (void)backEvent{
    
//    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.9 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
//
//        self.backgroundColor = [UIColor clearColor];
//        self.tableview.transform = CGAffineTransformMakeScale(0.15, 0.15);
//        self.tableview.alpha = 0;
//
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//
//    }];
//
    [self removeFromSuperview];
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
    
    CGFloat width = kuan *0.28;
    
    CGFloat titleheight = [NSString autoHeightWithString:self.title Width:width-50 Font:[UIFont boldSystemFontOfSize:18]];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.lineSpacing = 5;
    
    CGFloat subHeight = [NSString autoHeightWithString:self.subtitle Width:width-30 Font:[UIFont boldSystemFontOfSize:19] paragh:style];
    
    CGFloat BtnHeight = 45;
    
    CGFloat height = BtnHeight + titleheight + subHeight + 55;
    
    self.tableview.frame = CGRectMake(0, 0, width, height);
    
    self.tableview.center = self.center;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerNib:[UINib nibWithNibName:@"LikeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([LikeCell class])];
        _tableview.estimatedRowHeight = 200;
        _tableview.layer.cornerRadius = 10;
        _tableview.layer.masksToBounds = YES;
        _tableview.scrollEnabled = NO;
        _tableview.allowsSelection = NO;
    }
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LikeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LikeCell class]) forIndexPath:indexPath];
    cell.Mytitlelable.text = self.title;
    
    cell.mysubtitleLable.attributedText =self.subAttributeStr;
    [cell.cancelBtn addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];
    [cell.sureBtn addTarget:self action:@selector(sureEvent) forControlEvents:UIControlEventTouchUpInside];
    [cell.sureBtn setTitle:self.sureTite forState:UIControlStateNormal];
    return cell;
}



@end

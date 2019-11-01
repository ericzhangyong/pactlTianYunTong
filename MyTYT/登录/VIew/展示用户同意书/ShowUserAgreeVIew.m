//
//  ShowUserAgreeVIew.m
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "ShowUserAgreeVIew.h"
#import "Masonry.h"
#import "ShowUserCell.h"
#import "ShowUserBootomView.h"
#import "ShowUserTopView.h"
#import "ShutBottomView.h"

@interface ShowUserAgreeVIew ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tablview;

@property (nonatomic) ShowUserBootomView *bottomview;

@property (nonatomic) ShutBottomView *shutBootoomView;

@property (nonatomic) ShowUserTopView *topView;

@property (nonatomic) UIView *contentView;

@property (nonatomic) NSString *subtitle;

@property (nonatomic,copy) UserAgreeBlock agree;

@property (nonatomic,copy) UserDontAgreeBlock dontagree;

@property (nonatomic,assign) OpeartionTYpe type;

@property (nonatomic) NSString *title;

@end

@implementation ShowUserAgreeVIew

+ (void)showUserTitle:(NSString *)title content:(NSString *)content type:(OpeartionTYpe)type agree:(UserAgreeBlock)agree dontAgree:(UserDontAgreeBlock)dontagree{
    
    ShowUserAgreeVIew *agreeview = [[ShowUserAgreeVIew alloc] init];
    
    agreeview.title = title;
    
    agreeview.subtitle = content;
    
    agreeview.agree = agree;
    
    agreeview.dontagree = dontagree;
    
    agreeview.type = type;
    
    [agreeview showUserAgreeView];
}

- (void)showUserAgreeView{
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    
    self.frame = [UIScreen mainScreen].bounds;
    
    [self creatUI];
    
    [keywindow addSubview:self];
    
    [self showanimation];
}

- (void)showanimation{
    
    self.contentView.transform = CGAffineTransformMakeScale(0.65, 0.65);
    self.contentView.alpha = 0;
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        self.contentView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismissAnimation{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
  
}

- (void)sureEvent{
    
    [self dismissAnimation];
    
    self.agree();
}

- (void)cancelEvent{
    [self dismissAnimation];

    self.dontagree();
}

#pragma mark------------------------------------------------------------------------------------
- (void)creatUI{
    [self addSubview:self.contentView];
   
    [self layout];
}

- (void)layout{
    
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(100, 100, 100, 100));
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@80);
    }];
    
    switch (self.type) {
        case SelectOpertionType:
            {
                [_bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.left.bottom.equalTo(self.contentView);
                    make.height.equalTo(@90);
                }];
                
                
                [_tablview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.bottomview);
                    make.top.equalTo(self.topView.mas_bottom);
                    make.bottom.equalTo(self.bottomview.mas_top);
                }];
            }
            break;
            
        case ShowOperationType:
        {
            [_shutBootoomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.bottom.equalTo(self.contentView);
                make.height.equalTo(@90);
            }];
            
            [_tablview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.shutBootoomView);
                make.top.equalTo(self.topView.mas_bottom);
                make.bottom.equalTo(self.shutBootoomView.mas_top);
            }];
        }
            break;
    }
    

 
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        
        if (self.type == SelectOpertionType) {
            [_contentView addSubview:self.bottomview];

        }else if (self.type == ShowOperationType){
            [_contentView addSubview:self.shutBootoomView];
        }
        
        [_contentView addSubview:self.tablview];
        [_contentView addSubview:self.topView];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 5;
    }
    
    return _contentView;
}

- (ShowUserBootomView *)bottomview{
    if (!_bottomview) {
        _bottomview = [[ShowUserBootomView alloc] init];
        [_bottomview.surebtn addTarget:self action:@selector(sureEvent) forControlEvents:UIControlEventTouchUpInside];
        [_bottomview.cancelbtn addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];

    }
    return _bottomview;
}

- (ShutBottomView *)shutBootoomView{
    if (!_shutBootoomView) {
        _shutBootoomView = [[ShutBottomView alloc] init];
        [_shutBootoomView.surebtn addTarget:self action:@selector(sureEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shutBootoomView;
}

- (ShowUserTopView *)topView{
    if (!_topView) {
        _topView = [[ShowUserTopView alloc] init];
        _topView.lable.text = self.title;
    }
    return _topView;
}

- (UITableView *)tablview{
    if (!_tablview) {
        _tablview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tablview.delegate = self;
        _tablview.dataSource = self;
        _tablview.estimatedRowHeight = 300;
        _tablview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tablview.backgroundColor = [UIColor whiteColor];
        _tablview.allowsSelection = NO;
        _tablview.tableFooterView = [[UIView alloc] init];
        _tablview.tableHeaderView = [[UIView alloc] init];

        if (@available(iOS 11.0, *)) {
            _tablview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [_tablview registerNib:[UINib nibWithNibName:@"ShowUserCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ShowUserCellID"];
    }
    return _tablview;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShowUserCellID" forIndexPath:indexPath];
    cell.subtitle.text = self.subtitle;
    
   

    return cell;
}
@end

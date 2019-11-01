//
//  FLyAleartView.m
//  WHT
//
//  Created by Fly on 2018/4/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "FLyAleartView.h"
#import "FlyAleartCell.h"
#import "NSString+Helper.h"

#define sizekuan (kuan * 0.38)

@interface FLyAleartView ()

@property (nonatomic) NSString *title;

@property (nonatomic) NSString *subtitle;

@property (nonatomic) NSString *suretitle;

@property (nonatomic,assign) CGFloat imageHeitht;

@property (nonatomic,copy) FlyAleartOkBlock okblock;

@property (nonatomic) NSString *ImageName;

@end

@implementation FLyAleartView

- (void)dealloc{
    FlyLog(@"警告delloc");
}


+ (void)showAleartViewWithtitle:(NSString *)title
                       subtitle:(NSString *)subtitle
                      imageName:(NSString *)imageName
                      suretitle:(NSString *)suretitle
                           sure:(FlyAleartOkBlock)sure{
    
    FLyAleartView *aleartview = [[FLyAleartView alloc] init];
    
    aleartview.title = title;
    
    aleartview.subtitle = subtitle;
    
    aleartview.ImageName = imageName;
    
    aleartview.okblock = sure;
    
    aleartview.suretitle = suretitle;
    
    [aleartview setUI];
    
    [aleartview showAnimation];
}

- (void)showAnimation{
    
    self.tablview.alpha = 0;
    
    self.tablview.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:1 initialSpringVelocity:25 options:UIViewAnimationOptionCurveLinear animations:^{

        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.tablview.transform = CGAffineTransformMakeScale(1, 1);

        self.tablview.alpha = 1;

    } completion:^(BOOL finished) {

    }];
    
}

//确定
- (void)sureEvent{
    
    [self dismissAnimation];
    self.okblock();

}

//取消动画
- (void)dismissAnimation{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}


- (void)setUI{
    
    CGFloat titleheight = [NSString autoHeightWithString:self.title Width:sizekuan-40 Font:[UIFont boldSystemFontOfSize:20]];
    
    CGFloat subtitleheight = [NSString autoHeightWithString:self.subtitle Width:sizekuan-40 Font:[UIFont systemFontOfSize:18]];
    
    CGFloat btnheight = 50;
    
    CGFloat kxHeight = 110;
    
    CGFloat height = titleheight + subtitleheight  + btnheight + kxHeight +self.imageHeitht;
    
    self.tablview.frame = CGRectMake(80, 0, sizekuan, height);
    
    self.tablview.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    self.frame = [UIScreen mainScreen].bounds;
    
    self.tablview.center = self.center;
    
    self.backgroundColor =[UIColor clearColor];
    
    [self addSubview:self.tablview];
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    
    [keywindow addSubview:self];
    
}

- (CGFloat)imageHeitht{
    
    UIImage *image = [UIImage imageNamed:self.ImageName];
    
    CGSize newsize;

    newsize.width = sizekuan;
    
    newsize.height = (image.size.height /image.size.width) * newsize.width ;
    
    return newsize.height;
}

#pragma mark------------------------------------------------------------------------------------
- (UITableView *)tablview{
    if (!_tablview) {
        _tablview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tablview.delegate = self;
        _tablview.dataSource = self;
        _tablview.layer.cornerRadius = 10;
        _tablview.layer.masksToBounds = YES;
        
        _tablview.backgroundColor = [UIColor whiteColor];
        _tablview.estimatedRowHeight = 300;
        _tablview.showsVerticalScrollIndicator = NO;
        _tablview.scrollEnabled = NO;
        _tablview.allowsSelection = NO;
        if (@available(iOS 11.0, *)) {
            _tablview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [_tablview registerNib:[UINib nibWithNibName:@"FlyAleartCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FlyAleartCellID"];
    }
    return _tablview;
}

#pragma mark------------------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FlyAleartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlyAleartCellID" forIndexPath:indexPath];
    cell.title.text = self.title;
    cell.subtitle.text = self.subtitle;
    [cell.sureBtn addTarget:self action:@selector(sureEvent) forControlEvents:UIControlEventTouchUpInside];
    [cell.sureBtn setTitle:self.suretitle forState:UIControlStateNormal];
    cell.contantImage.constant = self.imageHeitht;
    cell.showimageView.image = [UIImage imageNamed:self.ImageName];
    return cell;
}

@end

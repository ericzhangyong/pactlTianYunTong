//
//  FLyAleartView.h
//  WHT
//
//  Created by Fly on 2018/4/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FlyAleartOkBlock)(void);
typedef void(^FlyAleartCancelBlock)(void);

@interface FLyAleartView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UITableView *tablview;

+ (void)showAleartViewWithtitle:(NSString *)title
                       subtitle:(NSString *)subtitle
                      imageName:(NSString *)imageName
                      suretitle:(NSString *)suretitle
                           sure:(FlyAleartOkBlock)sure;


@end

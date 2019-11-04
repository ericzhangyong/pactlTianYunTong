//
//  CheckBillSelectView.h
//  MyTYT
//
//  Created by zhangyong on 2019/11/4.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckBillSelectView : UIView


-(void)showBillSelectViewWithSuperView:(UIView *)superView;
-(void)hiddenBillSelectView;
/**  */
@property (nonatomic,copy) NSArray *dataSource;

@property (nonatomic,copy) void(^didSeleced)(ScanBillModel *billModel);

@end

NS_ASSUME_NONNULL_END

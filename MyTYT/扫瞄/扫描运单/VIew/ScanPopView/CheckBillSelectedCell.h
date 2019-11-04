//
//  CheckBillSelectedCell.h
//  MyTYT
//
//  Created by zhangyong on 2019/11/4.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckBillSelectedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_fendanHao;
@property (weak, nonatomic) IBOutlet UILabel *label_allBillNum;
@property (weak, nonatomic) IBOutlet UILabel *label_daiLI;
@property (weak, nonatomic) IBOutlet UIButton *btn_selected;


@property (nonatomic,copy) void(^selectedBlock)(BOOL isSelect);


@end

NS_ASSUME_NONNULL_END

//
//  FlyAleartCell.h
//  WHT
//
//  Created by Fly on 2018/4/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlyAleartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contantImage;
@property (weak, nonatomic) IBOutlet UIImageView *showimageView;


@end

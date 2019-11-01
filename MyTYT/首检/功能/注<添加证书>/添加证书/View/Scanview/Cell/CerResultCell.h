//
//  CerResultCell.h
//  MyTYT
//
//  Created by Fly on 2018/6/5.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowCerModel;

@interface CerResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Mytitlelable;
@property (weak, nonatomic) IBOutlet UILabel *mytextlable;

- (void)loaddataWithModel:(ShowCerModel *)mdoel;

@end

//
//  NewBzChPMCell.h
//  MyTYT
//
//  Created by zhangyong on 2019/12/28.
//  Copyright © 2019 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewBzChPMCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_chPinMing;

- (void)loaddataWithModel:(NewBZModel *)model;

@end

NS_ASSUME_NONNULL_END

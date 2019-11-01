//
//  NewBZBZCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewBZModel;


@interface NewBZBZCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *bzBtn;

- (void)loaddataWithModel:(NewBZModel *)mdoel;

@end

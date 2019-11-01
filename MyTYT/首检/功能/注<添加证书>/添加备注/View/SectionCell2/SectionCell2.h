//
//  SectionCell2.h
//  MyTYT
//
//  Created by Fly on 2018/5/2.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BZAddModel;
@interface SectionCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *takephotoBtn;
@property (weak, nonatomic) IBOutlet UITextView *textVIew;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIView *TakeView;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (void)loaddataWithModel:(BZAddModel *)model;
@end

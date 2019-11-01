//
//  InputCell.h
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (weak, nonatomic) IBOutlet UILabel *scantypelable;

- (void)loadtitle:(NSString *)title;

@end

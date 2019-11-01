//
//  newbzWZCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newbzWZCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lable;

- (void)loaddataWithStr:(NSString *)str;

@end

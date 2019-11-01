//
//  ShowShareCell.h
//  MyTYT
//
//  Created by Fly on 2018/6/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowShareCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerview;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

- (void)loadImageWithURlStr:(NSString *)urlStr;

@end

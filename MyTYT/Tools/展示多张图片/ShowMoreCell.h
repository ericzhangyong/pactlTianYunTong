//
//  ShowMoreCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMoreCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerview;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
- (void)loadImageWithURlStr:(NSString *)urlStr;
@end

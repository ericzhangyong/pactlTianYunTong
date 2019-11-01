//
//  CerCollectionCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CerCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cerImageView;

- (void)loadimageWithUrl:(NSString *)Url;

@end

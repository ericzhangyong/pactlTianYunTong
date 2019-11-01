//
//  AddBZcollectionviewcell.h
//  MyTYT
//
//  Created by Fly on 2018/6/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBZcollectionviewcell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

//条目加载图片url
- (void)loadimgaeviewWith:(NSString *)filePath;

//拍照加载图片数据
- (void)loadImageViewWithPicData:(NSData *)data;

@end

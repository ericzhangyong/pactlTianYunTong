//
//  ShowMoreImageView.h
//  MyTYT
//
//  Created by Fly on 2018/5/4.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMoreImageView : UIView

//直接展示不带动画
+ (instancetype)showImageViewWithImageUrlArray:(NSArray *)urlarray selcectIndex:(NSInteger)selectIndex;

//动画用
+ (instancetype)showImageViewWithImageUrlArray:(NSArray *)urlarray selcectIndex:(NSInteger)selectIndex FrameArray:(NSArray *)frameArray;



@end

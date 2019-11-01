//
//  ShowShareImageView.h
//  MyTYT
//
//  Created by Fly on 2018/6/7.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowShareImageView : UIView

//展示代理用
+ (instancetype)showImageViewWithImageUrlArray:(NSArray *)urlarray selcectIndex:(NSInteger)selectIndex FrameArray:(NSArray *)frameArray AgentArray:(NSArray *)agentArray;

@end

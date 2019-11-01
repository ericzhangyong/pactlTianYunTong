//
//  LoadDataFailView.h
//  HWCBZT
//
//  Created by Fly on 2017/9/28.
//  Copyright © 2017年 Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoadFailViewBlcok)(void);
@interface LoadDataFailView : UIView

@property (nonatomic) UILabel *lable;

@property (nonatomic) UIImageView *imageview;

@property (nonatomic) UIButton *btn;

@property (nonatomic, copy) LoadFailViewBlcok myblock;

//展示失败view
+ (void)ShowLoadFailViewWith:(UIView *)superView frame:(CGRect)frame clickBtn:(LoadFailViewBlcok)block;

//移除存在的加载失败view
+ (void)removefromViewWith:(UIView *)superView;

@end

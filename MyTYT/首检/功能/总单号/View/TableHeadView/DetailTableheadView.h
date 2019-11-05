//
//  DetailTableheadView.h
//  MyTYT
//
//  Created by Fly on 2018/5/18.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class infoModel;
@class DeatilTstModel;
@class GPModel;
@class CheckModel;

@interface DetailTableheadView : UIView

@property (nonatomic) UILabel *danhaoLable;

@property (nonatomic) UILabel *TestLable;

@property (nonatomic) UILabel *YDHLable;

@property (nonatomic) UILabel *EleLable;

@property (nonatomic) UILabel *GPLable;

@property (nonatomic) UILabel *DaiLIlable;

@property (nonatomic) UILabel *AgentLable;

@property (nonatomic) UILabel *TypeLable;
@property (nonatomic) UILabel *label_9610icon;


@property (nonatomic) UILabel *controlLable;

@property (nonatomic) UILabel *ABcontrolLable;

- (void)setDataWithInfoModel:(infoModel *)indomodel testModel:(DeatilTstModel *)testModel gpModel:(GPModel *)gpModel testWord:(NSString *)testWord checkModel:(CheckModel *)checkModel AgentShortName:(NSString *)agentShorName iscontrol:(BOOL)iscontrol isABControl:(BOOL)isABcontrol detectionType:(DetectionType)detectionType;

@end

//
//  TwentyCell.h
//  MyTYT
//
//  Created by Fly on 2018/5/21.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwentyModel;

@interface TwentyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mytextlable;

@property (weak, nonatomic) IBOutlet UILabel *XHLable;
@property (weak, nonatomic) IBOutlet UIImageView *NewImageView;
@property (weak, nonatomic) IBOutlet UILabel *DLLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textlableConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *JJConstant;
@property (weak, nonatomic) IBOutlet UIButton *YDHBTn;
@property (weak, nonatomic) IBOutlet UILabel *EleLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *EleContant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *EleDistanceConstant;
@property (weak, nonatomic) IBOutlet UILabel *MDGLable;
@property (weak, nonatomic) IBOutlet UILabel *JSZLLable;
@property (weak, nonatomic) IBOutlet UIButton *ZSBtn;
@property (weak, nonatomic) IBOutlet UIButton *BZBtn;
@property (weak, nonatomic) IBOutlet UIButton *AgreeBtn;
@property (weak, nonatomic) IBOutlet UIView *AgreecountView;
@property (weak, nonatomic) IBOutlet UILabel *agreeCoutLable;
@property (weak, nonatomic) IBOutlet UIButton *WaitBtn;
@property (weak, nonatomic) IBOutlet UIView *WaitCountView;
@property (weak, nonatomic) IBOutlet UILabel *WaitCountLable;
@property (weak, nonatomic) IBOutlet UIView *TypeView;
@property (weak, nonatomic) IBOutlet UIButton *RoadBtn;
@property (weak, nonatomic) IBOutlet UITextField *RoadTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *AJJTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *AJJBtn;
@property (weak, nonatomic) IBOutlet UILabel *typelable;
@property (weak, nonatomic) IBOutlet UIView *typebackView;
@property (weak, nonatomic) IBOutlet UIView *controlView;

- (void)loaddataWithModel:(TwentyModel *)model row:(NSInteger)row;

@end

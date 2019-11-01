//
//  WriteScanCell.h
//  MyTYT
//
//  Created by Fly on 2018/6/8.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanModel;

@interface WriteScanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *XHLAble;
@property (weak, nonatomic) IBOutlet UILabel *YDHLAble;
@property (weak, nonatomic) IBOutlet UILabel *DLLAble;
@property (weak, nonatomic) IBOutlet UILabel *MDGLAble;
@property (weak, nonatomic) IBOutlet UILabel *JSZLLAble;
@property (weak, nonatomic) IBOutlet UILabel *stateLable;
@property (weak, nonatomic) IBOutlet UIView *BKAJView;
@property (weak, nonatomic) IBOutlet UILabel *MSGLable;

@property (weak, nonatomic) IBOutlet UIImageView *BackImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableTopConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableBootomConstant;

@property (weak, nonatomic) IBOutlet UILabel *elelable;
@property (weak, nonatomic) IBOutlet UIImageView *eleimageVIew;

@property (weak, nonatomic) IBOutlet UIView *controlBackView;
@property (weak, nonatomic) IBOutlet UIImageView *controlImageivew;
@property (weak, nonatomic) IBOutlet UILabel *controlLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *controlLableTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *controllableBootom;


@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastHeight;

- (void)loaddataWithModel:(ScanModel *)model row:(NSInteger)row;

@end
